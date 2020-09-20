key ToucherID;
integer listenkey;
integer access = 0;
integer ch;

integer getlink(string primname)
{
    integer i; integer result= 9999;
    for(i=1; i<= llGetNumberOfPrims(); i++) if (llGetLinkName(i) == primname) result = i;
    return result;
}
menu(key id)
{
    if(id == llGetOwner() || access == 2
      || (access == 1 && llSameGroup(id)))
    {

        llListenRemove(listenkey); listenkey = llListen(ch,"",id,"");
        if(id != llGetOwner())
        {
            llDialog(id,"Menu ",["FRAME", "PILLOW", "CUSHIONS"],ch);
        }
        else
        {
            llDialog(id,"Menu ",["FRAME", "PILLOW", "CUSHIONS", "Access"],ch);
        }
    }
}
gTexframe(string gTex)
{
    if(gTex == "Tan")
    {
        llSetLinkPrimitiveParamsFast(getlink("frame"), [17, 0, "b1c96261-ae67-b0b5-7f1e-0e10ee6e907e", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 1, "43c2232f-bfb3-01cc-66a8-b5cb0b632264", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 2, "8935a50a-40c0-1acf-1077-fa94e47ddc35", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 4, "a162c4fe-d493-0510-4f36-a1be8e67723d", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 3, "fa116cfa-5a73-bef3-2d50-71b450588ded", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 5, "2f59a39f-4b67-aca6-0ae6-16a634fd362b", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 6, "ecee6c9b-f73a-dde3-9ebe-bf71dabfd092", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        llSetLinkPrimitiveParamsFast(getlink("frame"), [37, 0, "0f741947-ed4a-8c29-6bd7-d789551cc6f9", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "33500c65-7435-6fbe-e621-1c2b32deaa49", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 2, "bf9fa9f5-d5d8-9425-9611-1523adb8bbc6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 4, "a406749d-abbd-a4d7-3516-f1d6b51db757", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 3, "5cd22db3-0b33-6193-d94a-731f8bc0710f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 5, "e304a00c-7650-1862-114e-e8cb74d9a5b5", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 6, "266e8567-7d15-1dcc-4d83-3728c5c14c26", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 0, "6a6ab90c-dbb7-5613-6de6-fb40f6436ce6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 1, "3b92eeaf-bd2e-768b-471a-e646d16dc3ed", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 2, "ed273bdd-5079-67d8-74de-e9b3f66761ab", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 4, "da50a470-0278-4678-fcb0-efe59ce170f2", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 3, "8a08e59f-7d01-f0fa-4a4f-51ae10199de1", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 5, "c3dd7fcb-2f69-3227-0799-70a9d778b3ad", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 6, "fbd95a16-4e24-1cd0-0e1b-75a3c5f61cdd", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
    }
    else if(gTex == "Whitewash")
    {
        llSetLinkPrimitiveParamsFast(getlink("frame"), [17, 0, "e0923bed-a0be-672f-ef1e-ec254258b4fb", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 1, "4caa581d-9d25-b768-8468-55d91da7fa43", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 2, "8935a50a-40c0-1acf-1077-fa94e47ddc35", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 4, "a61eb919-639f-c7af-a3b3-dcb7190f9c8f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 3, "fad8c231-9438-063a-81f8-efc540cbd4d1", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 5, "5a4aa0fd-48d6-f98b-00f6-f8ce4a456c47", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 6, "f44e14b4-7012-a4cc-00a3-79375526bfc4", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        llSetLinkPrimitiveParamsFast(getlink("frame"), [37, 0, "0f741947-ed4a-8c29-6bd7-d789551cc6f9", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "33500c65-7435-6fbe-e621-1c2b32deaa49", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 2, "bf9fa9f5-d5d8-9425-9611-1523adb8bbc6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 4, "a406749d-abbd-a4d7-3516-f1d6b51db757", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 3, "5cd22db3-0b33-6193-d94a-731f8bc0710f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 5, "e304a00c-7650-1862-114e-e8cb74d9a5b5", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 6, "266e8567-7d15-1dcc-4d83-3728c5c14c26", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 0, "6a6ab90c-dbb7-5613-6de6-fb40f6436ce6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 1, "3b92eeaf-bd2e-768b-471a-e646d16dc3ed", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 2, "ed273bdd-5079-67d8-74de-e9b3f66761ab", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 4, "da50a470-0278-4678-fcb0-efe59ce170f2", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 3, "8a08e59f-7d01-f0fa-4a4f-51ae10199de1", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 5, "c3dd7fcb-2f69-3227-0799-70a9d778b3ad", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 6, "fbd95a16-4e24-1cd0-0e1b-75a3c5f61cdd", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
    }
    else if(gTex == "Brown")
    {
        llSetLinkPrimitiveParamsFast(getlink("frame"), [17, 0, "87b58e59-b6eb-7f8b-e066-2bbe01e280c5", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 1, "ac65437b-1663-8655-6928-8d3d9c642983", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 2, "8935a50a-40c0-1acf-1077-fa94e47ddc35", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 4, "5938f47a-70b6-90ab-f102-2607b87b3664", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 3, "b5fd701d-016c-7ca7-1156-f027b3dfc18b", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 5, "816db89a-7fb4-3918-6304-70930081df29", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 6, "65934382-6b2b-6ab7-73fd-aaaeb4dc3bef", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        llSetLinkPrimitiveParamsFast(getlink("frame"), [37, 0, "0f741947-ed4a-8c29-6bd7-d789551cc6f9", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "33500c65-7435-6fbe-e621-1c2b32deaa49", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 2, "bf9fa9f5-d5d8-9425-9611-1523adb8bbc6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 4, "a406749d-abbd-a4d7-3516-f1d6b51db757", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 3, "5cd22db3-0b33-6193-d94a-731f8bc0710f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 5, "e304a00c-7650-1862-114e-e8cb74d9a5b5", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 6, "266e8567-7d15-1dcc-4d83-3728c5c14c26", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 0, "6a6ab90c-dbb7-5613-6de6-fb40f6436ce6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 1, "3b92eeaf-bd2e-768b-471a-e646d16dc3ed", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 2, "ed273bdd-5079-67d8-74de-e9b3f66761ab", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 4, "da50a470-0278-4678-fcb0-efe59ce170f2", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 3, "8a08e59f-7d01-f0fa-4a4f-51ae10199de1", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 5, "c3dd7fcb-2f69-3227-0799-70a9d778b3ad", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 6, "fbd95a16-4e24-1cd0-0e1b-75a3c5f61cdd", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
    }
    else if(gTex == "Cherry")
    {
        llSetLinkPrimitiveParamsFast(getlink("frame"), [17, 0, "e4dcd03f-ce52-23ee-7095-26455957facf", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 1, "3c49a4d1-5ee8-eb04-d200-0bac7b047a89", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 2, "8935a50a-40c0-1acf-1077-fa94e47ddc35", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 4, "ba8d4ef7-cd71-891f-2b35-d6fc85efb2ae", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 3, "1b265997-cf36-ffd6-4ea3-8ebe56b344ea", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 5, "118126b0-f570-b22b-c0ae-b025a2a46303", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 6, "d46881a4-efe3-824d-226e-911d4ea3c6d7", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        llSetLinkPrimitiveParamsFast(getlink("frame"), [37, 0, "0f741947-ed4a-8c29-6bd7-d789551cc6f9", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "33500c65-7435-6fbe-e621-1c2b32deaa49", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 2, "bf9fa9f5-d5d8-9425-9611-1523adb8bbc6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 4, "a406749d-abbd-a4d7-3516-f1d6b51db757", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 3, "5cd22db3-0b33-6193-d94a-731f8bc0710f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 5, "e304a00c-7650-1862-114e-e8cb74d9a5b5", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 6, "266e8567-7d15-1dcc-4d83-3728c5c14c26", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 0, "6a6ab90c-dbb7-5613-6de6-fb40f6436ce6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 1, "3b92eeaf-bd2e-768b-471a-e646d16dc3ed", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 2, "ed273bdd-5079-67d8-74de-e9b3f66761ab", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 4, "da50a470-0278-4678-fcb0-efe59ce170f2", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 3, "8a08e59f-7d01-f0fa-4a4f-51ae10199de1", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 5, "c3dd7fcb-2f69-3227-0799-70a9d778b3ad", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 6, "fbd95a16-4e24-1cd0-0e1b-75a3c5f61cdd", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
    }
    else if(gTex == "Weathered")
    {
        llSetLinkPrimitiveParamsFast(getlink("frame"), [17, 0, "29c88367-7f4f-05dc-8dad-1459b8440c3a", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 1, "96a65e92-0579-cce5-d0c4-a04bea8cdcb6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 2, "8935a50a-40c0-1acf-1077-fa94e47ddc35", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 4, "7c3e529a-b6e8-f332-6826-d8f0eaf00bf0", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 3, "ead553a4-1437-d926-cdd3-eddce5848b82", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 5, "c6fdc57a-152d-922a-7954-f824d3c00c3f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 6, "42faba11-ea54-6781-d0e4-02dff43c0476", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
        llSetLinkPrimitiveParamsFast(getlink("frame"), [37, 0, "d24a0cd9-1edd-b60a-2f8c-8da63ece4e83", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "e9260d24-d79e-c105-05c8-df375a46d238", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 2, "bf9fa9f5-d5d8-9425-9611-1523adb8bbc6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 4, "58e5a412-ccba-0c8f-007a-50f7ea102acf", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 3, "4fefc1dc-a9d6-639c-47d5-2906a9857781", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 5, "5e114192-84da-62e5-ca84-612fdd1aee9c", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 6, "743f8c0b-763c-0044-c729-7501f4814e50", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 0, "fa73cfa3-e0ca-6121-da6a-4678e650018c", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 1, "5462cffe-6f48-143d-b98a-ba9725e7e8f2", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 2, "ed273bdd-5079-67d8-74de-e9b3f66761ab", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 4, "24e894c2-ff32-2704-208d-11170cf0f620", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 3, "b78c8f0e-d193-6f74-d036-b505d23f9b3d", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 5, "def84ff6-9846-e6bf-c241-e722476b7b65", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 36, 6, "58e5f40f-5cfa-987a-a0c1-9ac69faac3d5", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
    }
}
gTexpillow(string gTex)
{
    string color;
    if(gTex == "Tropical") color = "c67ff722-4212-8377-4a22-01fe5168c94b";
    else if(gTex == "Butterflies") color = "bb1b526c-33d1-3fce-ad23-834a4c247858";
    else if(gTex == "Flamingos") color = "645d6ba3-3152-c633-2cba-048a7ffb58fb";
    else if(gTex == "Hibiscus") color = "65eb3823-2020-2ad6-100c-bf3ea5e0028a";
    else if(gTex == "Pineapple") color = "0031d7d5-6566-d06b-e669-b4e10ac77d4f";
    else if(gTex == "Orchids") color = "fe12815d-019e-be23-465d-063699890b05";
    else if(gTex == "Modern") color = "172e4fa3-a654-fb91-8f77-8c1e55433b08";
    llSetLinkPrimitiveParamsFast(getlink("cushions"), [17, 2, color, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
}
gTexcushions(string gTex)
{
    string leftcushions;
    string centercushions;
    string rightcushions;
    if(gTex == "Chalk")
    {
        leftcushions = "498535bf-e1d5-c373-0845-a95aa6c4fd60";
        centercushions = "bc5379c6-971e-0373-b473-dd91d6e31f13";
        rightcushions = "20fdcafd-df2c-66bb-9e0d-56282e51d818";
    }
    else if(gTex == "Sand")
    {
        leftcushions = "40ece99c-0cad-bae4-8a94-e723bd9c6190";
        centercushions = "366abfa0-550e-73a3-461f-b85f056a9da3";
        rightcushions = "95c69530-0aa9-9805-c399-ebe203bd02e0";
    }
    else if(gTex == "Teal")
    {
        leftcushions = "6521dc62-3f8c-314e-c199-7b7ff78e72d4";
        centercushions = "1d9efcdf-6968-05bf-33ed-df8c1727c4ce";
        rightcushions = "2243dc7e-f532-3e3c-95d9-98c8624ca229";
    }
    else if(gTex == "Tangerine")
    {
        leftcushions = "b8667a8d-33d2-5390-2950-f7542bec8568";
        centercushions = "8979559f-0e92-c7b4-05fb-962c96de7a40";
        rightcushions = "cc87ab4e-6ebf-0104-89e3-e00dc7d9b822";
    }
    else if(gTex == "Lavender")
    {
        leftcushions = "076575f5-824c-18e5-029a-84cb1b676e17";
        centercushions = "4cdb456b-b28c-8cef-bea2-b4769e2cc0bd";
        rightcushions = "1d4de520-2a4d-a1f1-2de8-28a214b54553";
    }
    else if(gTex == "Olive")
    {
        leftcushions = "6c90512d-5ba5-a697-1edd-ce2e72694e00";
        centercushions = "7aac0eff-caae-c34f-ce8e-1b448d7b5f2d";
        rightcushions = "07024cf8-17d0-232e-5062-605e3d582a74";
    }
    else if(gTex == "Burgundy")
    {
        leftcushions = "f887a352-3cb8-0a0e-2e9a-0a16fdc2453b";
        centercushions = "64e55eb9-da3f-0945-84f7-3e031c1e1531";
        rightcushions = "aaba3c9a-9754-59b8-3dd1-8c080d8702ea";
    }
    llSetLinkPrimitiveParamsFast(getlink("cushions"), [17, 1, leftcushions, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 0, centercushions, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 17, 3, rightcushions, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
}
default
{
    state_entry()
    {
        ch = -(integer)("0x" + llGetSubString(llGetKey(),3,8));
    }

    touch_start(integer total_number)
    {
        menu(llDetectedKey(0));
    }
    listen(integer channel, string name, key id, string text)
    {
        if(text == "Back")
        {
            menu(id);
            return;
        }
        if(channel == ch)
        {
            if(text == "FRAME")
            {
                llListenRemove(listenkey); listenkey = llListen(ch +1,"",id,"");
                llDialog(id,"Frame Texture Menu ",["Tan", "Whitewash", "Brown", "Cherry", "Weathered", "Back"],ch+1);
            }
            if(text == "PILLOW")
            {
                llListenRemove(listenkey); listenkey = llListen(ch +2,"",id,"");
                llDialog(id,"Pillow Texture Menu ",["Tropical", "Butterflies", "Flamingos", "Hibiscus", "Pineapple", "Orchids", "Modern", "Back"],ch+2);
            }
            if(text == "CUSHIONS")
            {
                llListenRemove(listenkey); listenkey = llListen(ch +3,"",id,"");
                llDialog(id,"Cushions Texture Menu ",["Chalk", "Sand", "Teal", "Tangerine", "Lavender", "Olive", "Burgundy", "Back"],ch+3);
            }
            if(text == "Access")
            {
                llListenRemove(listenkey); listenkey = llListen(ch +4,"",id,"");
                llDialog(id,"Choose access ",["Owner", "Group", "ALL"],ch+4);
            }
        }
        if(channel == ch + 1)
        {
            gTexframe(text);
            llDialog(id,"Frame Texture Menu ",["Tan", "Whitewash", "Brown", "Cherry", "Weathered", "Back"],ch+1);
        }
        if(channel == ch + 2)
        {
            gTexpillow(text);
            llDialog(id,"Pillow Texture Menu ",["Tropical", "Butterflies", "Flamingos", "Hibiscus", "Pineapple", "Orchids", "Modern", "Back"],ch+2);
        }
        if(channel == ch + 3)
        {
            gTexcushions(text);
            llDialog(id,"Cushions Texture Menu ",["Chalk", "Sand", "Teal", "Tangerine", "Lavender", "Olive", "Burgundy", "Back"],ch+3);
        }
        if(channel == ch + 4)
        {
            access = llListFindList(["Owner","Group","ALL"],[text]);
        }
    }
}
