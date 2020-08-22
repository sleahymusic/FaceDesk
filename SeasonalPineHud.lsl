integer chan;
integer i;




default
{
  state_entry()
  {
      chan = -(integer)("0x" + llGetSubString(llGetOwnerKey(),2,8));
  }
  touch_start(integer total_number)
  {
      i = llDetectedLinkNumber(0);
      llRegionSay(chan, (string)llGetLinkName (i));
  }
}
