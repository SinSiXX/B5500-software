COMMENT        PROCEDURE - DOUBLE PRECISION LOG,                        00000100
               CUBE LIBRARY NUMBER IS B100007.                          00000200
               THIS VERSION DATED 2/1/67;                               00000300
PROCEDURE DLN(XH1,XL1,YH1,YL1);VALUE XH1,XL1 ;REAL XH1,XL1,YH1,YL1 ;BEGI00000400
N REAL XH,XL,YH,YL,ZH,ZL,TH,TL ;LABEL L2 ;XH ~XH1 ;XL ~XL1 ;IF (XH >0.7700000500
880078307)AND (XH<1.2840254166)THEN BEGIN YH ~YL ~ZH ~ZL ~0 ;GO TO L2 ;E00000600
ND ;ZL ~0 ;ZH ~XH.[3:6];ZH.[1:1]~XH.[2:1];XH.[2:7]~76 ;ZH ~ZH +12 ;DOUBL00000700
E(ZH,ZL,,0.0794415416798359282517,|,~,YH,YL);ZH ~ZH +ZH ;IF XH >1.28402500000800
41669 THEN BEGIN IF XH <2.11700001661 THEN BEGIN DOUBLE(XH,XL,,0.606530600000900
59712633423604,|,~,XH,XL);ZH ~ZH +0.5 ;END ELSE IF XH <3.49034295746 THE00001000
N BEGIN DOUBLE(XH,XL,,0.36787944117144232159552,|,~,XH,XL);ZH ~ZH +1.0 ;00001100
END ELSE IF XH <5.75460267601 THEN BEGIN DOUBLE(XH,XL,,0.22313016014842900001200
8289333,|,~,XH,XL);ZH ~ZH +1.5 ;END ELSE BEGIN DOUBLE(XH,XL,,0.13533528300001300
236612691894,|,~,XH,XL);ZH ~ZH +2.0 ;END ;END ;L2:DOUBLE(XH,XL,,1.0,-,XH00001400
,XL,,1.0,+,/,~,XH,XL);DOUBLE(XH,XL,XH,XL,|,~,TH,TL);DOUBLE(TH,TL,,0.112900001500
708750620151577587,|,,0.1173892010486862079216,+,TH,TL,|,,0.13333807679000001600
7635793969,+,TH,TL,|,,0.1538461012595730090706,+,TH,TL,|,,0.18181818217800001700
4894978628,+,TH,TL,|,,0.2222222222207206091122,+,TH,TL,|,,0.28571428571400001800
2893064832,+,TH,TL,|,,0.3999999999999999956387,+,TH,TL,|,,0.66666666666600001900
6666666687,+,TH,TL,|,,2.0,+,XH,XL,|,ZH,ZL,+,YH,YL,+,~,YH1,YL1);END ;    00002000
