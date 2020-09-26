integer ch = -35119;
integer chan;
integer listenkey;
integer access = 0;


menu(key id)
{
    if (id == llGetOwner() || access == 2 || (access == 1 && llSameGroup(id)))
    {
        list main = ["WOOD", "CURTAINS", "OPEN", "CLOSE"];
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
gTexwood(string gTex)
{
    string WoodT;
    string WoodN;
    string WoodS;

    if(gTex == "Walnut")
    {
        WoodT = "8e1f867d-65ca-3206-6e4e-4903ca71e31e";
        WoodN = "2c0dac48-2f69-6642-b638-104b670b3074";
        WoodS = "d9b0b9d5-664b-e91a-795a-1bedce6c7a29";

    }
    else if(gTex == "Damaged")
    {
       WoodT = "1de56c9b-e2fe-e6f1-e55c-1567589ef0f9";
       WoodN = "5ec94d68-4fd5-ae36-8d91-d9dc9311ca08";
       WoodS = "ffeac230-90ca-8647-20c4-8b9062aa6acb";

    }
    else if(gTex == "Rough")
    {
       WoodT = "e19daae5-e5b1-d8bd-b9ed-fe81188f0e38";
       WoodN = "4ddee08f-7023-65d9-a027-b262de240b19";
       WoodS = "8f6ec58f-4382-1395-1892-4f063f7f0669";

    }
    llSetLinkPrimitiveParamsFast(getlink("FaceDesk - Bloody Curtains"), [17, 1, WoodT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, 1, WoodN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, 1, WoodS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
}
gTexcurtains(string gTex)
{
    string CurtLT;
    string CurtRT;

    if(gTex == "White")
    {
        CurtLT = "5053f791-29d6-d269-9834-d56be9873248";
        CurtRT = "4712d838-b76b-8a06-519b-5d89a5b9bb70";

    }
    else if(gTex == "Tan")
    {
       CurtLT = "4e6c999f-b8c7-b60c-2d92-1619c0c6e853";
       CurtRT = "725db043-2763-48bd-2de2-9bf5ea471ab3";

    }
    llSetLinkPrimitiveParamsFast(getlink("curtainleft"), [17, 1, CurtLT, <2.0, 1.0, 0.0>, <0.5, 0.0, 0.0>, 3.14, 34, getlink("curtainright"), 17, 1, CurtRT, <2.0, 1.0, 0.0>, <0.5, 0.0, 0.0>, 3.14]);
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
  }
  touch_start(integer total_number)
  {
      llListenRemove(listenkey); listenkey = llListen(chan, "", NULL_KEY, "");
      menu(llDetectedKey(0));
  }
  listen(integer ch, string name, key id, string text)
  {
      if (llListFindList(["Owner","Group","All"],[text]) != -1) access = llListFindList(["Owner","Group","All"],[text]);
      if (text == "Access") llDialog(id,"Choose access ",["Owner","Group","All"],chan);
      if(text == "Back")
      {
          llListenRemove(listenkey); listenkey = llListen(chan, "", id, "");
          menu(id);
          return;
      }
      if(ch == chan)
      {
          if(text == "OPEN")
          {
              llSay(ch, "CURTAINOPEN");
          }
          if(text == "CLOSE")
          {
              llSay(ch, "CURTAINCLOSE");
          }
          if(text == "WOOD")
          {
              llListenRemove(listenkey); listenkey = llListen(chan +1,"",id,"");
              llDialog(id,"Wood Texture Menu ",["Damaged", "Walnut", "Rough", "Back"],chan+1);
          }
          if(text == "CURTAINS")
          {
              llListenRemove(listenkey); listenkey = llListen(chan +2,"",id,"");
              llDialog(id,"Curtain Texture Menu ",["Tan", "White", "Back"],chan+2);
          }

      }
      if(ch == chan +1)
      {
          gTexwood(text);
          llDialog(id,"Wood Texture Menu ",["Damaged", "Walnut", "Rough", "Back"],chan+1);
      }
      if(ch == chan +2)
      {
          gTexcurtains(text);
          llDialog(id,"Curtain Texture Menu ",["Tan", "White", "Back"],chan+2);
      }
  }
}
