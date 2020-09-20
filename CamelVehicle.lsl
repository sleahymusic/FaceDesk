integer g_listenkey;
key g_agent;
key g_pilot;


string g_forwardAnimation;
integer g_pace;
integer CHANNEL;

integer gSound = TRUE;
integer g_moving = FALSE;

vector SIT_POS = <0.3, 0.0, 0.4>;


float g_forward_power = 3.9;
float g_reverse_power = -2.5;
float g_turning_ratio = 3;
integer g_driverPerms = 1;

list gSoundnames = [
    "Camel1",
    "Camel2",
    "Camel3",
    "Camel4",
    "Camel5"
];
list g_camelStandAnims = [
    "Camel_Idle_Loop",
    "Camel_Eating_Loop"
];
list g_camelWalkAnims = [
    "Camel_Eating_Loop",
    "Camel_Idle_Loop",
    "Camel_Run_Loop",
    "Camel_Troting_Loop",
    "Camel_Walk_Loop",
    "CamelHeightCorrect",
    "StandCorrect"
];

integer DEBUG = FALSE;
integer DEBUG_CONTROLS = FALSE;

vehicleSettings() {

    llSetVehicleFlags(-1);







    llSetVehicleType(VEHICLE_TYPE_CAR);




















    llSetVehicleFloatParam(VEHICLE_LINEAR_DEFLECTION_EFFICIENCY, 1.0);
    llSetVehicleFloatParam(VEHICLE_LINEAR_DEFLECTION_TIMESCALE, 100.0);

    llSetVehicleFloatParam(VEHICLE_ANGULAR_DEFLECTION_EFFICIENCY, 1.0);
    llSetVehicleFloatParam(VEHICLE_ANGULAR_DEFLECTION_TIMESCALE, 100.0);






    llSetVehicleFloatParam(VEHICLE_LINEAR_MOTOR_TIMESCALE, .1);
    llSetVehicleFloatParam(VEHICLE_LINEAR_MOTOR_DECAY_TIMESCALE, 0.0);
    llSetVehicleFloatParam(VEHICLE_ANGULAR_MOTOR_TIMESCALE, 0.1);
    llSetVehicleFloatParam(VEHICLE_ANGULAR_MOTOR_DECAY_TIMESCALE, 0.1);




    llSetVehicleVectorParam(VEHICLE_LINEAR_FRICTION_TIMESCALE, <0.1, 0.1, 1000>);
    llSetVehicleVectorParam(VEHICLE_ANGULAR_FRICTION_TIMESCALE, <0.1, 1000, 0.1>);












    llSetVehicleFloatParam(VEHICLE_VERTICAL_ATTRACTION_EFFICIENCY, 0.01);
    llSetVehicleFloatParam(VEHICLE_VERTICAL_ATTRACTION_TIMESCALE, 200.0);








}

stop_all_animations() {
    integer length = llGetListLength(g_camelWalkAnims);
    integer index = 0;
    while (index < length) {
        string anim = llList2String(g_camelWalkAnims, index);
        llStopObjectAnimation(anim);
        ++index;
    }
}

integer getlink(string primname) {
    integer i;
    integer result = 9999;
    for (i = 1; i <= llGetNumberOfPrims(); i++) {
        if (llGetLinkName(i) == primname) result = i;
    }
    return result;
}

default
{
    on_rez(integer num) {
        llResetScript();
    }

    state_entry() {
        if (DEBUG) llOwnerSay("Entering default state.");
        llSetMemoryLimit(24000);
        CHANNEL = -(integer)("0x" + llGetSubString(llGetKey(),3,8));


        llSetStatus(STATUS_BLOCK_GRAB_OBJECT, TRUE);


        llCollisionSound("", 0.0);

        llSetSitText("Ride");
        llSitTarget(SIT_POS, ZERO_ROTATION);

        state standing;
    }
}

