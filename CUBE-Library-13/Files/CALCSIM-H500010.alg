          BEGIN                                                         00000100
COMMENT        CUBE LIBRARY NUMBER IS H500010.  THE PROGRAM NAME IS     00000200
               "CALCSIM/REMOTE".  THIS VERSION DATED 5/3/68;            00000300
COMMENT        THIS PROGRAM SIMULATES AN EXTENDED DESK CALCULATOR IN-   00000400
               CLUDING PRE-PROGRAMMED MATHEMATICAL ROUTINES AS WELL AS  00000500
               10 STORAGE REGISTERS.                                    00000600
               THE STRATEGY USED RELIES 0N A 1-DIMENSION ARRAY OF ALPHA 00000700
               OPERATORS, THE SUBSCRIPT 0F WHICH KEYS ROUTING THROUGH A 00000800
               SWITCH TO THE APPROPRIATE SECTION OF THE PROGRAM.        00000900
                                                                        00001000
          ADD FUNCTION REQUIREMENTS:                                    00001100
               (1) ADD SUITABLE LABEL DECLARATION.                      00001200
               (2) ADD LABEL TO END OF SWITCH DECLARATION.              00001300
               (3) ADD NEW OPERATOR NAME TO END OF <FILL OP[*]> STATE-  00001400
                   MENT, 4 CHARACTERS, LEFT JUSTIFIED.                  00001500
               (4) PROGRAM THE REQUIRED ROUTINE WITH LABEL ON FIRST     00001600
                   STATEMENT AND BRANCH TO EITHER PRINT OR READER, AS   00001700
                   APPROPRIATE.                                         00001800
               (5) ADD 1 TO OUTER NEST REPTITIVE INDICATOR IN STREAM    00001900
                   PROCEDURE ROUTE.                                     00002000
               (6) RECOMPILE AFTER ROUTINE IS PLACED IN DECK AND TEST.  00002100
               NOTE: IF ADDING SEVERAL ROUTINES, BE SURE TO MAINTAIN    00002200
                     SEQUENCE C0RRESP0NDENCE BETWEEN SWITCH DECLARATI0N 00002300
                     AND <FILL OP[*]> STATEMENT.                        00002400
               ALPHA ARRAY OP CAN HANDLE ONLY 50 OPERATOR IDENTIFICA-   00002500
                     TIONS.  GROWTH MAY REQUIRE ENLARGEMENT OF ARRAY.   00002600
          ADD CONSTANT REQUIREMENTS:                                    00002700
               (1) ADD CONSTANT NAME (6 CHARACTERS, LEFT JUSTIFIED)     00002800
                   TO <FILL CNSTNAN[*]> STATEMENT.                      00002900
               (2) ADD CONSTANT VALUE (UP TO 12 SIGNIFICANT FIGURES) T0 00003000
                   <FILL CONST[*]> STATEMENT.                           00003100
               (3) ADD 1 TO NEST REPETITIVE INDICATOR IN STREAM PRO-    00003200
                   CEDURE C.                                            00003300
               NOTE: IF ADDING SEVERAL CONSTANTS, BE SURE TO MAINTAIN   00003400
                     SEQUENCE CORRESPONDENCE IN CONSTANT-NAME AND CON-  00003500
                     STANT-VALUE ARRAYS.                                00003600
               THESE ARRAYS PRESENTLY ARE SET UP TO HANDLE MAXIMUM OF 5100003700
                     CONSTANTS. GROWTH MAY REQUIRE ENLARGEMENT OF ARRAY 00003800
                     DIMENSIONS;                                        00003900
                                                                        00004000
                                                                        00004100
