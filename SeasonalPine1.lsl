integer chan = -71937533;
integer ch;
key listenkey;
key listenkeyB;
integer access = 0;
integer g_timer = FALSE;
integer g_automatic = TRUE;

menu(key id)
{
    if (id == llGetOwner() || access == 2 || (access == 1 && llSameGroup(id)))
    {
        g_timer = TRUE;
        llSetTimerEvent(1);
        listenkeyB = llListen(ch, "", id,"");
        list main = ["Green", "LightSnow", "HeavySnow", "Automatic"];
        if (id != llGetOwner()) llDialog(id,"Menu ", main, chan);
        else llDialog(id,"Menu ", main+["Access"], chan);
    }
}
integer getlink(string primname)
{
    integer i; integer result= 9999;
    for(i=1; i<= llGetNumberOfPrims(); i++) if (llGetLinkName(i) == primname) result = i;
    return result;
}

setBranches(string branches, string bark)
{
  llSetLinkTexture(getlink("leaves"), branches, ALL_SIDES);
  llSetLinkTexture(getlink("leaves2"), branches, ALL_SIDES);
  llSetLinkTexture(LINK_THIS, bark, ALL_SIDES);
}
default
{
  on_rez(integer num)
  {
    llResetScript();
  }
  state_entry()
  {
    ch = -(integer)("0x" + llGetSubString(llGetKey(),3,8));
    listenkey = llListen(chan, "", llGetOwner(), "");
    llSetTimerEvent(0.1);
  }
  touch_start(integer total_number)
  {
      menu(llDetectedKey(0));
  }
  listen(integer ch, string name, key id, string text)
  {
      if(ch == ch)
      {
          if (llListFindList(["Owner","Group","All"],[text]) != -1) access = llListFindList(["Owner","Group","All"],[text]);
          if (text == "Access") llDialog(id,"Choose access ",["Owner","Group","All"],ch);
          string green = "3d9f7229-9dcd-cec1-9fae-b9cbfd682e47";
          string light = "49de4a3c-7bbe-e1a3-ead7-2a41d863c71d";
          string heavy = "78e3cf20-37f8-4f9a-6192-ee0d3aa23716";
          string bark = "62b5aa4d-b074-6b27-06de-721fbfb4cd7e";
          string barkl = "be63fab8-581d-b2bc-688f-db549aac6e56";
          string barkh = "650aaf64-f2e7-349a-8e2c-1ced7702a92c";
          if(text == "Green")
          {
              setBranches(green, bark);
              g_automatic = FALSE;
          }
          if(text == "LightSnow")
          {
              setBranches(light, barkl);
              g_automatic = FALSE;
          }
          if(text == "HeavySnow")
          {
              setBranches(heavy, barkh);
              g_automatic = FALSE;
          }
          if(text == "Automatic")
          {
              g_automatic = TRUE;
              integer daynum = (integer)llGetSubString(llGetDate(),5,6)*31+(integer)llGetSubString(llGetDate(),8,9);
              if(daynum > 386)
              {
                  setBranches(heavy, barkh);
              }
              else if(daynum > 368)
              {
                  setBranches(light, barkl);
              }
              else if(daynum > 93)
              {
                  setBranches(green, bark);
              }
              else if(daynum > 62)
              {
                  setBranches(light, barkl);
              }
              else setBranches(heavy, barkh);
              llSetTimerEvent(.1);
          }
          if(text != "Access") menu(id);
      }
      if(ch == chan)
      {
          string green = "3d9f7229-9dcd-cec1-9fae-b9cbfd682e47";
          string light = "49de4a3c-7bbe-e1a3-ead7-2a41d863c71d";
          string heavy = "78e3cf20-37f8-4f9a-6192-ee0d3aa23716";
          string bark = "62b5aa4d-b074-6b27-06de-721fbfb4cd7e";
          string barkl = "be63fab8-581d-b2bc-688f-db549aac6e56";
          string barkh = "650aaf64-f2e7-349a-8e2c-1ced7702a92c";
          if(text == "Green")
          {
              setBranches(green, bark);
              g_automatic = FALSE;
          }
          if(text == "LightSnow")
          {
              setBranches(light, barkl);
              g_automatic = FALSE;
          }
          if(text == "HeavySnow")
          {
              setBranches(heavy, barkh);
              g_automatic = FALSE;
          }
          if(text == "Automatic")
          {
              g_automatic = TRUE;
              integer daynum = (integer)llGetSubString(llGetDate(),5,6)*31+(integer)llGetSubString(llGetDate(),8,9);
              if(daynum > 386)
              {
                  setBranches(heavy, barkh);
              }
              else if(daynum > 368)
              {
                  setBranches(light, barkl);
              }
              else if(daynum > 93)
              {
                  setBranches(green, bark);
              }
              else if(daynum > 62)
              {
                  setBranches(light, barkl);
              }
              else setBranches(heavy, barkh);
              llSetTimerEvent(.1);
          }
      }
  }
  timer()
  {
      integer time;
      if(g_timer)
      {
          if(time > 29)
          {
              time = 0;
              g_timer = FALSE;
              llListenRemove(listenkeyB);
              if(g_automatic) llSetTimerEvent(43200.0);
              else llSetTimerEvent(0);
          }
          else time++;
      }
      else
      {
          string green = "3d9f7229-9dcd-cec1-9fae-b9cbfd682e47";
          string light = "49de4a3c-7bbe-e1a3-ead7-2a41d863c71d";
          string heavy = "78e3cf20-37f8-4f9a-6192-ee0d3aa23716";
          string bark = "62b5aa4d-b074-6b27-06de-721fbfb4cd7e";
          string barkl = "be63fab8-581d-b2bc-688f-db549aac6e56";
          string barkh = "650aaf64-f2e7-349a-8e2c-1ced7702a92c";
          if (llGetSubString(llGetDate(),5,9) == "11-29") setBranches(light, barkl);
          else if (llGetSubString(llGetDate(),5,9) == "12-15") setBranches(heavy, barkh);
          else if (llGetSubString(llGetDate(),5,9) == "02-01") setBranches(light, barkl);
          else if (llGetSubString(llGetDate(),5,9) == "03-01") setBranches(green, bark);
          llSetTimerEvent(43200.0);
      }
  }
}
