integer g_default = TRUE;
integer g_shaking;
integer Con_CHAN = -35229;
vector     g_origPos;

rotation g_origRot;

float     g_shakeTime = 0.001;
integer g_Count = 0;

rotation newRot() {
    rotation newRotation;
    float sign;
    if (llFrand(1.0) < 0.5) sign = -.1;
    else sign = .1;
    float x = g_origRot.x + (sign * 0.01);
    float y = g_origRot.y + (sign * 0.01);
    float z = g_origRot.z + (sign * 0.01);
    newRotation = <x,y,z,g_origRot.s>;
    return newRotation;
}

vector newPos() {
    float sign;
    if (llFrand(1.0) < 0.5) sign = -1.0;
    else sign = 1.0;
    float x = g_origPos.x + sign * llFrand(0.01);
    float y = g_origPos.y + sign * llFrand(0.01);
    float z = g_origPos.z + sign * llFrand(0.01);
    return <x,y,z>;
}
integer getlink(string primname)
{
    integer i; integer result= 9999;
    for(i=1; i<= llGetNumberOfPrims(); i++) if (llGetLinkName(i) == primname) result = i;
    return result;
}

gTexwalls(string gTex)
{
    string MBedT;
    string MBedN;
    string MBedS;
    string HallT;
    string HallN;
    string HallS;
    string BathT;
    string BathN;
    string BathS;
    string BedT;
    string BedN;
    string BedS;
    string OfficeT;
    string OfficeN;
    string OfficeS;
    string HydroT;
    string HydroN;
    string HydroS;
    string GenT;
    string GenN;
    string GenS;
    if(gTex == "Cracked")
    {
        MBedT = "088d90c0-dd2a-983a-c30b-5ce5ecaa7fc5";
        HallT = "f94a8a21-959e-59da-1cf8-a184db42c99f";
        BathT =  "93eb181a-3644-81aa-7044-a1d3b603eae7";
        BedT =  "5b676631-a6ba-dc1a-c8a6-90229657e5b6";
        OfficeT = "538baf1b-5a20-5d6c-c0df-fdc0eaca2391";
        HydroT = "274bba86-01b0-211c-d607-1cff1b1ec9e6";
        GenT =  "069397df-326a-ae31-633b-425954a4c706";
        MBedN = "85baaa3a-5433-b50e-1f73-e487de45e72c";
        HallN = "5e43f1db-cfd5-c167-ffff-a5c6b29c636b";
        BathN = "3bc9da5c-752c-c993-851f-4f4b3853d3bd";
        BedN =  "47311cb5-2eed-411e-fa9e-669a0b398760";
        OfficeN = "179cf75b-e506-8ed6-f3ba-094e81bdf30c";
        HydroN = "b6071083-7246-9518-363c-b5824d22d6e7";
        GenN = "ae0cd67f-54d8-6674-deb1-b283c5cfafd5";
        MBedS = "372daa6a-0983-9568-5ae6-10884a1976c5";
        HallS = "de4258cb-6a2a-57c1-0f59-b15479c0930e";
        BathS = "9a182e7e-bf14-4b82-4eb3-cff80b5d569f";
        BedS = "4803e1a3-3db3-e282-f60d-536286ff568c";
        OfficeS = "0f765206-2eb2-4a98-220d-a5bf3d9ee81a";
        HydroS = "f4c2a400-f27b-cd5d-1e11-45e59f6fdeec";
        GenS = "e2a89a68-2d29-0a9c-0944-1dbee6f64336";
    }
    else if(gTex == "NoCracks")
    {
        MBedT = "ff3e6608-8b6e-d033-1f09-6b8d28cf6357";
        HallT = "dc73ae15-6b13-a579-399b-d0aad0d30d8c";
        BathT = "d20da008-6ada-060c-d46a-41cebe5bd137";
        BedT = "ab0cf6a7-bad8-ff2a-76d0-515665775d8d";
        OfficeT = "82b70eca-cfd2-6027-1e3c-604e5856e0a9";
        HydroT = "dba68e95-fa07-6e29-457c-75d78e652e3b";
        GenT = "97247a66-1758-477b-40c6-fa543a8e60e1";
        MBedN = "b26348d8-ae6c-1ca9-afef-7b24ad2b5ea1";
        HallN = "b26348d8-ae6c-1ca9-afef-7b24ad2b5ea1";
        BathN = "b26348d8-ae6c-1ca9-afef-7b24ad2b5ea1";
        BedN = "b26348d8-ae6c-1ca9-afef-7b24ad2b5ea1";
        OfficeN = "b26348d8-ae6c-1ca9-afef-7b24ad2b5ea1";
        HydroN = "b26348d8-ae6c-1ca9-afef-7b24ad2b5ea1";
        GenN = "b26348d8-ae6c-1ca9-afef-7b24ad2b5ea1";
        MBedS = "832cbbd9-9eca-8cd2-06ac-b65efd56f9cd";
        HallS = "8171c8ed-b001-ade4-54ea-73357b25a8f1";
        BathS = "08dba534-fcb4-9ff2-8e16-9fde0b75fd77";
        BedS = "980bc8cd-6963-6017-e17c-8eda87f71892";
        OfficeS = "2dc8732a-9eff-84c3-a173-f1548b41cf49";
        HydroS = "c49cd30d-8540-bf7f-d846-4846b3e98bb1";
        GenS = "9758e79b-2c8f-663a-c826-04c0df7c6fd7";
    }
    else if(gTex == "Medieval")
    {
        MBedT = "48f48f60-2f17-8ee8-ec49-c14dc8259365";
        HallT = "690355d5-f9a6-674e-5a81-0fd4238ac269";
        BathT = "96c4d102-f46d-8c28-d056-53cf699f3202";
        BedT = "9a52ef26-390a-7678-e744-4d51f8f433f5";
        OfficeT = "16544860-40d2-2d96-3831-725476fdac24";
        HydroT = "4d5ccd1a-ef0a-b3cf-3453-0d544fb52d6d";
        GenT = "1ae21247-6030-a010-ed6c-782ecc4ddf87";
        MBedN = "53e07e08-9ab8-64b4-b5b8-d55e1b35d77c";
        HallN = "4b39a3e9-4d19-fb72-70b3-20231fac4cee";
        BathN = "17710627-c464-2e13-c5a0-49f8bd0d1536";
        BedN = "9b99bc5d-280b-c65d-c2d1-6b66b3fb547b";
        OfficeN = "03be40f1-54f3-5b19-c001-663436c3d6eb";
        HydroN = "ee1dbc4d-19ae-ea72-612e-3aa91ea1fc18";
        GenN = "3d07983d-8852-b0bc-b2c1-d220f01b44cc";
        MBedS = "7046d1ff-ab6c-9a9e-0847-40b3698243c4";
        HallS = "9412efb6-707b-6c21-2172-e74d670c5649";
        BathS = "1f5cdac0-222d-abfb-e0f9-5d75a345a5c2";
        BedS = "b7105b23-5879-177d-f7df-0d7b136527dd";
        OfficeS = "eed13450-5dff-20de-cb9d-0ceb2a47f52c";
        HydroS = "da15ddc9-a3ad-c741-67c6-56487b30fb3d";
        GenS = "54e9add8-3c82-a9a9-a1a9-07c7abf7be7d";
    }
    else if(gTex == "Country")
    {
        MBedT = "d9c6c2fd-a6ab-a3d0-2ec0-1b9bd699e6b3";
        HallT = "50cc5ef7-4595-733c-cca9-9b28c5478fdf";
        BathT = "fb0fa85c-2078-7107-33ca-ada711fb8e3b";
        BedT = "158d8f5c-372c-d34b-a95f-216329153e4f";
        OfficeT = "bca0de68-b8e7-1204-5f61-e9a20dff2dd1";
        HydroT = "85d6eaf6-7fe7-6599-b08e-b713cc0c42ca";
        GenT = "a83cd8ef-43d6-276c-d31f-988b9905f2c5";
        MBedN = "0615af8c-0faf-5143-ce05-255d8f12000a";
        HallN = "4cb441a3-0827-940a-684e-fec9a24884fa";
        BathN = "70e7f7cd-e1c1-6764-86cd-4400bfa82e4c";
        BedN = "3ce05548-588d-b3ab-48ac-b11d2c286f5c";
        OfficeN = "5704b582-f654-42d6-7118-6a3a43c994ba";
        HydroN = "df7c54df-81db-a608-eb5f-0b8bc3b07c3c";
        GenN = "f0c76629-01bc-b96f-710b-cb6c73162f75";
        MBedS = "68743855-758b-9eb3-9103-414ef48d7b07";
        HallS = "e37b6298-2f50-9bc9-2d61-2f4ef9d3303d";
        BathS = "796860a4-a498-895d-1f44-f8ee11fede61";
        BedS = "e7a07a82-f83f-e441-5684-e651144f7000";
        OfficeS = "de6d1ffe-1792-beeb-5067-af2040deff4f";
        HydroS = "1dbe66d8-7896-dc6b-b6c2-8fa6cb6b9ecc";
        GenS = "1dbe66d8-7896-dc6b-b6c2-8fa6cb6b9ecc";
    }
    else if(gTex == "Industrial")
    {
        MBedT = "37271c7c-9fd1-af61-ac6a-ee5c2beed233";
        HallT = "499d8164-f045-0e43-6876-c3adc239f976";
        BathT = "f6397f76-667a-5508-8a7b-2bf2271ae7c8";
        BedT = "9f0973d6-18ee-2d22-f20a-63b888785383";
        OfficeT = "72fb73d3-0085-afec-3ea5-84a7dc3e8f54";
        HydroT = "187ee1c5-ebba-954b-b40b-1932ab075968";
        GenT = "9d6d1ab3-0086-cdd7-6364-c4b329616eeb";
        MBedN = "797de464-215e-faef-9d86-b53c29835542";
        HallN = "0f35fb75-ef6a-87d8-f664-bd97ed382119";
        BathN = "44c9453d-2a7d-f148-de0c-04990c1e2c12";
        BedN = "0a181021-f22a-42a7-583f-d943bb42d819";
        OfficeN = "d55c447e-b030-aec6-7886-290d416a2b3a";
        HydroN = "2c530c5f-d161-8f71-b748-154181ed16c7";
        GenN = "e434d116-530c-fce4-530d-b7e1b93c6535";
        MBedS = "2c956569-da3d-77ef-e5fb-19e846ccbf5e";
        HallS = "480f0bf4-6226-e14e-eb3f-9e4e27d33089";
        BathS = "92371273-10f9-1a66-01eb-bd26e42ff5c9";
        BedS = "616bf5e3-d464-ad27-09e6-deb78191cf98";
        OfficeS = "cdd2aa74-207c-ab2d-ce55-55886595f2c0";
        HydroS = "f7326485-e9e9-7e4d-cfa0-c4b736d53d82";
        GenS = "a2cd5cdd-9b42-e0d4-a396-fe30fe608353";
    }
    llSetLinkPrimitiveParamsFast(getlink("walls"), [17, 6, MBedT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    17,  4, HallT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    17, 0, BathT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    17, 1, BedT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    17, 7, OfficeT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    17, 5, HydroT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    17, 3, GenT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
    llSetLinkPrimitiveParamsFast(getlink("walls"), [37, 6, MBedN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    37, 4, HallN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    37, 0, BathN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    37, 1, BedN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    37, 7, OfficeN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    37, 5, HydroN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
    37, 3, GenN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0]);
    llSetLinkPrimitiveParamsFast(getlink("walls"), [36, 6, MBedS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0,
    36, 4, HallS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0,
    36, 0, BathS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0,
    36, 1, BedS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0,
    36, 7, OfficeS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0,
    36, 5, HydroS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0,
    36, 3, GenS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
}
gTexdoors(string gTex)
{
    string FrameT;
    string FrameN;
    string FrameS;
    string Door1T;
    string Door1N;
    string Door1S;
    if(gTex == "White")
    {
        FrameT = "45194654-7249-16b5-2529-624f7aae7eb8";
        FrameN = "b678c0be-a3d1-6cf8-5660-8785f6bf75e2";
        FrameS = "b5b1f281-b62c-909e-4972-d1138feb640a";
        Door1T = "e1ec8387-eeba-caa9-bc82-1d2522a4aaff";
        Door1N = "27402238-2dcc-f12a-7437-7a6a8fd958e7";
        Door1S = "ad1eeecc-7d5b-e105-d8da-e333c4ea5c51";

    }
    else if(gTex == "Steel")
    {
       FrameT = "134593b3-b191-bcc3-ebfe-faf93293c56e";
       FrameN = "77f65237-fe84-c14f-56c5-2f61a351c8e6";
       FrameS = "57eb7b91-7ba5-b7fc-61dd-c0222ae2d14d";
       Door1T = "29faeacb-b275-77df-2abf-b56bf3618310";
       Door1N = "8bcdd864-2df0-af4a-7b29-b2f6121161a8";
       Door1S = "a6651b14-10d6-2fea-de23-128af3e02d2c";

    }
    else if(gTex == "Wood")
    {
       FrameT = "38c880dd-40dd-22a5-ba5b-67e4cccaf929";
       FrameN = "66c701fd-7d6e-f7a1-874d-e2fb04ba20be";
       FrameS = "2a84b419-afb5-c8e8-824b-5f51f488a05a";
       Door1T = "0c03efd7-ad48-f2d6-2fcb-c861cc358f69";
       Door1N = "2cf1ecc7-f664-e5c7-afe4-b3647638d61c";
       Door1S = "ea785353-0960-7256-cdeb-d1043674d5cd";

    }
    else if(gTex == "Worn")
    {
       FrameT = "d7c54f0e-4d9e-9c5c-9b7d-47fcc82963d4";
       FrameN = "5da37279-1dcb-d112-550c-fcba3afdc72c";
       FrameS = "175d83be-01b4-d909-b0db-ff4f3c6deab9";
       Door1T = "fcf45d8f-322c-0382-0d6a-44fceb125f28";
       Door1N = "22a90471-fe38-3b7c-f48e-e5f3bc3a85d0";
       Door1S = "0cb65d9b-42aa-7b08-f607-f566af23348c";

    }
    llSetLinkPrimitiveParamsFast(getlink("walls"), [17, 2, FrameT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, 2, FrameN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, 2, FrameS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        llSetLinkPrimitiveParamsFast(getlink("door1"), [17, ALL_SIDES, Door1T, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, ALL_SIDES, Door1N, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, ALL_SIDES, Door1S, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        llSetLinkPrimitiveParamsFast(getlink("door2"), [17, ALL_SIDES, Door1T, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, ALL_SIDES, Door1N, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, ALL_SIDES, Door1S, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        llSetLinkPrimitiveParamsFast(getlink("door3"), [17, ALL_SIDES, Door1T, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, ALL_SIDES, Door1N, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, ALL_SIDES, Door1S, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        llSetLinkPrimitiveParamsFast(getlink("door4"), [17, ALL_SIDES, Door1T, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, ALL_SIDES, Door1N, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, ALL_SIDES, Door1S, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        llSetLinkPrimitiveParamsFast(getlink("door5"), [17, ALL_SIDES, Door1T, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, ALL_SIDES, Door1N, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, ALL_SIDES, Door1S, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        llSetLinkPrimitiveParamsFast(getlink("door6"), [17, ALL_SIDES, Door1T, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, ALL_SIDES, Door1N, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, ALL_SIDES, Door1S, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        llSetLinkPrimitiveParamsFast(getlink("door7"), [17, ALL_SIDES, Door1T, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        37, ALL_SIDES, Door1N, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0,
        36, ALL_SIDES, Door1S, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);

}
gTexfloors(string gTex)
{
    string livingT;
    string livingN;
    string livingS;
    string bedroomT;
    string bedroomN;
    string bedroomS;
    string utilitiesT;
    string utilitiesN;
    string utilitiesS;
    if(gTex == "Medieval")
    {
        livingT = "2d905d8e-11a1-831b-5178-dba0d393e4f5";
        bedroomT = "4dd47c6e-0734-837d-a26d-570281387e37";
        utilitiesT = "f80ca8a8-fba0-b848-da89-9890c8bfd87e";
        livingN = "d0aa5892-14a7-d5d4-f996-5084aa676a76";
        bedroomN = "6452b6aa-d188-f387-249b-1f96b4484476";
        utilitiesN = "0ef4e569-6fba-1102-a517-efc560b5d6a8";
        livingS = "acad0764-05b6-6260-3067-43e0094f248b";
        bedroomS = "8988deef-108b-f8f2-1491-5a95e7cbef29";
        utilitiesS = "5bdc1893-0953-d78d-9006-4f4dcb6b2c79";
    }
    else if(gTex == "Grey")
    {
        livingT = "b9c2af1b-21a3-3eff-042b-1d724167ad26";
        bedroomT = "1be22479-5ad6-5f90-a136-e8b6310d7f3d";
        utilitiesT = "c955b393-0b91-1948-3196-e68ce2c6e751";
        livingN = "0513db0c-87e5-cf6b-870c-7f3e69651b8e";
        bedroomN = "9cc8b7a0-9bf2-abab-3fa8-5e6d5a4966b5";
        utilitiesN = "785b1fb9-465a-9781-a791-a1a29a84e26f";
        livingS = "9d01f28f-49b5-5428-fb20-e6c750b6fccb";
        bedroomS = "0521d0c9-8d9e-880c-e095-4067056cf056";
        utilitiesS = "16dad518-875d-417a-2980-477804ca6e21";
    }
    else if(gTex == "Country")
    {
        livingT = "bd01a319-3288-d087-797d-23b0bad70df3";
        bedroomT = "d2696b03-82b3-0146-a06b-440cc6e460ff";
        utilitiesT = "dce266f2-d2f0-bd2b-ca7e-976cf65212fa";
        livingN = "e8c706c7-76b1-3652-1f3b-d81304294c81";
        bedroomN = "ab3b2c5a-e1d0-9bfa-bc0e-bb399b925332";
        utilitiesN = "a16bd0f1-70e4-fe24-6fca-450fbe760ac6";
        livingS = "91b4f970-6d2c-96f3-f3f4-8541268ab7ac";
        bedroomS = "c542d155-e679-f7c8-3922-f18016f0942a";
        utilitiesS = "28f13149-60b7-cec1-d89e-5b2b30ac4a06";
    }
    else if(gTex == "Industrial")
    {
        livingT = "dcf40629-b3c6-c3f4-18da-b6cdfac31245";
        bedroomT = "9d9ced2c-b63e-4300-f206-3be81f1ce1f0";
        utilitiesT = "c1843c20-2fdf-5fdf-b077-43a67210970b";
        livingN = "4577ae2f-93e3-3a1c-9ee5-5205cfd6aabb";
        bedroomN = "1ae3fa5e-65c1-b3b7-87d0-900ba25ae711";
        utilitiesN = "3da03222-bb22-6f37-e07f-c66cb9f83a90";
        livingS = "496fb023-6d4c-98a7-c986-a07de71fca4a";
        bedroomS = "ac59e6fb-9c69-c1c1-baef-576b8eaefcd3";
        utilitiesS = "8d7c7fb6-19ec-750a-0f87-c11eec632292";
    }
    llSetLinkPrimitiveParamsFast(getlink("floor"), [17, 0, bedroomT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 0, bedroomN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 0, bedroomS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 17, 1, livingT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, livingN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, livingS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0, 17, 3, utilitiesT, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 3, utilitiesN, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 3, utilitiesS, <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
}

default
{
    state_entry() {
        g_shaking = FALSE;
        g_origPos = llGetRootPosition();
        g_origRot = llGetRootRotation();
        gTexwalls("NoCracks");
        gTexfloors("Grey");
        gTexdoors("White");
        llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "4ff47b46-497b-75ff-692b-46a63463371f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "52a41c2c-0b08-9fae-47bc-9ea9b4002da7", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "99978dc3-3008-e249-0e1f-3fe2d173af93", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        llListen(Con_CHAN, "", "", "");
    }
    on_rez(integer start_param)
    {
        llResetScript();
    }

    listen( integer channel, string name, key id, string message ) {
        if(message == "rezbomb")
        {
            llRezObject("atomic bomb", llGetPos() + <0.0, 10.0, 25.0> * llGetRot(), <0.0, 0.0, 0.0>, llGetRot(), 0);
            llSleep(1);
            llShout(Con_CHAN, "drop");
        }

        if(message == "boom")
        {
            if (g_shaking) {
                llSetTimerEvent(0.0);
                llSetLinkPrimitiveParamsFast(LINK_ROOT, [
                    PRIM_POSITION, g_origPos,
                    PRIM_ROTATION, g_origRot
                ]);
            }
            else {
                g_origPos = llGetRootPosition();
                g_origRot = llGetRootRotation();

                if(g_default) gTexwalls("Cracked");
                g_shaking = TRUE;
                g_Count = 0;
                while (g_Count < 750) {
                    vector shakePos = newPos();
                    rotation shakeRot = newRot();
                    llSetLinkPrimitiveParamsFast(LINK_ROOT, [
                    PRIM_POSITION, shakePos,
                    PRIM_ROTATION, shakeRot
                    ]);
                    ++g_Count;
                }
                list params = [];
                integer index = 0;
                while(index <= 6) {
                    params = llListReplaceList(llGetLinkPrimitiveParams(getlink("ground"),[PRIM_TEXTURE,index]),[PRIM_TEXTURE,index,"d5160a17-1e5d-1bd3-4be1-3ae6f66adcd4"],0,0);
                    llSetLinkPrimitiveParamsFast(getlink("ground"), params);
                    ++index;
                }
                llSleep(1);
                llSetLinkPrimitiveParamsFast(LINK_ROOT, [
                    PRIM_POSITION, g_origPos,
                    PRIM_ROTATION, g_origRot
                ]);
                //llSleep(2);
                //llSetLinkPrimitiveParams(LINK_SET, [PRIM_PHYSICS_SHAPE_TYPE, 0]);
                g_shaking = FALSE;
                llSetTimerEvent(300);
            }
        }
        else if(message == "Location")
        {
            vector bunkerpos = llGetRootPosition();
            llShout(Con_CHAN + 10, (string)bunkerpos);
        }
        //else if(llSubStringIndex(message),"Walls") != -1)
        else if(message == "CrackedWalls") gTexwalls("Cracked");
        else if(message == "DefaultWalls")
        {
            gTexwalls("NoCracks");
            g_default = TRUE;
        }
        else if(message == "IndustrialDoors") gTexdoors("Steel");
        else if(message == "DefaultDoors") gTexdoors("White");
        else if(message == "MedievalDoors") gTexdoors("Worn");
        else if(message == "CountryDoors") gTexdoors("Wood");
        else if(message == "MedievalFloors") gTexfloors("Medieval");
        else if(message == "DefaultFloors") gTexfloors("Grey");
        else if(message == "CountryFloors") gTexfloors("Country");
        else if(message == "IndustrialFloors") gTexfloors("Industrial");
        else if(message == "MedievalWalls") gTexwalls("Medieval");
        else if(message == "CountryWalls") gTexwalls("Country");
        else if(message == "IndustrialWalls") gTexwalls("Industrial");
        else if(message == "DefaultOuter") llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "4ff47b46-497b-75ff-692b-46a63463371f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "52a41c2c-0b08-9fae-47bc-9ea9b4002da7", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "99978dc3-3008-e249-0e1f-3fe2d173af93", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        else if(message == "MedievalOuter") llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "357daddd-3bc6-6505-5c3d-59b18fa3d251", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "e1a58eb0-c8ee-1fc6-cfb7-14832509fa3a", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "9aa3ca2f-b64b-ba47-2b12-1400b126eb75", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        else if(message == "CountryOuter") llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "9fe4e7a6-1f42-7cc8-e840-4a26ca1f9b99", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "6f1f79f5-8fc6-b4ac-d824-014811f39b55", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "be7f09f6-b4f5-8fd3-7725-c812dc9a5085", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        else if(message == "IndustrialOuter") llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "22efd5b8-f1cd-a1bf-ab7a-e76e2e1081f4", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "7f804826-68c2-42ce-fcf8-1ae74dde7e6b", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "22960c3d-e41b-7b24-01c3-74c16495fb0b", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        else if(message == "WallpaperOuter") llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "2a8e2c4d-aaa2-f6b1-7506-c2b35af81166", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "5c7dad30-11e4-ab28-b7a6-0ae84d88f756", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "40e6e2f4-283a-c341-cf73-a78cc0f392a6", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        else if(message == "Default")
        {
            g_default = TRUE;
            gTexdoors("White");
            gTexwalls("NoCracks");
            gTexfloors("Grey");
            llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "4ff47b46-497b-75ff-692b-46a63463371f", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "52a41c2c-0b08-9fae-47bc-9ea9b4002da7", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "99978dc3-3008-e249-0e1f-3fe2d173af93", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        }
        else if(message == "Medieval")
        {
            g_default = FALSE;
            gTexdoors("Worn");
            gTexwalls(message);
            gTexfloors(message);
            llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "357daddd-3bc6-6505-5c3d-59b18fa3d251", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "e1a58eb0-c8ee-1fc6-cfb7-14832509fa3a", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "9aa3ca2f-b64b-ba47-2b12-1400b126eb75", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        }
        else if(message == "Country")
        {
            g_default = FALSE;
            gTexdoors("Wood");
            gTexwalls(message);
            gTexfloors(message);
            llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "9fe4e7a6-1f42-7cc8-e840-4a26ca1f9b99", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "6f1f79f5-8fc6-b4ac-d824-014811f39b55", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "be7f09f6-b4f5-8fd3-7725-c812dc9a5085", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        }
        else if(message == "Industrial")
        {
            g_default = FALSE;
            gTexdoors("Steel");
            gTexwalls(message);
            gTexfloors(message);
            llSetLinkPrimitiveParamsFast(getlink("boxwalls"), [17, 1, "22efd5b8-f1cd-a1bf-ab7a-e76e2e1081f4", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 37, 1, "7f804826-68c2-42ce-fcf8-1ae74dde7e6b", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, 36, 1, "22960c3d-e41b-7b24-01c3-74c16495fb0b", <1.0, 1.0, 0.0>, ZERO_VECTOR, 0.0, <1.0, 1.0, 1.0>, 51, 0]);
        }
        else if(message == "Grass")
        {
            string groundtexture;
            if(llGetInventoryName(INVENTORY_TEXTURE, 0) == "Grass") groundtexture = (string)llGetInventoryKey("Grass");
            else groundtexture = "f333864e-d928-9881-0c72-8c7701428bd3";
            list params = [];
            integer index = 0;
            while(index <= 6) {
                params = llListReplaceList(llGetLinkPrimitiveParams(getlink("ground"),[PRIM_TEXTURE,index]),[PRIM_TEXTURE,index,groundtexture],0,0);
                llSetLinkPrimitiveParamsFast(getlink("ground"), params);
                ++index;
            }
        }
        else if(message == "Dirt")
        {
            list params = [];
            integer index = 0;
            while(index <= 6) {
                params = llListReplaceList(llGetLinkPrimitiveParams(getlink("ground"),[PRIM_TEXTURE,index]),[PRIM_TEXTURE,index,"d5160a17-1e5d-1bd3-4be1-3ae6f66adcd4"],0,0);
                llSetLinkPrimitiveParamsFast(getlink("ground"), params);
                ++index;
            }
        }
        else if(message == "Mossy")
        {
            list params = [];
            integer index = 0;
            while(index <= 6) {
                params = llListReplaceList(llGetLinkPrimitiveParams(getlink("ground"),[PRIM_TEXTURE,index]),[PRIM_TEXTURE,index,"c34ef416-569e-61fe-dbbb-a71a0a969fe9"],0,0);
                llSetLinkPrimitiveParamsFast(getlink("ground"), params);
                ++index;
            }
        }
        else if(message == "Sparse")
        {
            list params = [];
            integer index = 0;
            while(index <= 6) {
                params = llListReplaceList(llGetLinkPrimitiveParams(getlink("ground"),[PRIM_TEXTURE,index]),[PRIM_TEXTURE,index,"eda2402d-59bb-fe0c-d648-94a0f10632cf"],0,0);
                llSetLinkPrimitiveParamsFast(getlink("ground"), params);
                ++index;
            }
        }
        else if(message == "Stoney")
        {
            list params = [];
            integer index = 0;
            while(index <= 6) {
                params = llListReplaceList(llGetLinkPrimitiveParams(getlink("ground"),[PRIM_TEXTURE,index]),[PRIM_TEXTURE,index,"2c82df5f-2ad6-3d5d-1f8a-46143f9221da"],0,0);
                llSetLinkPrimitiveParamsFast(getlink("ground"), params);
                ++index;
            }
        }

    }
    timer()
    {
        list params = [];
        integer index = 0;
        while(index <= 6) {
            params = llListReplaceList(llGetLinkPrimitiveParams(getlink("ground"),[PRIM_TEXTURE,index]),[PRIM_TEXTURE,index,"f333864e-d928-9881-0c72-8c7701428bd3"],0,0);
            llSetLinkPrimitiveParamsFast(getlink("ground"), params);
            ++index;
        }
    }
}