ALPHA FILE IN CALCSIM2IN 14(1,4);ALPHA FILE OUT CALCSIM2OUT 14(2,8);MONI00004200
TOR EXPOVR,INTOVR,ZERO,INDEX;INTEGER STA,I,J,INX,K,DEC;INTEGER STREAM PR00004300
OCEDURE FINDGP(B);BEGIN LABEL HERE;SI~B;22(IF SC="~"THEN JUMP OUT 1TO HE00004400
RE;SI~SI+1;TALLY~TALLY+1);HERE:FINDGP~TALLY;END;STREAM PROCEDURE MOVE(F,00004500
T,N);VALUE N;BEGIN DI~T;DS~24LIT" ";SI~F;DI~T;DS~N CHR;END;DEFINE RT=REA00004600
D(CALCSIM2IN(STA,60),4,TT[*])[LONG]#,WT=WRITE(CALCSIM2OUT(STA)#,MV=MOVE(00004700
TT[1],INP[0],FINDGP(TT[1]))#;ALPHA ARRAY TT[0:4],INP[0:3],CNSTNAM[0:50],00004800
OPERAND[0:2];SAVE ALPHA ARRAY OP[0:50];REAL VALU,DISPLAY;REAL ARRAY STOR00004900
[0:9],CONST[0:50];INTEGER ARRAY T[0:4];ALPHA OPR,MONTH;BOOLEAN BOOL;STRE00005000
AM PROCEDURE CONVERT(ALFA,INT);BEGIN SI~ALFA;DI~INT;SI~SI+3;DS~5OCT;END 00005100
OF CONVERT STREAM PROCEDURE;INTEGER PROCEDURE LEAPYEAR(YEAR);VALUE YEAR;00005200
INTEGER YEAR;BEGIN IF YEAR MOD 4!0OR YEAR=0THEN LEAPYEAR~0ELSE LEAPYEAR~00005300
1;END OF LEAPYEAR PROCEDURE;PROCEDURE DATER(MONTH,DAY,YEAR);INTEGER DAY,00005400
YEAR;ALPHA MONTH;BEGIN INTEGER ARRAY DAYS[0:11];LABEL DONE;ALPHA ALFA;AL00005500
PHA ARRAY MONTHS[0:11];INTEGER I;FILL DAYS[*]WITH 31,28,31,30,31,30,31,300005600
1,30,31,30,31;ALFA~TIME(0);FILL MONTHS[*]WITH"JAN.","FEB.","MAR.","APR."00005700
," MAY","JUNE","JULY","AUG.","SEP.","OCT.","NOV.","DEC.";CONVERT(ALFA,DA00005800
Y);YEAR~DAY DIV 1000;DAYS[2]~DAYS[2]+LEAPYEAR(YEAR);DAY~DAY MOD 1000;FOR00005900
 I~0STEP 1UNTIL 11DO BEGIN DAY~DAY-DAYS[I];IF DAY{0THEN GO TO DONE;END;D00006000
ONE:DAY~DAY+DAYS[I];MONTH~MONTHS[I];END OF DATER PROCEDURE;PROCEDURE TIM00006100
ER;BEGIN FORMAT OUT F1(X8,"{!DATE OF RUN ",A4,I3," 19",I2,"{!~"),F2(X8,"00006200
PROCESSOR TIME FROM PROGRAM START (SEC.) = ~"),F3(X8,F8.2,"{!~"),F4(X8,"00006300
I/O TIME FROM PROGRAM START (SEC.) =       ~"),F5(X8,F8.2,"{!~");LABEL D00006400
IDIT,DONE;IF K!0THEN GO TO DIDIT;K~1;DATER(MONTH,T[4],T[0]);T[1]~TIME(1)00006500
;DIDIT:T[2]~TIME(2);T[3]~TIME(3);WT,F1,MONTH,T[4],T[0]);WT,F2);WT,F3,T[200006600
]/60);WT,F4);WT,F5,T[3]/60);DONE:END OF TIMER PROCEDURE;BOOLEAN STREAM P00006700
ROCEDURE ALFATEST(ALFA);BEGIN LABEL FINIS,OK,NOPE;SI~ALFA;SI~SI+2;IF SC<00006800
"0"THEN GO TO OK;NOPE:TALLY~0;GO TO FINIS;OK:IF SC="-"THEN GO TO NOPE;IF00006900
 SC="+"THEN GO TO NOPE;TALLY~1;FINIS:ALFATEST~TALLY;END OF ALFATEST STRE00007000
