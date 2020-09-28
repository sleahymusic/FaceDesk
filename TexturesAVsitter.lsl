integer chan;
integer listenkey;
key gAgent;


menu(key id)
{
    if (id == llGetOwner() || access == 2 || (access == 1 && llSameGroup(id)))
    {
        list main = ["RedOrange", "Grungy", "Damaged", "WalnutRed", "Weathered"];
        if (id != llGetOwner()) llDialog(id,"Chair Texture Menu ", main, chan);
        else                   llDialog(id,"Chair Texture Menu ", main+["Access"], chan);
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
  }

  listen(integer ch, string name, key id, string text)
  {
      if(ch == chan)
      {
          if(text == "Access")
          {
              llListenRemove(listenkey); listenkey = llListen(chan +3,"",id,"");
              llDialog(id,"Choose access ",["Owner", "Group", "ALL"],chan+3);
          }
          else
          {
              gTexchair(text);
              llDialog(id,"Chair Texture Menu ",["RedOrange", "Grungy", "Damaged", "WalnutRed", "Weathered"],chan);
          }
      }
      if(ch == chan +3)
      {
          access = llListFindList(["Owner","Group","ALL"],[text]);
          menu(id);
      }
  }
 link_message(integer sender_num, integer num, string str, key id)
  {
      if(str == "Textures")
      {
          menu(id);
      }
  }
}
