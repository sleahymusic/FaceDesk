integer gMyCh;    // Baby penguin's unique channel
integer HANDSHAKE_CHAN = -8910;    // handshake channel for following another penguin

integer gFollowAnyone = FALSE;
integer gListenkey;
integer gListenkeyb;
integer gRoam = FALSE;
string    gMom;    // UUID for either the owner or the mama penguin
rotation gMomRot;
vector gMomPos;
list    gAnimnames;
string    gLastAnimation;
string    gCurrAnimation;
string ratanim;
integer gSound = TRUE;
integer gFollowElephant = FALSE;

integer gStill;

vector        gStartPos;
rotation    gStartRot;
integer        gReturning = FALSE;

list EXCLUDED_LIST = ["RatWalkRoam", "RatWalk", "Standing", "RatTurnRoam", "RatRunRoam", "RatRun", "RatTurn", "RatWalk", "ArmOverrideDances", "StandingRoam", "Tail1", "TailSit1", "TailSit3"];
string gActionState = "";

integer    gCount = 0;
float    BOUNDARY_DIST = 15;    // how far the baby will follow from its own starting position


float    gPosX;
float    gPosY;
float    X_OFFSET = -2.0; // usually tyhis far back
float    Y_OFFSET = .0;   // rugth in the mioddle

float   TAU = 0.2;
vector    POSITION_OFFSET  = <0.0, 0.75, -0.8>; // Local coords
vector    FLY_OFFSET =  <2.0, -2.75, 0.0>;
vector    FLYANGLE = <80, 0, 10>;
float    DAMP = 8;        // damping for flight
float    TURNSPEED = 10.0;

string    FWD_DIRECTION   = "-y";
float    MOVETO_INCREMENT    = 3.0;
 ///////////// END CONSTANTS /////////////////

vector getpos(key i) {
    return llList2Vector(llGetObjectDetails(i,[OBJECT_POS]),0);
}

rotation getrot(key i) {
    return llList2Rot(llGetObjectDetails(i,[OBJECT_ROT]),0);
}
get_agent()  {
    list keys = llGetAgentList(AGENT_LIST_PARCEL, []);
    integer numberOfKeys = llGetListLength(keys);

    vector currentPos = llGetPos();
    list newkeys;
    key thisAvKey;

    integer i;
    for (i = 0; i < numberOfKeys; ++i) {
        thisAvKey = llList2Key(keys,i);
        newkeys += [llRound(llVecDist(currentPos,
                        llList2Vector(llGetObjectDetails(thisAvKey, [OBJECT_POS]), 0))),
                    thisAvKey];
    }

    newkeys = llListSort(newkeys, 2, TRUE);     //  sort strided list by descending distance

    gMom = (llList2Key(newkeys, 1));

}
// This method is called inside a short timer loop when the baby penguin
//   is in the following state.
do_rat_things() {
    // find mom
    vector momPos = getpos(gMom);
    // is mom on-sim
    if (llVecDist(momPos, ZERO_VECTOR) > .01) {
        rotation momRot = getrot(gMom);
        vector size;
        float var;
        rotation TargetRot;

        if (gFollowElephant) {
             list box = llGetBoundingBox(gMom);
             size = llList2Vector(box, 1) - llList2Vector(box, 0);
             var = 0.25;
         }
         else {
             size = llGetAgentSize(llGetOwner());
             var = 0.08;
         }

         if ((llGetAnimation(llGetOwner()) == "Flying") || (llGetAnimation(llGetOwner()) == "FlyingSlow")) {
             TargetRot = llEuler2Rot(FLYANGLE * DEG_TO_RAD) * GetRotation(momRot);
             POSITION_OFFSET = FLY_OFFSET;
         }
         else {
             TargetRot = GetRotation(momRot);

             // update randomly sometimes
             if (llFrand(4) < 1) {
                 gPosX = randBetween(0,X_OFFSET);
                 gPosY = randBetween(0,1);
                 if (llFrand(1) > 0.5)
                     gPosY = -gPosY;
             }
             POSITION_OFFSET = <gPosX , gPosY, (-size.z / 2) + var>;
         }

         vector Offset = POSITION_OFFSET * momRot;
         momPos += Offset;

         if (llVecDist(gStartPos,momPos) > BOUNDARY_DIST) {
             if (gReturning) {

                 gReturning = FALSE;
             }
             //llLookAt(gStartPos,TAU * TURNSPEED, TAU);
             llRotLookAt(gStartRot, TAU * TURNSPEED, TAU);
             llMoveToTarget(gStartPos, TAU * DAMP);
         }
         else {
             if (!gReturning) {

                 gReturning = TRUE;
             }
             //llLookAt(Pos,TAU * TURNSPEED, TAU);
             llRotLookAt(TargetRot, TAU * TURNSPEED, TAU);
             llMoveToTarget(momPos, TAU * DAMP);
         }
     }
}

