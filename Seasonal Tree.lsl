integer access = 0;
integer chan;
integer listenkey;
string color;

menu(key id)
{
    if (id == llGetOwner() || access == 2 || (access == 1 && llSameGroup(id)))
    {
        list main = ["Green", "Red", "Orange", "Yellow", "Winter", "Automatic"];
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

setLeaves(string leaves, string color, string bark)
{
  if (color == "none")
  {
    llLinkParticleSystem(getlink("leaves"), []);
  }
  else llLinkParticleSystem(getlink("leaves"), falling_leaves(color));
  if (leaves == "be87cd58-62fd-6f0b-4eea-a3fd251d18d9") llSetLinkTextureAnim (getlink("leaves"), FALSE, ALL_SIDES, 0, 0, 0.0, 0.0, 1.0);
  else llSetLinkTextureAnim(getlink("leaves"), ANIM_ON | SMOOTH | ROTATE | PING_PONG | LOOP, ALL_SIDES,1,1,0, .0005, .00002*TWO_PI);
  llSetLinkTexture(getlink("leaves"), leaves, ALL_SIDES);
  llSetLinkTexture(LINK_THIS, bark, ALL_SIDES);
}

list falling_leaves(string color)
{
    return [ PSYS_SRC_TEXTURE, color  // Gimped by Qie from Public Domain on Wikimedia Commons
            , PSYS_PART_FLAGS
              , PSYS_PART_WIND_MASK     // usually undetectable though
              | PSYS_PART_INTERP_COLOR_MASK
              | PSYS_PART_INTERP_SCALE_MASK
              | PSYS_PART_EMISSIVE_MASK     // I wouldn't, but most would
            , PSYS_SRC_BURST_RADIUS, 4.0          // no effect w/ DROP
            , PSYS_PART_START_SCALE, <0.5, 0.3, 0.0>
            , PSYS_PART_END_SCALE, <0.5, 0.3, 0.0>
            , PSYS_PART_START_COLOR, <0.2, 0.1, 0.1>    // shaded inside tree
            , PSYS_PART_END_COLOR, <1.0, 1.0, 1.0>
            , PSYS_PART_START_ALPHA, 1.0
            , PSYS_PART_END_ALPHA, 1.0
            , PSYS_PART_START_GLOW, 0.01
            , PSYS_PART_END_GLOW, 0.01
            , PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_ANGLE_CONE
            , PSYS_SRC_ANGLE_BEGIN, PI_BY_TWO
            , PSYS_SRC_ANGLE_END, PI
            , PSYS_PART_MAX_AGE, 10.0
            , PSYS_SRC_BURST_RATE, 1.5
            , PSYS_SRC_BURST_PART_COUNT, 1
            , PSYS_SRC_ACCEL, <0, 0, -0.75>
            ];
}

default
{
  on_rez(integer num)
  {
    llResetScript();
  }
  state_entry()
  {
    chan = -(integer)("0x" + llGetSubString(llGetKey(),3,8));
    listenkey = llListen(chan, "", NULL_KEY, "");
    llSetTimerEvent(0.1);
  }
  touch_start(integer total_number)
  {
      menu(llDetectedKey(0));
  }
  listen(integer ch, string name, key id, string text)
  {
    string green = "7cc10805-188c-5fef-f434-f1bce1907be9";
    string yellow = "68b380df-5c13-76e4-80c7-d888f4e2ef69";
    string orange = "24053f3f-31ff-5ff7-582b-af5f7245e41a";
    string red = "8c7021f7-25a3-6f97-e35a-878227469745";
    string winter = "be87cd58-62fd-6f0b-4eea-a3fd251d18d9";
    string emityellow = "80cd4697-d44b-490c-50eb-706b81650242";
    string emitorange = "8d070fab-431d-7a9a-5b03-605970bc399f";
    string emitred = "635fa33b-c572-200d-77b0-a074650345ad";
    string bark = "df9a073d-03b8-d7ef-8ad0-5437ba03e2a3";
    string snowybark = "60862a47-b43c-245e-a0d7-69d3df1cafa4";
    if (llListFindList(["Owner","Group","All"],[text]) != -1) access = llListFindList(["Owner","Group","All"],[text]);
    if (text == "Access") llDialog(id,"Choose access ",["Owner","Group","All"],chan);
    if (text == "Yellow")
    {
        setLeaves(yellow, emityellow, bark);
        llSetTimerEvent(0.0);
    }
    if (text == "Orange")
    {
        setLeaves(orange, emitorange, bark);
        llSetTimerEvent(0.0);
    }
    if (text == "Red")
    {
        setLeaves(red, emitred, bark);
        llSetTimerEvent(0.0);
    }
    if (text == "Automatic")
    {
        integer daynum = (integer)llGetSubString(llGetDate(),5,6)*31+(integer)llGetSubString(llGetDate(),8,9);
        if(daynum > 373)
        {
            llLinkParticleSystem(getlink("leaves"), []  );
        }
        else if(daynum > 351)
        {
            integer random = llFloor(llFrand(3));
            if(random == 0)
            {
                setLeaves(yellow, emityellow, bark);
            }
            if(random == 1)
            {
                setLeaves(orange, emitorange, bark);
            }
            if(random == 2)
            {
                setLeaves(red, emitred, bark);
            }
        }
        else if(daynum > 330)
        {
            integer random = llFloor(llFrand(3));
            if(random == 0)
            {
                setLeaves(yellow, emityellow, bark);
            }
            if(random == 1)
            {
                setLeaves(orange, emitorange, bark);
            }
            if(random == 2)
            {
                setLeaves(red, emitred, bark);
            }
        }
        else if(daynum > 311)
        {
            integer random = llFloor(llFrand(3));
            if(random == 0)
            {
                setLeaves(yellow, emityellow, bark);
            }
            if(random == 1)
            {
                setLeaves(orange, emitorange, bark);
            }
            if(random == 2)
            {
                setLeaves(red, emitred, bark);
            }
        }
        else if(daynum > 94)
        {
            setLeaves(green, "none", bark);
        }
        else
        {
            setLeaves(winter, "none", snowybark);

        }
        llSetTimerEvent (0.1);
    }
    if(text == "Green")
    {
        setLeaves(green, "none", bark);
        llLinkParticleSystem(getlink("leaves"), []);
        llSetTimerEvent(0.0);
    }
    if(text == "Winter")
    {
        setLeaves(winter, "none", snowybark);
        llLinkParticleSystem(getlink("leaves"), []);
        llSetTimerEvent(0.0);
    }
    if (text == "Back") menu(id);
}
timer()
{
    string emityellow = "80cd4697-d44b-490c-50eb-706b81650242";
    string emitorange = "8d070fab-431d-7a9a-5b03-605970bc399f";
    string emitred = "635fa33b-c572-200d-77b0-a074650345ad";
    string green = "7cc10805-188c-5fef-f434-f1bce1907be9";
    string winter = "be87cd58-62fd-6f0b-4eea-a3fd251d18d9";
    string yellow = "68b380df-5c13-76e4-80c7-d888f4e2ef69";
    string orange = "24053f3f-31ff-5ff7-582b-af5f7245e41a";
    string red = "8c7021f7-25a3-6f97-e35a-878227469745";
    string bark = "df9a073d-03b8-d7ef-8ad0-5437ba03e2a3";
    string snowybark = "60862a47-b43c-245e-a0d7-69d3df1cafa4";
    if (llGetSubString(llGetDate(),5,9) == "10-01")
        {
            integer random = llFloor(llFrand(3));
            if (random == 0)
            {
                setLeaves(yellow, emityellow, bark);
            }
            if (random == 1)
            {
                setLeaves(orange, emitorange, bark);
            }
            if (random == 2)
            {
                setLeaves(red, emitred, bark);
            }
        }
        if (llGetSubString(llGetDate(),5,9) == "10-20")
        {
            integer random = llFloor(llFrand(3));
            if (random == 0)
            {
                setLeaves(yellow, emityellow, bark);
            }
            if (random == 1)
            {
                setLeaves(orange, emitorange, bark);
            }
            if (random == 2)
            {
                setLeaves(red, emitred, bark);
            }
        }
        if (llGetSubString(llGetDate(),5,9) == "11-10")
        {
            integer random = llFloor(llFrand(3));
            if (random == 0)
            {
                setLeaves(yellow, emityellow, bark);
            }
            if (random == 1)
            {
                setLeaves(orange, emitorange, bark);
            }
            if (random == 2)
            {
                setLeaves(red, emitred, bark);
            }
        }
        if (llGetSubString(llGetDate(),5,9) == "12-01")
        {
            setLeaves(winter, "none", snowybark);
            llLinkParticleSystem(getlink("leaves"), []  );
        }
        if (llGetSubString(llGetDate(),5,9) == "03-01")
        {
            setLeaves(green, "none", bark);
        }
        llSetTimerEvent(43200.0);
    }
}
