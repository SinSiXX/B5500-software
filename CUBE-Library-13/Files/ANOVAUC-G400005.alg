          BEGIN                                                         00000100
FILE IN        CARD(2,10);                                              00000200
FILE OUT       LINE 4(2,15);                                            00000300
INTEGER        COLUMN, ROW, NOC, I, J, L,DFI,NC, N, DFC, DFR, DFE, DFT; 00000400
REAL           SRS,SRSS,CSC,SSCO,SSRO,SSER,SSIN,MSR,MSC,MSI,MSE,FCOL,   00000500
               FROW,FINT,Y,SSTO;                                        00000600
LABEL          START, EOF;                                              00000700
FORMAT IN      FIN(2I2);                                                00000800
FORMAT IN      FIN1(I4);                                                00000900
FORMAT         FIN2(////////////////////////////////////////////////////00001000
               //////////////////////////////////////////////////////// 00001100
               //////////////////////////////////////////////////////// 00001200
               /////////////////////////////////////////////////////);  00001300
FORMAT OUT     TITLE(////X13,"TWO WAY ANALYSIS OF VARIANCE"/            00001400
                     X11,"WITH PROVISIONS FOR UNEVEN CELLS"//           00001500
                     X17,"SS",X8,"DF",X11,"MS",X12,"F");                00001600
FORMAT OUT     FT1("C",X9,F12.2,X3,F5.0,X3,F12.2,X3,F8.3);              00001700
FORMAT OUT     FT2("R",X9,F12.2,X3,F5.0,X3,F12.2,X3,F8.3);              00001800
FORMAT OUT     FT3("R*C",X7,F12.2,X3,F5.0,X3,F12.2,X3,F8.3);            00001900
FORMAT OUT     FT4("ERROR",X7,F10.2,X3,F5.0,X5,F10.2);                  00002000
FORMAT OUT     FT5("TOTAL",X7,F10.2,X3,F5.0);                           00002100
PROCEDURE OBJECTFMTGEN(INFORMAT);FORMAT INFORMAT;BEGIN OWN REAL NCR,NFWD00002200
,ELCLASS;OWN REAL LCR;OWN INTEGER CNT,TCNT,RSLT,F;OWN INTEGER FMAX;OWN R00002300
EAL ARRAY ACCUM[0:9];SAVE OWN REAL ARRAY GENF[0:259];SAVE OWN REAL ARRAY00002400
 IMAG[0:9];OWN REAL ARRAY PRNT[0:19];OWN BOOLEAN ERRTOG;LABEL FINISHED;S00002500
TREAM PROCEDURE TATTLE(F,LINE);VALUE F;BEGIN SI~LOC F;DI~LINE;10(DS~LIT"00002600
 ");DS~9LIT"FMT SIZE ";DS~3DEC;DS~4LIT" WDS";47(DS~2LIT"  ");END OF TATT00002700
LE;PROCEDURE FLAG(ERRNUM);INTEGER ERRNUM;BEGIN STREAM PROCEDURE INSERT(E00002800
RR,LINE,ACCUM,CNT);VALUE ERR,CNT;BEGIN SI~LOC ERR;DI~LINE;10(DS~LIT"X");00002900
DS~16LIT"  SYNTAX ERROR #";DS~3DEC;DS~4LIT"  ..";SI~ACCUM;SI~SI+3;DS~CNT00003000
 CHR;DS~4LIT"..  ";10(DS~LIT"X");36(DS~2LIT"  ");END OF INSERT;INSERT(ER00003100
RNUM,PRNT[0],ACCUM[1],CNT);WRITE(LINE,15,PRNT[*]);ERRTOG~TRUE;END OF FLA00003200
G;PROCEDURE ERR(ERRNUM);INTEGER ERRNUM;BEGIN FLAG(ERRNUM);END;REAL STREA00003300
M PROCEDURE SETUP(CARD,LINE,LCR);BEGIN LOCAL SET1;SI~CARD;DI~LINE;DS~10W00003400
DS;40(DS~2LIT"  ");SI~CARD;SET1~SI;DI~LOC SETUP;SI~LOC SET1;DS~WDS;DI~CA00003500
RD;9(DI~DI+8);SET1~DI;DS~LIT"%";SI~LOC SET1;DI~LCR;DS~WDS;END OF SETUP;R00003600
EAL STREAM PROCEDURE FMTF(FMTIN);BEGIN LOCAL ST;SI~FMTIN;DI~LOC FMTF;ST~00003700
SI;SI~LOC ST;DS~WDS;END OF FMTF;REAL STREAM PROCEDURE EXAMIN(NCR);VALUE 00003800
NCR;BEGIN SI~NCR;DI~LOC EXAMIN;DI~DI+7;DS~CHR;END OF EXAMIN;REAL STREAM 00003900
PROCEDURE CONV(ACCUM,SKP,N);VALUE SKP,N;BEGIN SI~ACCUM;SI~SI+SKP;SI~SI+300004000
;DI~LOC CONV;DS~N OCT;END OF CONV;REAL PROCEDURE CONVERT;BEGIN REAL T;IN00004100
TEGER N;T~CONV(ACCUM[1],TCNT,N~(CNT-TCNT)MOD 8);FOR N~TCNT+N STEP 8UNTIL00004200
 CNT-1DO T~T|100000000+CONV(ACCUM[1],N,8);CONVERT~T;END OF CONVERT;STREA00004300
M PROCEDURE SCAN(NCRV,NCR,ACCUM,CNT,CNTV,RSLT,RSLTV,AC);VALUE NCRV,CNTV,00004400
RSLTV,AC;BEGIN LOCAL ST1,ST2;LABEL DEBLANK,GETCHR,NUMBER,EXIT,FINIS;LABE00004500
L L;SI~NCRV;DI~RSLT;DI~DI+7;CI~CI+RSLTV;GO TO FINIS;GO TO FINIS;GO TO FI00004600
NIS;GO TO NUMBER;GO TO FINIS;GO TO GETCHR;GO TO FINIS;DEBLANK:IF SC=" "T00004700
HEN BEGIN L:SI~SI+1;IF SC=" "THEN GO TO L;END;GO TO FINIS;GETCHR:DS~LIT"00004800
2";TALLY~1;SI~SI+1;GO TO EXIT;NUMBER:TALLY~63;DS~LIT"3";AC(TALLY~TALLY+100004900
;IF SC<"0"THEN JUMP OUT TO EXIT;SI~SI+1);EXIT:ST1~TALLY;TALLY~TALLY+CNTV00005000
;ST2~TALLY;DI~CNT;SI~LOC ST2;DS~WDS;DI~ACCUM;SI~SI-3;DS~3CHR;DI~DI+CNTV;00005100
SI~NCRV;DS~ST1 CHR;FINIS:DI~NCR;ST1~SI;SI~LOC ST1;DS~WDS;END OF SCAN;PRO00005200
CEDURE READACARD;BEGIN READ(CARD,10,IMAG[*]);NCR~SETUP(IMAG[0],PRNT[0],L00005300
CR);WRITE(LINE,15,PRNT[*]);END OF READACARD;PROCEDURE SCANNER;BEGIN LABE00005400
L L;L:SCAN(NCR,NCR,ACCUM[1],CNT,CNT,RSLT,RSLT,63-CNT);IF NCR=LCR THEN BE00005500
GIN READACARD;GO TO L;END;END OF SCANNER;PROCEDURE NEXTENT;BEGIN CNT~ACC00005600
UM[1]~0;IF EXAMIN(NCR)=" "THEN BEGIN RSLT~7;SCANNER;END DEBLANK;IF EXAMI00005700
N(NCR){9THEN BEGIN RSLT~3;SCANNER;TCNT~0;IF CNT>4THEN FLAG(140)ELSE IF E00005800
LCLASS~-CONVERT<-1023THEN FLAG(140)END ELSE BEGIN RSLT~5;SCANNER;ELCLASS00005900
~ACCUM[1].[18:6];END;END OF NEXTENT;STREAM PROCEDURE MOVECODE(TEMP,FINAL00006000
,RPT,REM);VALUE RPT,REM;BEGIN LOCAL ST1;SI~TEMP;DI~FINAL;DS~REM WDS;ST1~00006100
SI;SI~LOC RPT;SI~SI+7;IF SC!"0"THEN BEGIN SI~ST1;RPT(DS~63WDS);END;END O00006200
F MOVECODE;PROCEDURE MAXWDS(INFORMAT);FORMAT INFORMAT;BEGIN OWN INTEGER 00006300
CTR,FLG;LABEL RETURN,EX;INTEGER STREAM PROCEDURE WDCTR(FMT,CTR,FLG);VALU00006400
E CTR;BEGIN LOCAL ST1;LABEL SCAN,FND,EXIT;SI~LOC CTR;SI~SI+7;DI~LOC ST1;00006500
DS~4LIT"0000";DI~DI-4;IF SC="0"THEN BEGIN SI~FMT;GO TO SCAN;END;SI~FMT;C00006600
TR(63(SI~SI+8));SCAN:63(IF 4SC=DC THEN JUMP OUT TO FND;TALLY~TALLY+1;DI~00006700
DI-4;SI~SI+4);ST1~TALLY;GO TO EXIT;FND:ST1~TALLY;SI~SI-4;DI~FLG;DS~WDS;E00006800
XIT:SI~LOC ST1;DI~LOC WDCTR;DS~WDS;END OF WDCTR;FMAX~CTR~FLG~0;RETURN:FM00006900
AX~FMAX+WDCTR(INFORMAT,CTR,FLG);IF FLG!0THEN GO TO EX;CTR~CTR+1;GO TO RE00007000
TURN;EX:END OF MAXWDS;STREAM PROCEDURE LARGER(LINE,F);VALUE F;BEGIN SI~L00007100
OC F;DI~LINE;10(DS~LIT"X");DS~41LIT"  FORMAT TOO LARGE (RECEIVER FMT SIZ00007200
E IS ";DS~3DEC;DS~9LIT" WORDS)  ";10(DS~LIT"X");47(DS~LIT" ");END OF LAR00007300
GER;PROCEDURE GETINT;BEGIN NEXTENT;IF ELCLASS~-ELCLASS<0THEN BEGIN FLAG(00007400
137);ELCLASS~0END END GETINT;INTEGER PROCEDURE DIVIDE(NUMBER,P1,P2);VALU00007500
E NUMBER;INTEGER P1,P2,NUMBER;BEGIN IF NUMBER<0THEN BEGIN FLAG(138);NUMB00007600
ER~0END;P1~IF NUMBER<8THEN NUMBER ELSE 8;NUMBER~NUMBER-P1;P2~IF NUMBER<800007700
THEN NUMBER ELSE 8;DIVIDE~NUMBER-P2 END DIVIDE;STREAM PROCEDURE WHIPOUT(00007800
NFWDV,W,NFWD);VALUE NFWDV;BEGIN LOCAL ST;SI~W;DI~NFWDV;DS~WDS;ST~DI;DI~N00007900
FWD;SI~LOC ST;DS~WDS;END OF WHIPOUT;BOOLEAN PROCEDURE FORMATPHRASE;BEGIN00008000
 LABEL EL,EX,EXIT,L1,L2,L3;PROCEDURE EMITFORMAT(S,CODE,REPEAT,SKIP,W,W1,00008100
W2,D1,D2);VALUE S,CODE,REPEAT,SKIP,W,W1,W2,D1,D2;REAL CODE,REPEAT,SKIP,W00008200
,W1,W2,D1,D2;BOOLEAN S;BEGIN IF W>63THEN FLAG(163);W~REPEAT&W[6:42:6]&SK00008300
IP[32:42:6]&W1[28:44:4]&W2[24:44:4]&D1[20:44:4]&D2[16:44:4]&CODE[2:44:4]00008400
&REAL(S)[1:47:1];F~F+1;WHIPOUT(NFWD,W,NFWD);END EMITFORMAT;STREAM PROCED00008500
URE PACKALPHA(PLACE,LETTER,CTR);VALUE LETTER,CTR;BEGIN DI~PLACE;DS~LIT"B00008600
";SI~LOC CTR;SI~SI+7;DS~CHR;SI~PLACE;SI~SI+3;DS~5CHR;SI~LOC LETTER;SI~SI00008700
+7;DS~CHR END PACKALPHA;INTEGER REPEAT,SKIP,W,W1,W2,D1,D2,CODE;BOOLEAN S00008800
;INTEGER ST;DEFINE RRIGHT=0#,RLEFT=4#,RSTROKE=6#;DEFINE RSCALE=8#,RR=15#00008900
;DEFINE RD=0#,RX=2#,RA=4#,RI=6#,RF=8#,RE=10#,RO=12#,RL=14#;IF ELCLASS<0T00009000
HEN BEGIN REPEAT~-ELCLASS;NEXTENT;IF ELCLASS=","THEN GO EX END ELSE REPE00009100
AT~REAL(ELCLASS!"("AND ELCLASS!"<");IF ELCLASS="("OR ELCLASS="<"THEN BEG00009200
IN SKIP~F;EMITFORMAT(TRUE,RLEFT,REPEAT,1,0,0,0,0,0);DO BEGIN NEXTENT;EL:00009300
IF FORMATPHRASE THEN GO TO EX END UNTIL ELCLASS!",";WHILE ELCLASS="/"DO 00009400
BEGIN EMITFORMAT(TRUE,RSTROKE,0,1,0,0,0,0,0);NEXTENT END;IF ELCLASS!")"A00009500
ND ELCLASS!">"THEN GO TO EL;IF REPEAT=0THEN EMITFORMAT(TRUE,RSTROKE,1,0,00009600
0,0,0,0,0);S~TRUE;REPEAT~F-SKIP;CODE~RRIGHT END ELSE IF ELCLASS="O"THEN 00009700
BEGIN CODE~RO;W~8END ELSE IF ELCLASS="D"THEN BEGIN CODE~RD;W~8END ELSE I00009800
F ELCLASS=","THEN GO TO L2 ELSE IF ELCLASS="/"THEN GO TO EXIT ELSE IF EL00009900
CLASS=")"OR ELCLASS=">"THEN GO TO EXIT ELSE IF ELCLASS="S"THEN BEGIN NEX00010000
TENT;W~IF ELCLASS="-"THEN 1ELSE 0;IF ELCLASS>0THEN NEXTENT;IF ELCLASS>0T00010100
HEN BEGIN ERR(136);GO TO EXIT END ELSE REPEAT~-ELCLASS;EMITFORMAT(TRUE,R00010200
SCALE,REPEAT,0,W,0,0,0,0);GO TO L2 END ELSE IF ELCLASS="""THEN BEGIN COD00010300
E~100;ST~0;DO BEGIN SKIP~1;DO BEGIN RSLT~5;CNT~0;SCANNER;IF ELCLASS~ACCU00010400
M[1].[18:6]=CODE THEN BEGIN IF SKIP!1THEN BEGIN WHIPOUT(NFWD,W,NFWD);F~F00010500
+1;END;GO TO L2 END;CODE~""";PACKALPHA(W,ELCLASS,SKIP);END UNTIL SKIP~SK00010600
IP+1=7;WHIPOUT(NFWD,W,NFWD);F~F+1;END UNTIL(ST~ST+6)>132;GO TO EX END EL00010700
SE BEGIN CODE~ELCLASS;GETINT;W~ELCLASS;IF CODE="I"THEN BEGIN SKIP~DIVIDE00010800
(W,W1,W2);CODE~RI END ELSE IF CODE="F"THEN BEGIN CODE~RF;GO TO L1 END EL00010900
SE IF CODE="R"THEN BEGIN CODE~RR;GO TO L1 END ELSE IF CODE="E"THEN BEGIN00011000
 CODE~RE;D1~1;L1:NEXTENT;IF ELCLASS!"."THEN GO TO EX;GETINT;IF DIVIDE(EL00011100
CLASS+D1,D1,D2)>0THEN GO TO EX;IF CODE=RF OR CODE=RR THEN SKIP~DIVIDE(W-00011200
ELCLASS-1,W1,W2)ELSE IF SKIP~W-ELCLASS-6<0THEN GO TO EX END ELSE IF CODE00011300
="X"THEN BEGIN CODE~RX;W1~W.[38:4];SKIP~W~W.[42:6]END ELSE IF CODE="A"TH00011400
EN BEGIN CODE~RA;W1~6;GO TO L3 END ELSE IF CODE="L"THEN BEGIN CODE~RL;W100011500
~5;L3:IF W<W1 THEN W1~W;SKIP~W-W1 END ELSE GO EX END;EMITFORMAT(S,CODE,R00011600
EPEAT,SKIP,W,W1,W2,D1,D2);L2:NEXTENT;GO TO EXIT;EX:FORMATPHRASE~TRUE;ERR00011700
(136);EXIT:END FORMATPHRASE;ERRTOG~FALSE;READACARD;NFWD~FMTF(GENF);F~0;D00011800
O NEXTENT UNTIL ELCLASS="("OR ELCLASS=";";IF ELCLASS!"("THEN BEGIN FLAG(00011900
32);NCR~TIME(1);DO F~0UNTIL TIME(1)-NCR>200;F~@40*2;END;ERRTOG~FORMATPHR00012000
ASE;IF ELCLASS=";"THEN GO TO FINISHED;FLAG(119);FINISHED:TATTLE(F,PRNT[000012100
]);WRITE(LINE,15,PRNT[*]);MAXWDS(INFORMAT);IF F>FMAX THEN BEGIN LARGER(P00012200
RNT[0],FMAX);WRITE(LINE,15,PRNT[*]);ERRTOG~TRUE;END;NCR~0&(F+1)[24:39:9]00012300
;WHIPOUT(NFWD,NCR,NFWD);CNT~(F+1)DIV 63;TCNT~(F+1)MOD 63;IF ERRTOG THEN 00012400
BEGIN NCR~TIME(1);DO F~0UNTIL TIME(1)-NCR>200;F~@40*2;END;MOVECODE(GENF,00012500
INFORMAT,CNT,TCNT);END OF OBJECTFMTGEN;                                 00012600
               OBJECTFMTGEN (FIN2);                                     00012700
START:         READ(CARD,FIN,COLUMN,ROW)[EOF];                          00012800
               SRS~SRSS~CSC~0.0;                                        00012900
               NOC~0;                                                   00013000
          BEGIN                                                         00013100
ARRAY          S1[1:COLUMN],N1[1:COLUMN],S2[1:ROW],N2[1:ROW];           00013200
LABEL          DOGS,CATS,HELL;                                          00013300
               FOR I~1 STEP 1 UNTIL COLUMN DO                           00013400
          BEGIN                                                         00013500
               S1[I]~0;                                                 00013600
               N1[I]~0;                                                 00013700
          END;                                                          00013800
               FOR J~1 STEP 1 UNTIL ROW DO                              00013900
          BEGIN                                                         00014000
               S2[J]~0;                                                 00014100
               N2[J]~0;                                                 00014200
          END;                                                          00014300
               FOR I~1 STEP 1 UNTIL COLUMN DO                           00014400
               FOR J~1 STEP 1 UNTIL ROW DO                              00014500
          BEGIN                                                         00014600
               READ (CARD,FIN1,N);                                      00014700
          BEGIN                                                         00014800
ARRAY          X[1:N];                                                  00014900
               READ(CARD,FIN2,FOR L~1 STEP 1 UNTIL N DO X[L])[EOF];     00015000
               NOC~NOC+N;                                               00015100
               Y~0.0;                                                   00015200
               NC~N;                                                    00015300
               N2[J]~N2[J]+N;                                           00015400
               N1[I]~N1[I]+N;                                           00015500
               FOR L~1 STEP 1 UNTIL N DO                                00015600
          BEGIN                                                         00015700
               SRS~SRS+X[L];                                            00015800
               S1[I]~S1[I]+X[L];                                        00015900
               S2[J]~S2[J]+X[L];                                        00016000
               SRSS~SRSS+X[L]|X[L];                                     00016100
               Y~Y+X[L];                                                00016200
          END;                                                          00016300
          END;                                                          00016400
               CSC~CSC+Y|Y/NC;                                          00016500
          END;                                                          00016600
               SSCO~0.0;                                                00016700
               FOR I~1 STEP 1 UNTIL COLUMN DO                           00016800
          BEGIN                                                         00016900
               NC~N1[I];                                                00017000
               SSCO~SSCO+S1[I]|S1[I]/NC;                                00017100
          END;                                                          00017200
               SSCO~SSCO-SRS|SRS/NOC;                                   00017300
               SSRO~0.0;                                                00017400
               FOR J~1 STEP 1 UNTIL ROW DO                              00017500
          BEGIN                                                         00017600
               NC~N2[J];                                                00017700
               SSRO~SSRO+S2[J]|S2[J]/NC;                                00017800
          END;                                                          00017900
               SSRO~SSRO-SRS|SRS/NOC;                                   00018000
               SSER~SRSS-CSC;                                           00018100
               SSTO~SRSS-SRS|SRS/NOC;                                   00018200
               SSIN~SSTO-SSRO-SSCO-SSER;                                00018300
               DFC~COLUMN-1;                                            00018400
               DFR~ROW-1;                                               00018500
               DFE~NOC-COLUMN|ROW;                                      00018600
               DFT~NOC-1;                                               00018700
               DFI~DFT-DFC-DFR-DFE;                                     00018800
               MSR~SSRO/DFR;                                            00018900
               MSC~SSCO/DFC;                                            00019000
               MSI~SSIN/DFI;                                            00019100
               MSE~SSER/DFE;                                            00019200
               IF MSE=0 THEN GO TO DOGS ELSE GO TO CATS;                00019300
CATS:          FCOL~MSC/MSE;                                            00019400
               FROW~MSR/MSE;                                            00019500
               FINT~MSI/MSE;                                            00019600
               GO TO HELL;                                              00019700
DOGS:          FCOL~0.0;                                                00019800
               FROW~0.0;                                                00019900
               FINT~0.0;                                                00020000
HELL:          WRITE(LINE,TITLE);                                       00020100
               WRITE(LINE,FT1,SSCO,DFC,MSC,FCOL);                       00020200
               WRITE(LINE,FT2,SSRO,DFR,MSR,FROW);                       00020300
               WRITE(LINE,FT3,SSIN,DFI,MSI,FINT);                       00020400
               WRITE(LINE,FT4,SSER,DFE,MSE);                            00020500
               WRITE(LINE,FT5,SSTO,DFT);                                00020600
          END;                                                          00020700
               GO TO START;                                             00020800
EOF :     END  OF PROGRAM.                                              00020900
                LAST CARD ON CRDIMG TAPE                                99999999
