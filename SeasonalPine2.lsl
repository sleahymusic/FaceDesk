integer chan;
integer channel;
integer listenkey;
integer listenkeyB;
integer access = 0;
integer g_timer = -1;
integer g_automatic = TRUE;
string green = "76386f45-9404-4c04-9dec-f506a0f433ef";
string light = "b310e474-8a0f-02dc-7c31-37f429c69451";
string heavy = "186db1b9-faf4-94d0-cd10-5dd0d6e64c13";
string bark = "f57f2cbd-7e2a-8ddb-44db-41255350f8c0";
string barkl = "be63fab8-581d-b2bc-688f-db549aac6e56";
//string barkh = "650aaf64-f2e7-349a-8e2c-1ced7702a92c";


menu(key id)
{
    if (id == llGetOwner() || access == 2 || (access == 1 && llSameGroup(id))) //check who touched and give appropriate menu or ignore
    {
        g_timer = 30; //use the timer for turning off the listen
        listenkeyB = llListen(channel, "", id,""); // open the listen for the person who touched
        list main = ["Green", "LightSnow", "HeavySnow", "Automatic"];
        if (id != llGetOwner()) llDialog(id,"Menu ", main, channel);
        else llDialog(id,"Menu ", main+["Access"], channel);
        llSetTimerEvent(1);
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
    channel = -(integer)("0x" + llGetSubString(llGetKey(),3,8));
    chan = -(integer)("0x" + llGetSubString(llGetOwnerKey(),2,8));
    listenkey = llListen(chan, "","", "");
    llSetTimerEvent(0.1);
  }
  touch_start(integer total_number)
  {
      menu(llDetectedKey(0));
  }
  listen(integer ch, string name, key id, string text)
  {
      if(ch == channel)
      {
          if (llListFindList(["Owner","Group","All"],[text]) != -1) access = llListFindList(["Owner","Group","All"],[text]);
          if (text == "Access") llDialog(id,"Choose access ",["Owner","Group","All"],ch);
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
              setBranches(heavy, barkl);
              g_automatic = FALSE;
          }
          if(text == "Automatic")
          {
              g_automatic = TRUE;
              integer daynum = (integer)llGetSubString(llGetDate(),5,6)*31+(integer)llGetSubString(llGetDate(),8,9);
              if(daynum > 386)
              {
                  setBranches(heavy, barkl);
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
              else setBranches(heavy, barkl);
              llSetTimerEvent(.1);
          }
          if(text != "Access") menu(id);
      }
      if(ch == chan)
      {
          float random = llFrand(2);
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
              setBranches(heavy, barkl);
              g_automatic = FALSE;
          }
          if(text == "Mixed")
          {
              if(random < 1)
              {
                 setBranches(light, barkl);
                 g_automatic = FALSE;
              }
              else
              {
                  setBranches(heavy, barkl);
                  g_automatic = FALSE;
              }
          }
          if(text == "Automatic")
          {
              g_automatic = TRUE;
              integer daynum = (integer)llGetSubString(llGetDate(),5,6)*31+(integer)llGetSubString(llGetDate(),8,9);
              if(daynum > 386)
              {
                  setBranches(heavy, barkl);
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
              else setBranches(heavy, barkl);
              llSetTimerEvent(.1);
          }
      }
  }
  timer()
  {
      if(g_timer >= 0)
      {
          if(g_timer == 0)
          {
              llListenRemove(listenkeyB);
              if(g_automatic) llSetTimerEvent(43200.0);
              else llSetTimerEvent(0);
          }
          g_timer--;
      }
      else
      {
          if (llGetSubString(llGetDate(),5,9) == "11-29") setBranches(light, barkl);
          else if (llGetSubString(llGetDate(),5,9) == "12-15") setBranches(heavy, barkl);
          else if (llGetSubString(llGetDate(),5,9) == "02-01") setBranches(light, barkl);
          else if (llGetSubString(llGetDate(),5,9) == "03-01") setBranches(green, bark);
          llSetTimerEvent(43200.0);
      }
  }
}
