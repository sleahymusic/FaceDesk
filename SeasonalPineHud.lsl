integer chan = -71937533;
integer i;




default
{
  state_entry()
  {

  }
  touch_start(integer total_number)
  {
      i = llDetectedLinkNumber(0);
      llRegionSay(chan, (string)llGetLinkName (i));
  }
}