state standing
{
    on_rez(integer num) {
        llResetScript();
    }

    state_entry() {
        if (DEBUG) llOwnerSay("Entering standing state.");

        llReleaseControls();
        llSetStatus(STATUS_PHYSICS, FALSE);

        stop_all_animations();
        llStartObjectAnimation("Camel_Idle_Loop");
        llStartObjectAnimation("StandCorrect");


        llSetTimerEvent(30);
    }

    touch_start(integer num_detected) {
        if (llDetectedKey(0) == llGetOwner()) {
            llListenRemove(g_listenkey);
            g_listenkey = llListen(CHANNEL, "", llGetOwner(), "");
            llDialog(llGetOwner(), "Menu ", ["SoundOn", "SoundOff", "Owner", "All", "Texture"], CHANNEL);
        }
    }

    listen(integer channel, string name, key id, string message) {
        if (message == "Owner") g_driverPerms = 1;
        else if (message == "All") g_driverPerms = 2;
        else if (message == "SoundOn") gSound = TRUE;
        else if (message == "SoundOff") gSound = FALSE;
        else if (message == "Texture") llDialog(id, "Menu ", ["Burlap", "RedPattern", "Suede"], CHANNEL);
        else if (message == "Burlap")
            llSetLinkPrimitiveParamsFast(getlink("Blanket"),[17, ALL_SIDES, "1202fa61-e0d3-e244-191c-fd06e174efe9", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        else if (message == "RedPattern")
            llSetLinkPrimitiveParamsFast(getlink("Blanket"),[17, ALL_SIDES, "db2e58de-6dad-bfd2-30e4-67b58997c0de", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        else if (message == "Suede")
            llSetLinkPrimitiveParamsFast(getlink("Blanket"),[17, ALL_SIDES, "5b1149df-1a1d-fb39-3e36-b86659c65e21", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
    }

    changed(integer change) {
        if (change & CHANGED_LINK) {
            g_agent = llAvatarOnSitTarget();
            if (g_driverPerms == 1) g_pilot = llGetOwner();
            else if (g_driverPerms == 2) g_pilot = llAvatarOnSitTarget();

            if (g_agent == g_pilot) {
               llSetTimerEvent(0.0);
               state walking;
            }
            else llUnSit(g_agent);
        }
    }

    timer() {

        integer randSound = (integer)llFrand(llGetListLength(gSoundnames));
        string newSound = llList2String(gSoundnames, randSound);

        if (gSound) llPlaySound(newSound, 1.0);


        integer random = (integer)llFrand(llGetListLength(g_camelStandAnims));
        string animation = llList2String(g_camelStandAnims, random);

        stop_all_animations();
        if (animation == "Camel_Idle_Loop") llStartObjectAnimation("StandCorrect");
        if (animation == "Camel_Eating_Loop") llStartObjectAnimation("CamelHeightCorrect");
        llStartObjectAnimation(animation);

        llSetTimerEvent(35.0);
    }
}

state walking
{
    on_rez(integer num) {
        llResetScript();
    }

    state_entry() {
        if (DEBUG) llOwnerSay("Entering walking state.");


        stop_all_animations();
        llStartObjectAnimation("Camel_Idle_Loop");
        llStartObjectAnimation("StandCorrect");

        llStopSound();
        if (gSound) llSetTimerEvent(0.1);
        else llSetTimerEvent(0.0);

        vehicleSettings();


        llSetStatus(STATUS_PHYSICS, TRUE);
        llSetStatus(STATUS_ROTATE_X | STATUS_ROTATE_Y, FALSE);
        llRequestPermissions(g_pilot, PERMISSION_TAKE_CONTROLS | PERMISSION_TRIGGER_ANIMATION);




    }

    run_time_permissions(integer perm) {
        if (perm & PERMISSION_TAKE_CONTROLS) {
            llTakeControls(CONTROL_FWD | CONTROL_BACK |
                           CONTROL_RIGHT | CONTROL_LEFT |
                           CONTROL_UP | CONTROL_DOWN |
                           CONTROL_ROT_RIGHT | CONTROL_ROT_LEFT, TRUE, FALSE);


            g_pace = 2;
            g_forwardAnimation = "Camel_Troting_Loop";
            g_forward_power = 3.9;
            g_reverse_power = -2.5;
            g_moving = FALSE;
        }
        else {
            llRegionSayTo(g_pilot, 0, "You MUST allow permissions to drive this camel!");
        }
    }

    touch_start(integer num_detected) {
        if (llDetectedKey(0) == llGetOwner()) {
            llListenRemove(g_listenkey);
            g_listenkey = llListen(CHANNEL, "", llGetOwner(), "");
            llDialog(llGetOwner(), "Menu ", ["SoundOn", "SoundOff", "Owner", "All", "Texture"], CHANNEL);
        }
    }

    listen(integer channel, string name, key id, string message) {
        if (message == "Owner") g_driverPerms = 1;
        else if (message == "All") g_driverPerms = 2;
        else if (message == "SoundOn") { gSound = TRUE; llSetTimerEvent(0.1); }
        else if (message == "SoundOff") { gSound = FALSE; llSetTimerEvent(0.0); }
        else if (message == "Texture") llDialog(id, "Menu ", ["Burlap", "RedPattern", "Suede"], CHANNEL);
        else if (message == "Burlap")
            llSetLinkPrimitiveParamsFast(getlink("Blanket"),[17, ALL_SIDES, "1202fa61-e0d3-e244-191c-fd06e174efe9", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        else if (message == "RedPattern")
            llSetLinkPrimitiveParamsFast(getlink("Blanket"),[17, ALL_SIDES, "db2e58de-6dad-bfd2-30e4-67b58997c0de", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        else if (message == "Suede")
            llSetLinkPrimitiveParamsFast(getlink("Blanket"),[17, ALL_SIDES, "5b1149df-1a1d-fb39-3e36-b86659c65e21", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
    }

    changed(integer change) {
        if (change & CHANGED_LINK) {
            integer numberOfAvatarsSitting = llGetNumberOfPrims() - llGetObjectPrimCount(llGetKey());

            if (numberOfAvatarsSitting == 0) {
                state standing;
            }

            else if (llAvatarOnSitTarget() != NULL_KEY && llAvatarOnSitTarget() != g_pilot) {
                llUnSit(llAvatarOnSitTarget());
                state standing;
            }
        }
    }

    timer() {

        integer randSound = (integer)llFrand(llGetListLength(gSoundnames));
        string newSound = llList2String(gSoundnames, randSound);

        if (gSound) llPlaySound(newSound, 1.0);


        llSetTimerEvent((integer)llFrand(30) + 30);
    }

    control(key id, integer held, integer change) {
        integer pressed = held & change;
        integer down = held & ~change;
        integer released = ~held & change;

        vector vel = llGetVel();
        float Speed = llVecMag(vel);
        vector angular_motor;



        if (down & CONTROL_FWD) {
            if (DEBUG_CONTROLS) llOwnerSay("Forward Control held");

            if (!g_moving) {
                llStopObjectAnimation("Camel_Idle_Loop");
                llStopObjectAnimation("StandCorrect");

                llStartObjectAnimation(g_forwardAnimation);
                g_moving = TRUE;
            }
            llSetVehicleVectorParam(VEHICLE_LINEAR_MOTOR_DIRECTION, <g_forward_power,0,0>);
        }


        if (released & CONTROL_FWD) {
            if (DEBUG_CONTROLS) llOwnerSay("Forward Control released");
            g_moving = FALSE;
            llStopObjectAnimation(g_forwardAnimation);
            llStartObjectAnimation("Camel_Idle_Loop");
            llStartObjectAnimation("StandCorrect");
        }


        if (held & CONTROL_BACK) {
            if (DEBUG_CONTROLS) llOwnerSay("Backward Control held");

            if (!g_moving) {
                llStopObjectAnimation("Camel_Idle_Loop");
                llStopObjectAnimation("StandCorrect");

                llStartObjectAnimation(g_forwardAnimation);
                g_moving = TRUE;
            }
            llSetVehicleVectorParam(VEHICLE_LINEAR_MOTOR_DIRECTION, <g_reverse_power,0,0>);
        }


        if (released & CONTROL_BACK) {
            if (DEBUG_CONTROLS) llOwnerSay("Backward Control released");
            g_moving = FALSE;
            llStopObjectAnimation(g_forwardAnimation);
            llStartObjectAnimation("Camel_Idle_Loop");
            llStartObjectAnimation("StandCorrect");
        }


        if (pressed & CONTROL_UP) {
            g_pace++;
            if (g_pace > 3) g_pace = 3;
            if (g_pace == 2) {
                llStopObjectAnimation(g_forwardAnimation);
                g_forwardAnimation = "Camel_Troting_Loop";
                g_forward_power = 3.9;
                g_reverse_power = -2.5;
                if (g_moving) llStartObjectAnimation(g_forwardAnimation);
            }
            if (g_pace == 3) {
                llStopObjectAnimation(g_forwardAnimation);
                g_forwardAnimation = "Camel_Run_Loop";
                g_forward_power = 10.0;
                g_reverse_power = -3.9;
                if (g_moving) llStartObjectAnimation(g_forwardAnimation);
            }
        }


        if (pressed & CONTROL_DOWN) {
            g_pace--;
            if (g_pace < 1) g_pace = 1;
            if (g_pace == 1) {
                llStopObjectAnimation(g_forwardAnimation);
                g_forwardAnimation = "Camel_Walk_Loop";
                g_forward_power = 2.0;
                g_reverse_power = -1;
                if(g_moving) llStartObjectAnimation(g_forwardAnimation);
            }
            if (g_pace == 2) {
                llStopObjectAnimation(g_forwardAnimation);
                g_forwardAnimation = "Camel_Troting_Loop";
                g_forward_power = 3.9;
                g_reverse_power = -2.5;
                if(g_moving) llStartObjectAnimation(g_forwardAnimation);
            }
        }


        if (held & (CONTROL_RIGHT|CONTROL_ROT_RIGHT)) {
            if (DEBUG_CONTROLS) llOwnerSay("Right Arrow");
            angular_motor.z -= Speed / g_turning_ratio;
        }


        if (held & (CONTROL_LEFT|CONTROL_ROT_LEFT)) {
            if (DEBUG_CONTROLS) llOwnerSay("Left Arrow");
            angular_motor.z += Speed / g_turning_ratio;
        }

        llSetVehicleVectorParam(VEHICLE_ANGULAR_MOTOR_DIRECTION, angular_motor);
    }
}
