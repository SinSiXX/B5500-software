COMMENT        CUBE LIBRARY NUMBER IS A200005.  THIS PROGRAM MUST       00000100
               BE RENAMED TO "CTRLN2" USING THE SAME PROCESS            00000200
               FOUND IN A200003 BEFORE RUNNING A200001 OR A200004;      00000300
PROCEDURE     CLN (A,B,C,D) ;  VALUE A,B ;  REAL A,B,C,D ;              00000400
    COMMENT 0 { IM( CLN ) < 2 | PI  ;                                   00000500
    BEGIN INTEGER M,N; LABEL K ; M~SIGN(A) ; N~SIGN(B) ;                00000600
    IF A = 0 THEN BEGIN D~1.570796326795|N; GO TO K ;  END ;            00000700
    IF B = 0 AND A<0  THEN BEGIN D~3.141592653590 ;  GO TO K ;  END ;   00000800
    D ~ 1.570796326795|(1-M)|N+ARCTAN(B/A) ;                            00000900
    K: C ~ 0.5|LN(A|A+B|B) ;IF D < 0 THEN D~D+6.2831853071796;          00001000
    END PROCEDURE CLN ;                                                 00001100