float randBetween(float min, float max) {
    return llFrand(max - min) + min;
}

//MoveTo(vector target) {
//    vector Pos = llGetPos();
//    while(llVecDist(Pos, target) > MOVETO_INCREMENT) {
//        Pos += llVecNorm(target - Pos) * MOVETO_INCREMENT;
//        llSetPos(Pos);
//    }
//    llSetPos(target);
//}

rotation GetRotation(rotation rot) {
    // Special case... 180 degrees gives a math error
    if (FWD_DIRECTION == "x") {
        return llAxisAngle2Rot(<0, 0, 1>, PI);
    }
    string Direction = llGetSubString(FWD_DIRECTION, 0, 0);
    string Axis = llToLower(llGetSubString(FWD_DIRECTION, 1, 1));

    vector Fwd;
    if (Axis == "x") Fwd = <1, 0, 0>;
    else if (Axis == "y") Fwd = <0, 1, 0>;
    else Fwd = <0, 0, 1>;

    if (Direction == "-") Fwd *= -1;

    vector currFwd = llRot2Fwd(rot);
    float Angle = llAtan2(currFwd.y, currFwd.x);
    return llRotBetween(Fwd, <0, -1, 0>) * llAxisAngle2Rot(<0, 0, 1>, Angle);
}

llWait(float wait_time) {
    float start_time = llGetGMTclock();
    while (TRUE) {
        float current_time = llGetGMTclock();
        if (current_time >= start_time) {
            if (current_time - start_time >= wait_time) return;
        }
        else {
            if ((86400.0 - start_time) + current_time >= wait_time) return;
        }
    }
}

// Animations with the substring "sit" in their name will NOT be included
loadAnims() {
    gAnimnames = [];
    integer index;
    for (index = 0; index < llGetInventoryNumber(INVENTORY_ANIMATION); ++index) {
        if (llSubStringIndex(llToUpper(llGetInventoryName(INVENTORY_ANIMATION,index)),"ARM") == -1) {
            gAnimnames += llGetInventoryName(INVENTORY_ANIMATION, index);
        }
    }
}

// Only animations with the substring "dance" in their name will be loaded
loadDances() {
    gAnimnames = [];
    integer index;
    for (index = 0; index < llGetInventoryNumber(INVENTORY_ANIMATION); ++index) {
        if (llSubStringIndex(llToUpper(llGetInventoryName(INVENTORY_ANIMATION,index)),"DANCE") != -1) {
            gAnimnames += llGetInventoryName(INVENTORY_ANIMATION, index);
        }
    }
}

// Animations with the substring "sit" in their name will NOT be included
// Animations with the substring "dance" in their name will NOT be loaded
loadNodances() {
    gAnimnames = [];
    integer index;
    for (index = 0; index < llGetInventoryNumber(INVENTORY_ANIMATION); ++index) {
        if (llSubStringIndex(llToUpper(llGetInventoryName(INVENTORY_ANIMATION,index)),"DANCE") == -1) {
            if (llSubStringIndex(llToUpper(llGetInventoryName(INVENTORY_ANIMATION,index)),"ARM") == -1)
                gAnimnames += llGetInventoryName(INVENTORY_ANIMATION, index);
        }
    }
}

stop_all_animations() {
    list curr_anims = llGetObjectAnimationNames();
    integer length = llGetListLength(curr_anims);
    integer index = 0;
    while (index < length) {
        string anim = llList2String(curr_anims, index);
        llStopObjectAnimation(anim);
        ++index;
    }
    llStartObjectAnimation("Tail1");
}

action() {
    if (gActionState == "" || gActionState == "nodances") {
        gActionState = "nodances";
        loadNodances();
        llOwnerSay("starting no dances");
    }
    else if (gActionState == "dances") {
        loadDances();
        llOwnerSay("starting dances");
    }
    else if (gActionState == "animsall") {
        loadAnims();
        llOwnerSay("starting all animations");
    }
    else if (gActionState == "off") {
        stop_all_animations();
        gAnimnames = ["Sitting1", "Standing", "Laying"];
        llOwnerSay("starting OFF animations");
        llSetTimerEvent(0.1);
    }
}