AM PROCEDURE;INTEGER STREAM PROCEDURE DIGIT(ALFA);BEGIN LABEL INVREG,FOU00007100
ND,COMPLETE,OK;SI~ALFA;SI~SI+5;18(IF SC=" "THEN JUMP OUT 1TO FOUND;SI~SI00007200
+1;);INVREG:TALLY~10;DIGIT~TALLY;GO TO COMPLETE;FOUND:SI~SI+1;IF SC=ALPH00007300
A THEN GO TO OK;GO TO INVREG;OK:IF SC<"0"THEN GO TO INVREG;DI~LOC DIGIT;00007400
DS~1OCT;COMPLETE:END OF DIGIT STREAM PROCEDURE;REAL PROCEDURE FACTORIAL(00007500
N);VALUE N;REAL N;BEGIN IF N>1.0THEN FACTORIAL~N|FACTORIAL(N-1)ELSE IF N00007600
}0.0THEN FACTORIAL~1.0ELSE FACTORIAL~0.0;END OF FACTORIAL PROCEDURE;DEFI00007700
NE SHIFT=VALU~DISPLAY#;BOOLEAN STREAM PROCEDURE NOPT(INP);BEGIN LABEL OK00007800
,EXIT;SI~INP;17(IF SC="."THEN JUMP OUT 1TO OK;SI~SI+1;);TALLY~1;GO TO EX00007900
IT;OK:TALLY~0;EXIT:NOPT~TALLY;END OF BOOLEAN STREAM PROCEDURENOPT;STREAM00008000
 PROCEDURE PACK(OP);BEGIN SI~OP;SI~SI+8;DI~OP;50(SI~SI+4;DS~4CHR;);END;F00008100
