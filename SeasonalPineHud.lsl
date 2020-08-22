integer chan;
integer i;




default
{
  state_entry()
  {
      chan = -(integer)("0x" + llGetSubString(llGetOwner(),2,8));
  }
  on_rez(integer start_param)
  {
      llResetScript();
  }
  touch_start(integer total_number)
  {
      i = llDetectedLinkNumber(0);
      llRegionSay(chan, (string)llGetLinkName (i));
  }
}