default
{
    on_rez(integer start_param) {
        llResetScript();
    }

    state_entry() {
        // Set up the physics for this object
 //       llSetLinkPrimitiveParamsFast(LINK_ROOT,
//                [PRIM_PHYSICS_SHAPE_TYPE, PRIM_PHYSICS_SHAPE_CONVEX,
//            PRIM_LINK_TARGET, LINK_ALL_CHILDREN,
//                PRIM_PHYSICS_SHAPE_TYPE, PRIM_PHYSICS_SHAPE_NONE]);
        // Determine this baby penguin's unique channel
        gMyCh = -(integer)("0x" + llGetSubString(llGetKey(),3,8));
        state running;
    }
}

state running
{
    on_rez(integer start_param) {
        llResetScript();
    }

    state_entry()
    {
        if(gRoam)
        {
            llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROTATION,gStartRot]);
            llSetLocalRot(ZERO_ROTATION);
            gRoam = FALSE;
        }
        llOwnerSay(gActionState);
        gListenkey = llListen(gMyCh, "", "", "");
        stop_all_animations();
        loadNodances();
        gActionState = "nodances";
        llSetTimerEvent(1);
    }

    touch_start(integer total_number) {
        key ToucherID = llDetectedKey(0);
        if (llDetectedKey(0) == llGetOwner())
            llDialog(ToucherID, "Menu ",["AnimsAll", "Dances", "NoDances", "Off","RoamMenu", "Follow", "Texture", "Reset"], gMyCh);
        else llDialog(ToucherID, "Change texture...", ["White/Tan", "Albino", "Brown", "Grey","Hairless"], gMyCh);
    }

    listen(integer channel, string name, key id, string message) {
        if(message == "Off") {
            stop_all_animations();
            gAnimnames = ["Laying", "Sitting1", "Standing"];
            gActionState = "off";
            gCount = 5;
            // Do the timer event right away... Duration WILL change!
            llSetTimerEvent(0.1);
        }
        else if(message == "AnimsAll") {
            stop_all_animations();
            loadAnims();
            gActionState = "animsall";
            gCount = 0;
            llSetTimerEvent(1);
        }
        else if(message == "Dances") {
            stop_all_animations();
            loadDances();
            gActionState = "dances";
            gCount = 5;
            llSetTimerEvent(1);
        }
        else if(message == "NoDances") {
            stop_all_animations();
            loadNodances();
            gActionState = "nodances";
            gCount = 0;
            llSetTimerEvent(1);
        }
        else if (message == "Reset") llResetScript();
        else if (message == "RoamMenu") {
            llSetTimerEvent(0.0);
            llMessageLinked(LINK_ALL_OTHERS, -1180, "", llGetOwner());
            stop_all_animations();
            state roaming;
        }
        else if (message == "Follow") {
            llSetTimerEvent(0.0);
            stop_all_animations();
            state following;
         }
         else if (message == "Texture") llDialog(id, "Texture menu ",["White/Tan", "Albino", "Brown", "Grey","Hairless"], gMyCh);
        else if(message == "White/Tan") llSetLinkPrimitiveParamsFast(LINK_ROOT,[PRIM_TEXTURE, ALL_SIDES, "a387a103-022f-97f8-a3a6-e5fb9a73291e",  <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        else if(message == "Albino") llSetLinkPrimitiveParamsFast(LINK_ROOT,[PRIM_TEXTURE,  ALL_SIDES,"38d87565-fc0c-938a-ecca-a49ba92a0caa",<1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        else if(message == "Brown") llSetLinkPrimitiveParamsFast(LINK_ROOT,[PRIM_TEXTURE,  ALL_SIDES,"7bdd30ca-9f7c-4f83-c4aa-3101495dcd4e",<1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        else if(message == "Hairless") llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_TEXTURE, ALL_SIDES,"3aa87272-0756-9b40-52e9-510e1209a955",<1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        else if(message == "Grey") llSetLinkPrimitiveParamsFast(LINK_ROOT,[PRIM_TEXTURE,  ALL_SIDES,"f4da8407-e0b4-7f94-81eb-b2fd5d6a2b64",<1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);


    }

    timer() {
        // Clear the current timer
        llSetTimerEvent(0.0);
        integer time = 30;
        // Trigger the sound every other timer event call
        ++gCount;
        if(gCount == 3)
        {
            stop_all_animations();
            llStartObjectAnimation("Standing");
            llMessageLinked(LINK_SET, -2100, "", "");
            integer time = 30;
        }
        else
        {
            if(gCount == 4)
            {
                llMessageLinked(LINK_SET, -2200, "", "");
                gCount = 0;
            }
            stop_all_animations();
            string newAnimation;
            do {
                integer random = (integer)llFrand(llGetListLength(gAnimnames));
                newAnimation = llList2String(gAnimnames, random);
            } while (newAnimation == gLastAnimation || (llListFindList(EXCLUDED_LIST,[newAnimation]) != -1));

            gLastAnimation = gCurrAnimation;
            gCurrAnimation = newAnimation;

            if (llSubStringIndex(llToUpper(gCurrAnimation),"DANCE") != -1)
            {
                llStartObjectAnimation("ArmOverrideDances");
                llStartObjectAnimation(gCurrAnimation);
                llStopObjectAnimation("Tail1");
                llStopObjectAnimation("TailSit1");
                llStartObjectAnimation("TailSit3");
            }
            else if (llSubStringIndex(llToUpper(gCurrAnimation),"SITTING") != -1)
            {
                llStopObjectAnimation("ArmOverrideDances");
                llStopObjectAnimation("TailSit3");
                llStopObjectAnimation("Tail1");
                llStartObjectAnimation(gCurrAnimation);
                llStartObjectAnimation("TailSit1");
            }
            else {
                llStopObjectAnimation("ArmOverrideDances");
                llStopObjectAnimation("TailSit3");
                llStopObjectAnimation("TailSit1");
                llStartObjectAnimation(gCurrAnimation);
                llStartObjectAnimation("Tail1");
            }
        }

        llSetTimerEvent(time + (integer) llFrand (30));
        // Every so often reset gCount so we don't overflow the integer
        if (gCount == 700) gCount = 5;
    }

    changed (integer change) {
       if (change & CHANGED_INVENTORY) {
           llResetScript();
       }
   }
}

state roaming
{
    on_rez(integer start_param) {
        llResetScript();
    }

    state_entry() {
        gStill = TRUE;
        gListenkey = llListen(gMyCh, "", llGetOwner(), "");
        llStartObjectAnimation("StandingRoam");
    }

    touch_start(integer total_number) {
        key ToucherID = llDetectedKey(0);
        if (llDetectedKey(0) == llGetOwner()) llDialog(ToucherID, "Menu ",["RoamMenu"], gMyCh);
    }

    listen(integer channel, string name, key id, string message) {
        if (message == "RoamMenu") {
            llMessageLinked(LINK_ALL_OTHERS, -1180, "", llGetOwner());
        }
    }

    link_message(integer source, integer num, string str, key id) {
        if(num == -100) {
            llStopObjectAnimation("RatTurnRoam");
        }
        if(num == -200) {
            llStopObjectAnimation("RatTurnRoam");
            state running;
        }
    }

    timer() {
        integer speed = (integer)(llVecMag(llGetVel()) * 1.94384449 + 0.5);
        if(speed < .08 && !gStill) {
            llStopObjectAnimation("Standing");
            gStill = TRUE;
        }
        if(speed >= .01) {
            stop_all_animations();
            llStartObjectAnimation("RatWalkRoam");
            gStill = FALSE;
        }
        if(speed >= 7) {
            stop_all_animations();
            llStartObjectAnimation("RatRunRoam");
            gStill = FALSE;
        }
    }
}

state following
{
    on_rez(integer start_param) {
        llResetScript();
    }

    state_entry() {
        gStill = TRUE;
        gListenkeyb = llListen(HANDSHAKE_CHAN, "", "", "");
        llStartObjectAnimation("Standing");

        gListenkey = llListen(gMyCh, "", llGetOwner(), "");
        llDialog(llGetOwner(), "Who would you like me to follow? ", ["Anyone", "Owner"], gMyCh);
    }

    touch_start(integer total_number) {
        key ToucherID = llDetectedKey(0);
        if (llDetectedKey(0) == llGetOwner())
            llDialog(ToucherID, "Menu ",["Stop"], gMyCh);
    }

    listen(integer channel, string name, key id, string message) {
        if (channel == gMyCh) {
            if (message == "Stop") {
                llSetTimerEvent(0.0);
                stop_all_animations();
                llStartObjectAnimation("RatWalk");

                vector currentPos = llGetRootPosition();
                while((currentPos.x-gStartPos.x) > 1.0 || (currentPos.y-gStartPos.y) > 1.0) {
                    rotation newRot = GetRotation(llRotBetween(<1,0,0>,llVecNorm(gStartPos-currentPos)));
                     llRotLookAt(newRot, TAU * TURNSPEED, TAU);
                    llMoveToTarget(gStartPos, TAU * DAMP);
                    currentPos = llGetRootPosition();
                }
                llStopMoveToTarget();

                llSetStatus(STATUS_PHYSICS, FALSE);
                llSetStatus(STATUS_PHANTOM, FALSE);

                llSetRegionPos(gStartPos);
                llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROTATION,gStartRot]);
                llSetLocalRot(ZERO_ROTATION);

                state running;
            }
            if (message == "Owner") {
                gFollowAnyone = FALSE;
                gMom = llGetOwnerKey(id);

                stop_all_animations();
                llStartObjectAnimation("RatWalk");

                gPosX = X_OFFSET;
                gPosY = Y_OFFSET;
                gStartPos = llGetRootPosition();
                gStartRot = llGetRootRotation();

                llCollisionSound("",0);

                llSetStatus(STATUS_PHYSICS, TRUE);
                llSetStatus(STATUS_PHANTOM, TRUE);
                llSetStatus(STATUS_BLOCK_GRAB_OBJECT, TRUE);

                list momInfo = llGetObjectDetails(gMom, [OBJECT_POS,OBJECT_ROT]);
                gMomPos = llList2Vector(momInfo,0);
                //gMomRot = llList2Rot(momInfo,1);
                vector currentPos = llGetRootPosition();
                //vector currentRotEuler = llRot2Euler(llGetRot());
                while(llFabs(currentPos.x-gMomPos.x) > 1.0 || llFabs(currentPos.y-gMomPos.y) > 1.0) {
                    rotation newRot = GetRotation(llRotBetween(<1,0,0>,llVecNorm(gMomPos-currentPos)));
                     llRotLookAt(newRot, TAU * TURNSPEED, TAU);
                    //llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROTATION,newRot]);
                    llMoveToTarget(gMomPos, TAU * DAMP);
                    currentPos = llGetRootPosition();
                }
                llStopMoveToTarget();

                llSetTimerEvent(.1);
            }
//            if (message == "Elephant") {
//                 gFollowElephant = TRUE;
//                 llDialog(llGetOwner(), "Press the FOLLOWME button in the Elephant Main Menu to continue!", ["OK"], gMyCh);
//            }
        }
        if (message == "Anyone") {
                gFollowAnyone = TRUE;
                get_agent();

                stop_all_animations();
                llStartObjectAnimation("RatWalk");

                gPosX = X_OFFSET;
                gPosY = Y_OFFSET;
                gStartPos = llGetRootPosition();
                gStartRot = llGetRootRotation();

                llCollisionSound("",0);

                llSetStatus(STATUS_PHYSICS, TRUE);
                llSetStatus(STATUS_PHANTOM, TRUE);
                llSetStatus(STATUS_BLOCK_GRAB_OBJECT, TRUE);

                list momInfo = llGetObjectDetails(gMom, [OBJECT_POS,OBJECT_ROT]);
                gMomPos = llList2Vector(momInfo,0);
                //gMomRot = llList2Rot(momInfo,1);
                vector currentPos = llGetRootPosition();
                //vector currentRotEuler = llRot2Euler(llGetRot());
                while(llFabs(currentPos.x-gMomPos.x) > 1.0 || llFabs(currentPos.y-gMomPos.y) > 1.0) {
                    rotation newRot = GetRotation(llRotBetween(<1,0,0>,llVecNorm(gMomPos-currentPos)));
                     llRotLookAt(newRot, TAU * TURNSPEED, TAU);
                    //llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_ROTATION,newRot]);
                    llMoveToTarget(gMomPos, TAU * DAMP);
                    currentPos = llGetRootPosition();
                }
                llStopMoveToTarget();

                llSetTimerEvent(.1);
            }
        }


    timer() {
        gCount++;
        integer speed = (integer)(llVecMag(llGetVel()) * 1.94384449);
        if (speed < .8 && !gStill) {
            stop_all_animations();
            llStartObjectAnimation("Standing");
            gStill = TRUE;
            ratanim = "stand";
        }
        if (speed >= 2 && gStill) {

            if (speed >= 2 && speed < 4) {
                stop_all_animations();
                llStartObjectAnimation("RatWalk");
                ratanim = "walk";
            }
            if (speed >= 5) {
                stop_all_animations();
                llStartObjectAnimation("RatRun");
            }
            gStill = FALSE;
        }
        if (speed >= 5 && ratanim == "walk") {
            stop_all_animations();
            llStartObjectAnimation("RatRun");
            ratanim = "run";
            gStill = FALSE;
        }
        if (speed < 4 && ratanim == "run") {
            stop_all_animations();
            llStartObjectAnimation("RatWalk");
            ratanim = "walk";
            gStill = FALSE;
        }
        if(gCount == 5) {
            gCount = 0;
            if(gFollowAnyone) {
                get_agent();
            }
        }
        do_rat_things();
    }
}