ORMAT IN FIN1(A4,X1,3A6),FIN2(X5,R17.2);FORMAT OUT FTT1(X8,"{!OPR.      00008200
OPERAND        OPERAND VALUE    ~"/X8,"    DISPLAY{!~"/X8,"**** ********00008300
********* ***************** *~"/X8,"****************{!!~"),FTT5(X8,"{~"/00008400
X8,"                       ~"),FTT6(X8,2(R17.*,X1),"~"),FTT7(X8,"REGISTE00008500
R",I2,"{!~"),FTT8(X8,"INVALID OPERATOR{!~"),FTT9(X8,"DISPLAY OVERFLOW{!~00008600
"),FTT10(X8,"DIVIDE BY ZERO ATTEMPTED{!~"),FTT11(X8,"RADIANS{!~"),FTT12(00008700
X8,"DEGREES{!~"),FTT13(X8,"MINUTES{!~"),FTT14(X8,"SECONDS{!~"),FTT15(X8,00008800
"INVALID CONSTANT NAME OR REGISTER{!~"),FTT16(X8,"!!{!!~"),FTT17(X8,"{!~00008900
"),FTT18(X8,"!IF NO FURTHER ENTRY WITHIN NEXT 60 ~"/X8,"SECONDS, CALCSIM00009000
 WILL TERMINATE{!!~"),FTT20(X8,"CALCSIM TERMINATED, 2 MINUTES INACTIVE{!00009100
!}~"),FTT21(X8,"NO DECIMAL POINT GIVEN{!~"),FTT22(X8,"NEGATIVE OPERAND I00009200
NVALID{!~");                                                            00009300
                                                                        00009400
                                                                        00009500
INTEGER STREAM PROCEDURE C(CNSTNAM, OPERAND);                           00009600
          BEGIN                                                         00009700
LABEL          FOUND;                                                   00009800
               SI ~ CNSTNAM; TALLY ~ 0;                                 00009900
               20(SI ~ SI + 2; DI ~ OPERAND; DI ~ DI + 2;               00010000
COMMENT        REPETITIVE INDICATOR   A B O V E   IS TO BE CHANGED IF   00010100
               ADDING CONSTANT;                                         00010200
                  IF 6 SC = DC THEN JUMP OUT 1 TO FOUND;                00010300
                  TALLY ~ TALLY + 1;);                                  00010400
               TALLY ~ 63;                                              00010500
FOUND:         C ~ TALLY;                                               00010600
          END;                                                          00010700
                                                                        00010800
                                                                        00010900
INTEGER STREAM PROCEDURE ROUTE(OPR, OP);                                00011000
          BEGIN                                                         00011100
LABEL          FOUND;                                                   00011200
LOCAL          TEMP;                                                    00011300
               SI ~ OPR; SI ~ SI + 4; DI ~ LOC TEMP; DS ~ 4 CHR;        00011400
               SI ~ OP; TALLY ~ 0;                                      00011500
               36(DI ~ LOC TEMP; TALLY ~ TALLY + 1;                     00011600
COMMENT        REPETITIVE INDICATOR   A B O V E   IS TO BE CHANGED IF   00011700
               ADDING OPERATOR;                                         00011800
                  IF 4 SC = DC THEN JUMP OUT TO FOUND;);                00011900
               TALLY ~ 63;                                              00012000
FOUND:         ROUTE ~ TALLY;                                           00012100
          END OF STREAM PROCEDURE ROUTE;                                00012200
                                                                        00012300
                                                                        00012400
LABEL          DONE, OVFL, ZERODIV, INVOP, ADD, SUB, MULT, DIVID, SQART,00012500
                 LOG10, NLOG, ALOG, EXPN, SINE, COSIN, TAN, COT, SEC,   00012600
                 CSC, ABSVAL, ATAN, POWER, STORE, NEGNBR, CLEAR, RESET, 00012700
                 INV, FACT,        PRINT, READER, INVCST, DEG, MIN,     00012800
                 SECD, RADIAN, SINH, COSH, AVG, SDEV, SET, LONG, FAHR,  00012900
                 CENT, DECI;                                            00013000
SWITCH         SELECT~STORE, RADIAN,ATAN,DEG,FAHR,CENT,MIN,SECD,ADD,SUB,00013100
                 MULT, DIVID, SET, SQART, LOG10, NLOG, ALOG,            00013200
                 EXPN, SINE, COSIN, TAN, COT, SEC, CSC, ABSVAL, POWER,  00013300
                 CLEAR, RESET, INV, FACT, SINH, COSH, AVG, SDEV, DONE,  00013400
                 DECI;                                                  00013500
                                                                        00013600
                                                                        00013700
               FILL OP[*] WITH "    ", "SAVE", "RAD ", "ATAN", "DEG ",  00013800
                 "FAHR", "CENT",                                        00013900
                 "MIN ", "SECD", "ADD ", "SUB ", "MULT", "DIV ",        00014000
                 "SET ", "SQRT", "LOG ", "LN  ", "ALOG", "EXP ", "SIN ",00014100
                 "COS ", "TAN ", "COT ", "SEC ", "CSC ", "ABS ", "PWR ",00014200
                 "CLR ", "END ", "INV ", "FACT", "SINH", "COSH", "AVG ",00014300
                 "SDEV", "STOP", "DEC ";                                00014400
               FILL CNSTNAM[*] WITH "PI    ", "RADIAN", "DEGREE",       00014500
                 "MINUTE", "SECOND", "HALFPI", "TWOPI ", "GAMMA ",      00014600
                 "BOLTZ ", "PLANCK", "CHARGE", "C     ", "AVOGAD",      00014700
                 "ELMASS", "PRMASS", "NEMASS", "FARADA", "R     ",      00014800
                 "V(0)  ", "G(0)  ";                                    00014900
               FILL CONST[*] WITH 3.14159265359, 57.295779513,          00015000
                 0.0174532925199, 0.000290888208666,                    00015100
                 0.00000484813681109, 1.57079632679, 6.2831853072,      00015200
                 0.577215664902,                                        00015300
                 1.38054@-23, 6.6256@-34, 1.60210@-19, 2.997925@+08,    00015400
                 6.02252@+23, 9.1091@-31, 1.67252@-27, 1.67482@-27,     00015500
                 9.64870@+04, 8.3143, 2.24136@-02, 9.80665;             00015600
                                                                        00015700
                                                                        00015800
DEC~10;PACK(OP[0]);                                                     00015900
               STA~STATUS(TT[*]);                                       00016000
               STA.[9:9]~TT[0].[9:9];                                   00016100
                                                                    EXPO00016200
VR~OVFL;INDEX~INVCST;INTOVR~OVFL;ZERO~ZERODIV;TIMER;WT,FTT1);READER:RT;W00016300
T,FTT5);MV;READ(INP[*],FIN1,OPR,OPERAND[0],OPERAND[1],OPERAND[2]);INX~RO00016400
UTE(OPR,OP[0]);IF INX=63THEN GO TO INVOP;IF OPERAND[0]="      "THEN GO T00016500
O SELECT[INX];IF ALFATEST(OPERAND[0])THEN BEGIN J~DIGIT(INP[0]);IF J<10T00016600
HEN BEGIN VALU~STOR[J];GO TO SELECT[INX];END;VALU~CONST[C(CNSTNAM[0],OPE00016700
RAND[0])];GO TO SELECT[INX];END;IF NOPT(INP[0])THEN BEGIN WT,FTT21);GO T00016800
O READER;END;READ(INP[*],FIN2,VALU);GO TO SELECT[INX];PRINT:IF 1.0-DISPL00016900
AY MOD 1.0<50.0@-10THEN DISPLAY~ENTIER(DISPLAY+10.0@-09);WT,FTT6,DEC,VAL00017000
U,DEC,DISPLAY);IF INX>8THEN BEGIN WT,FTT17);GO TO READER;END;IF INX=1THE00017100
N BEGIN WT,FTT7,J);GO TO READER;END;IF INX{3THEN BEGIN WT,FTT11);GO TO R00017200
EADER;END;IF INX{6THEN BEGIN WT,FTT12);GO TO READER;END;IF BOOL THEN BEG00017300
IN WT,FTT13);BOOL~FALSE;END ELSE WT,FTT14);GO TO READER;DECI:WT,FTT17);D00017400
EC~VALU;GO TO READER;OVFL:WT,FTT9);DISPLAY~0.0;GO TO READER;ZERODIV:WT,F00017500
TT10);GO TO READER;INVOP:WT,FTT8);GO TO READER;INVCST:WT,FTT15);GO TO RE00017600
ADER;ADD:DISPLAY~DISPLAY+VALU;GO TO PRINT;SUB:DISPLAY~DISPLAY-VALU;GO TO00017700
 PRINT;MULT:DISPLAY~DISPLAY|VALU;GO TO PRINT;DIVID:DISPLAY~DISPLAY/VALU;00017800
