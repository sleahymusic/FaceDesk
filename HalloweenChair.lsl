integer chan;
integer listenkey;
integer access = 0;
string gMode;
integer gSit = FALSE;
key gAgent;
integer gTimer = FALSE;
list gFloatAnims = ["FloatingUp", "sky float 1", "space float2", "stand toes spin fast", "Magic carpet5", "fire hydrant", "hover sit hold turn4"];
string gCurrAnimation = "Stationary Chair";
string gLastAnimation;
integer gCount = 0;
integer gHome = TRUE;
integer gRoaming = FALSE;

menu(key id)
{
    if (id == llGetOwner() || access == 2 || (access == 1 && llSameGroup(id)))
    {
        list main = ["TEXTURES", "MODE", "SETHOME"];
        if (id != llGetOwner()) llDialog(id,"Menu ", main, chan);
        else                   llDialog(id,"Menu ", main+["Access"], chan);
    }
}

integer getlink(string primname)
{
    integer i; integer result= 9999;
    for(i=1; i<= llGetNumberOfPrims(); i++) if (llGetLinkName(i) == primname) result = i;
    return result;
}

gTexchair(string gTex)
{
    string FrameT;
    string FrameN;
    string FrameS;
    string SeatT;
    string SeatN;

    if(gTex == "RedOrange")
    {
        FrameT = "f3fa3c84-f810-2d81-8d62-5874e22b0c21";
        FrameN = "3e628e73-ad3e-b54b-4ae8-bbc027080d9e";
        FrameS = "f5b0d9a1-dc9c-c7f1-f8c6-c17e94550fe9";
        SeatT = "dc0da866-2871-0b00-376b-f10ebb94d68c";
        SeatN = "598d1773-e3d2-5d63-c9be-70000950be26";


    }
    else if(gTex == "Damaged")
    {
       FrameT = "ad393004-3668-b3f6-5d20-01aaf43cbaa5";
       FrameN = "57d624f2-b07d-a2dc-ddec-571b889be273";
       FrameS = "ec4fd52b-998e-8271-b711-9a05d6b20e70";
       SeatT = "06ce1fb4-d14d-15bd-d1c7-b81eb4a39a04";
       SeatN = "0073c504-a8a9-2297-7521-2cb52e1768e1";


    }
    else if(gTex == "Grungy")
    {
       FrameT = "55655ec0-2528-df59-1cba-5290bd2e2fcd";
       FrameN = "9b6f4ab3-eba6-bd02-ccc2-9ef6bf1cdeb6";
       FrameS = "5941ed5d-de97-592e-f9d5-05a518ad7c42";
       SeatT = "c2e39d87-6c76-1cf9-e408-c53081e0e1be";
       SeatN = "8ab62ef7-dedf-5e23-a5b1-e561e2d94d66";


    }
    else if(gTex == "Weathered")
    {
       FrameT = "9aca1b63-60f6-d48d-5ece-13492cb98681";
       FrameN = "a034eb0a-7f80-f916-5e24-5aa1b4779fc4";
       FrameS = "6a17b94d-a2e0-e4d4-6de5-5691a8b5bf65";
       SeatT = "ec6013f3-98c9-c05b-79d1-31a647a072ae";
       SeatN = "f5a0fea6-0611-a131-3407-111c8be4bab0";


    }
    else if(gTex == "WalnutRed")
    {
       FrameT = "3d96526a-6916-5a04-93d4-d499002a31af";
       FrameN = "f4299024-7e36-ab33-0d4a-4341b7398556";
       FrameS = "4594b520-05c9-d1f6-b56f-75822b58bf6b";
       SeatT = "48cf1b2a-c80b-c91f-be9d-42a57d2df2df";
       SeatN = "b041a10e-de46-a1b2-440a-e2a33edb9c96";


    }
    llSetLinkPrimitiveParamsFast(getlink("FaceDesk - Animesh Halloween Chair"), [17, 1, FrameT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, 1, FrameN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, 1, FrameS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 17, 0, SeatT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
            37, 0, SeatN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
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
    llStartObjectAnimation("Stationary Chair");
}

default
{
  on_rez(integer num)
  {
    llResetScript();
  }
  state_entry()
  {
      llSitTarget(<0.01, 0.0, 0.35>, ZERO_ROTATION);
      rotation cameraRotation = llAxisAngle2Rot(<0, 0, 1>, 220 * DEG_TO_RAD);
      llSetCameraEyeOffset(<-3.5, 0, 1.5> * cameraRotation);
      llSetCameraAtOffset(<3.5, 0, 1> * cameraRotation);
      stop_all_animations();
      chan = -(integer)("0x" + llGetSubString(llGetKey(),3,8));
      listenkey = llListen(chan, "", NULL_KEY, "");
      gMode = "Capture";
  }
  changed(integer change)
  {
      gAgent = llAvatarOnSitTarget();
      //if(gMode == "Float")
      //{
          //llUnSit(gAgent);
      //}
      if (llAvatarOnSitTarget()==NULL_KEY)
      {
          //llMessageLinked(speed, integer num, string str, key id);
          //llMessageLinked(-1, 0, "stop", "");
          //llSetTimerEvent(0.0);
          gSit = FALSE;
          if(gTimer) llSetTimerEvent(1);
          if(gMode == "Capture") llSetTimerEvent(1);
          if(gMode == "Fall") stop_all_animations();
          if(gMode == "Float") llStopAnimation("sitfreeze");
      }
      else
      {
          llRequestPermissions(llAvatarOnSitTarget(), PERMISSION_TRIGGER_ANIMATION);
      }
  }
  run_time_permissions(integer perm)
  {
      if (perm & PERMISSION_TRIGGER_ANIMATION)
      {
          if(gMode == "Capture")
          {
              llStopAnimation("sit");
              llStartAnimation("HCP_HUMAN");
              llStopObjectAnimation("Stationary Chair");
              llStartObjectAnimation("HCP_CHAIR");
              gSit = TRUE;
              gHome = FALSE;
              llSetTimerEvent(12);

          }
          if(gMode == "Fall")
          {
              llStopAnimation("sit");
              llStartAnimation("SitFall");
              llStopObjectAnimation("Stationary Chair");
              llStartObjectAnimation("BackupChair");
              gSit = TRUE;
          }
          if(gMode == "Roam")
          {
              gMode = "Capture";
              llMessageLinked(LINK_THIS, FALSE, "Roam", NULL_KEY);
              stop_all_animations();
              llStopAnimation("sit");
              llStartAnimation("HCP_HUMAN");
              llStopObjectAnimation("Stationary Chair");
              llStartObjectAnimation("HCP_CHAIR");
              gSit = TRUE;
              gHome = FALSE;
              llSetTimerEvent(12);
          }
          if(gMode == "Float")
          {
              stop_all_animations();
              llStopAnimation("sit");
              llStartAnimation("sitfreeze");
              llStartAnimation("stand toes spin fast");
              llStartObjectAnimation("stand toes spin fast");
              gSit = TRUE;
              llSetTimerEvent(5);
          }
      }
    }
  touch_start(integer total_number)
  {
      llListenRemove(listenkey); listenkey = llListen(chan, "", NULL_KEY, "");
      menu(llDetectedKey(0));
  }
  listen(integer ch, string name, key id, string text)
  {
      if(text == "Back")
      {
          llListenRemove(listenkey); listenkey = llListen(chan, "", id, "");
          menu(id);
          return;
      }
      if(ch == chan)
      {
          if(text == "TEXTURES")
          {
              llListenRemove(listenkey); listenkey = llListen(chan +1,"",id,"");
              llDialog(id,"Chair Texture Menu ",["RedOrange", "Grungy", "Damaged", "WalnutRed", "Weathered", "Back"],chan+1);
          }
          if(text == "MODE")
          {
              llListenRemove(listenkey); listenkey = llListen(chan +2,"",id,"");
              llDialog(id,"Chair Mode Menu ",["Capture", "Fall", "RoamOn", "RoamOff", "Float", "Random", "Back"],chan+2);
          }
          if(text == "SETHOME") llMessageLinked(LINK_THIS, 1, "sethome", NULL_KEY);
          if(text == "Access")
          {
              llListenRemove(listenkey); listenkey = llListen(chan +4,"",id,"");
              llDialog(id,"Choose access ",["Owner", "Group", "ALL"],chan+4);
          }
      }
      if(ch == chan +1)
      {
          gTexchair(text);
          llDialog(id,"Chair Texture Menu ",["RedOrange", "Grungy", "Damaged", "WalnutRed", "Weathered", "Back"],chan+1);
      }
      if(ch == chan +2)
      {
          if(text == "RoamOn")
          {
              if(!gRoaming) llMessageLinked(LINK_THIS, TRUE, "Roam", NULL_KEY);
              gTimer = FALSE;
              gRoaming = TRUE;
              stop_all_animations();
              llSetTimerEvent(0.0);
              gMode = "Roam";
          }
          if(text == "RoamOff")
          {
              gTimer = FALSE;
              gRoaming = FALSE;
              if(gRoaming) llMessageLinked(LINK_THIS, FALSE, "Roam", NULL_KEY);
              stop_all_animations();
              llSetTimerEvent(0.0);
              gMode = "Capture";
              llDialog(id, "Capture mode ACTIVATED Muhahahaha", ["OK"], -11111);
          }
          if(text == "Float")
          {
              gTimer = FALSE;
              if(gRoaming) llMessageLinked(LINK_THIS, FALSE, "Roam", NULL_KEY);
              gRoaming = FALSE;
              llSetTimerEvent(0.0);
              stop_all_animations();
              gMode = "Float";
              gCurrAnimation = "Stationary Chair";
              llSetTimerEvent(.01);
          }
          if(text == "Random")
          {
              gTimer = FALSE;
              if(gRoaming) llMessageLinked(LINK_THIS, FALSE, "Roam", NULL_KEY);
              gRoaming = FALSE;
              stop_all_animations();
              llSetTimerEvent(0.0);
              llDialog(id, "Random mode ACTIVATED Muhahahaha", ["OK"], -11111);
              gTimer = TRUE;
              gCount = 0;
              llSetTimerEvent(1);


          }
          if(text == "Capture")
          {
              gTimer = FALSE;
              if(gRoaming) llMessageLinked(LINK_THIS, FALSE, "Roam", NULL_KEY);
              gRoaming = FALSE;
              stop_all_animations();
              llSetTimerEvent(0.0);
              gMode = "Capture";
              llDialog(id, "Capture mode ACTIVATED Muhahahaha", ["OK"], -11111);
          }
          if(text == "Fall")
          {
              gTimer = FALSE;
              if(gRoaming) llMessageLinked(LINK_THIS, FALSE, "Roam", NULL_KEY);
              gRoaming = FALSE;
              stop_all_animations();
              llSetTimerEvent(0.0);
              gMode = "Fall";
              llDialog(id, "Fall mode ACTIVATED Muhahahaha", ["OK"], -11111);
          }
      }
  }
 link_message(integer sender_num, integer num, string str, key id)
  {
      if(str == "home")
      {
          llSetTimerEvent(0.0);
          stop_all_animations();
          gMode = "Capture";
      }
  }
  timer()
  {
      if(gTimer)
      {
          gCount++;
          if(gCount >= 20 && !gSit)
          {
              list modes = ["Float", "Roam", "Fall", "Capture"];
              stop_all_animations();
              if(gMode == "RoamOn") llMessageLinked(LINK_THIS, FALSE, "Roam", NULL_KEY);
              string newMode;
              integer rand = (integer)llFrand(llGetListLength(modes));
              newMode = llList2String(modes, rand);
              gMode = newMode;
              gCount = 0;
          }
          if(gCount >= 20 && gSit) gCount = 0;
      }
      if(gMode == "Capture")
      {
          if(!gSit && !gHome)
          {
              if(!gTimer) llSetTimerEvent(0.0);
              llMessageLinked(LINK_THIS, FALSE, "Roam", NULL_KEY);

              llUnSit(gAgent);
              llPushObject(gAgent,<25,0,25>, <0,100,100>, TRUE);
              llStopObjectAnimation("HCP_CHAIR");
              llStartObjectAnimation("ChairWalk");
              llSleep(1);
              llMessageLinked(LINK_THIS, 1, "GoHome", NULL_KEY);
              gHome = TRUE;
          }
          else if(gSit)
          {
              //llMessageLinked(speed);
              llMessageLinked(LINK_THIS, TRUE, "Roam", NULL_KEY);
              llSetTimerEvent(30);
              gSit = FALSE;
          }
      }
      if(gMode == "Float")
      {
          llStopObjectAnimation(gCurrAnimation);
          if(gSit) llStopAnimation(gCurrAnimation);
          llStartObjectAnimation("BoneFreeze");
          string newAnimation;
          do {
              integer random = (integer)llFrand(llGetListLength(gFloatAnims));
              newAnimation = llList2String(gFloatAnims, random);
          } while (newAnimation == gLastAnimation);

          gLastAnimation = gCurrAnimation;
          gCurrAnimation = newAnimation;
          llStartObjectAnimation(newAnimation);
          if(gSit) llStartAnimation(newAnimation);
          llSetTimerEvent(5 + (integer) llFrand (10));
      }
  }
}