GO TO PRINT;SQART:IF DISPLAY<0.0THEN GO TO NEGNBR;SHIFT;DISPLAY~SQRT(VAL00017900
U);GO TO PRINT;NLOG:IF DISPLAY<0.0THEN GO TO NEGNBR;SHIFT;DISPLAY~LN(VAL00018000
U);GO TO PRINT;EXPN:SHIFT;DISPLAY~EXP(VALU);GO TO PRINT;RADIAN:SHIFT;DIS00018100
PLAY~VALU/CONST[1];GO TO PRINT;SINE:SHIFT;DISPLAY~SIN(VALU);GO TO PRINT;00018200
COSIN:SHIFT;DISPLAY~COS(VALU);GO TO PRINT;TAN:SHIFT;DISPLAY~SIN(VALU)/CO00018300
S(VALU);GO TO PRINT;COT:SHIFT;DISPLAY~COS(VALU)/SIN(VALU);GO TO PRINT;SE00018400
C:SHIFT;DISPLAY~1.0/COS(VALU);GO TO PRINT;CSC:SHIFT;DISPLAY~1.0/SIN(VALU00018500
);GO TO PRINT;ABSVAL:SHIFT;DISPLAY~ABS(VALU);GO TO PRINT;ATAN:SHIFT;DISP00018600
LAY~ARCTAN(VALU);GO TO PRINT;DEG:SHIFT;DISPLAY~VALU|CONST[1];BOOL~TRUE;G00018700
O TO PRINT;MIN:SECD:VALU~ABS(DISPLAY)MOD 1.0;DISPLAY~VALU|60.0;GO TO PRI00018800
NT;POWER:DISPLAY~DISPLAY*VALU;GO TO PRINT;CLEAR:DISPLAY~VALU~0.0;WT,FTT100018900
7);GO TO READER;RESET:FOR I~0STEP 1UNTIL 9DO STOR[I]~0.0;DISPLAY~VALU~0.00019000
0;WT,FTT16);GO TO READER;INV:SHIFT;DISPLAY~1.0/DISPLAY;GO TO PRINT;FACT:00019100
SHIFT;DISPLAY~FACTORIAL(VALU);GO TO PRINT;LOG10:IF DISPLAY<0.0THEN GO TO00019200
 NEGNBR;SHIFT;DISPLAY~LN(VALU)/2.30258509299;GO TO PRINT;ALOG:SHIFT;DISP00019300
LAY~EXP(2.30258509299|VALU);GO TO PRINT;STORE:STOR[J]~VALU~DISPLAY;GO TO00019400
 PRINT;CENT:SHIFT;DISPLAY~(VALU-32.0)|0.55555555555;GO TO PRINT;FAHR:SHI00019500
FT;DISPLAY~1.8|VALU+32.0;GO TO PRINT;SINH:SHIFT;DISPLAY~0.5|(EXP(VALU)-100019600
.0/EXP(VALU));GO TO PRINT;COSH:SHIFT;DISPLAY~0.5|(EXP(VALU)+1.0/EXP(VALU00019700
));GO TO PRINT;SET:DISPLAY~VALU;GO TO PRINT;AVG:;SDEV:BEGIN REAL KEY;DEF00019800
INE J=VALU#;REAL ARRAY A[0:VALU];REAL T,X;INTEGER ARRAY UT,LT[0:LN(VALU+00019900
2)/0.70314718056];INTEGER I,K,Q,M,P;LABEL LAB1,LAB2,LAB3,LAB4,OUTPUT,RET00020000
RY;FORMAT IN TTYN(R17.2);FORMAT OUT TTYO1(X8,"{!!VALUE TABULATION (DESCE00020100
NDING SEQUENCE)~"/X8," -",I5," ITEMS{!!~"),TTYO2(X8,"{!~"),TTYO3(X8,4(R100020200
0.5,X1),"{!~"),TTYO4(X8,"ENTER ITEMS AT LEFT MARGIN{!~"),TTYO5(X8,"{!!AV00020300
ERAGE = ",R10.5,"{!~"),TTYO8(X13,"NO DECIMAL POINT GIVEN{!~"),TTYO6(X8,"00020400
STANDARD DEVIATION = ",R10.5,"{!~"),TTYO7(X8,"MEDIAN POSITION: BOTTOM OF00020500
 COLUMN 2, THEN ~"/X8,"STEP UP HALF THE NUMBER OF {!~"/X8,"BLANKS AT BOT00020600
TOM OF COLUMN 4{!~");WT,TTYO4);KEY~VALU;FOR I~1STEP 1UNTIL J DO BEGIN RE00020700
TRY:RT;MV;IF NOPT(INP[0])THEN BEGIN WT,TTYO8);GO TO RETRY;END;WT,TTYO2);00020800
READ(INP[*],TTYN,A[I]);END;I~M~1;LAB1:IF J-I>1THEN BEGIN P~(J+I)DIV 2;T~00020900
A[P];A[P]~A[I];Q~J;FOR K~I+1STEP 1UNTIL Q DO BEGIN IF A[K]>T THEN BEGIN 00021000
FOR Q~Q STEP-1UNTIL K DO BEGIN IF A[Q]<T THEN BEGIN X~A[K];A[K]~A[Q];A[Q00021100
]~X;Q~Q-1;GO TO LAB2;END;END;Q~K-1;GO TO LAB3;END;LAB2:END;LAB3:A[I]~A[Q00021200
];A[Q]~T;IF 2|Q>I+J THEN BEGIN LT[M]~I;UT[M]~Q-1;I~Q+1;END ELSE BEGIN LT00021300
[M]~Q+1;UT[M]~J;J~Q-1;END;M~M+1;GO TO LAB1;END ELSE IF I}J THEN GO TO LA00021400
B4 ELSE BEGIN IF A[I]>A[J]THEN BEGIN X~A[I];A[I]~A[J];A[J]~X;END;LAB4:M~00021500
M-1;IF M>0THEN BEGIN I~LT[M];J~UT[M];GO TO LAB1;END;END;WT,TTYO1,KEY);K~00021600
KEY DIV 4+1;FOR M~0STEP 1UNTIL K-1DO WT,TTYO3,FOR I~KEY-M STEP-K UNTIL 100021700
DO A[I]);T~0.0;FOR I~1STEP 1UNTIL KEY DO T~T+A[I];T~T/KEY;IF OPR="AVG "T00021800
HEN GO TO OUTPUT;X~0.0;FOR I~1STEP 1UNTIL KEY DO BEGIN VALU~A[I]-T;X~X+V00021900
ALU|VALU;END;X~SQRT(X/(KEY-1));OUTPUT:WT,TTYO5,T);IF OPR="SDEV"THEN WT,T00022000
TYO6,X);WT,TTYO7);END;GO TO READER;LONG:IF INX<-0.5THEN GO TO DONE;INX~-00022100
1;WT,FTT18);GO TO READER;NEGNBR:WT,FTT22);GO TO READER;                 00022200
                                                                        00022300
                                                                        00022400
DONE:          TIMER;                                                   00022500
               IF INX < -0.5 THEN WT, FTT20);                           00022600
          END OF CALCULATOR SIMULATION PROGRAM.                         00022700
