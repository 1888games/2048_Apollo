
 # See Down.agc for detailed explanation of how the code
 # to move and combine numbers works. The only differences between them
 # is to reverse directions and/or swap rows for columns (if horizontal)

MOVE_RT

        CA      ZERO
        TS      MATCHMD
        TS      MATCH1
        TS      MATCH2
        TS      MATCH3
        TS      MATCH4

MOVING_RT

        CA      STA_RIGHT
        TS      GM_STATE

        CA      ZERO
        TS      PLAY_ID

        CA      DEC3
        TS      COL_ID

R_COLOOP

        INDEX   COL_ID
        CA      COL_STRT
        TS      CUR_ID
        AD      DEC15
        TS      END_ID

R_ROLOOP

        INDEX   CUR_ID
        CA      GRID_ROW
        TS      CELLROW

        INDEX   CUR_ID
        CA      VALUES
        TS      CELL_VALUE
        AD      DEC1
        EXTEND
        BZF     R_NOROW


CHK_RT

        CA      CUR_ID
        AD      DEC1
        TS      CHK_ID

        INDEX   CHK_ID
        CA      VALUES
        TS      CHK_VALUE
        AD      DEC1
        EXTEND
        BZF     MOV_RT

R_SOMEHR

        INDEX   CELLROW
        CA      MATCHMD
        EXTEND
        BZF     R_NOMAT

        TCF     R_NOROW

R_NOMAT

        CA      CELL_VALUE
        EXTEND
        SU      CHK_VALUE
        EXTEND
        BZF     R_MATCH

        TCF     R_NOROW

R_MATCH

        INDEX   CELLROW
        INCR    MATCHMD

        INCR    PLAY_ID

        CA      CELL_VALUE
        AD      DEC1
        INDEX   CHK_ID
        TS      VALUES

        CA      NEG_ONE
        INDEX   CUR_ID
        TS      VALUES

        TCF      R_NOROW
MOV_RT

        INCR    PLAY_ID

        CA      CELL_VALUE
        INDEX   CHK_ID
        TS      VALUES

        CA      NEG_ONE
        INDEX   CUR_ID
        TS      VALUES

R_NOROW

        CA      CUR_ID
        AD      DEC5
        TS      CUR_ID
        EXTEND
        SU      END_ID
        EXTEND
        BZF     R_NXTCOL

        TCF     R_ROLOOP

R_NXTCOL
         TS      NEWJOB
        CA      COL_ID
        EXTEND
        BZF     D_DONE

        EXTEND
        DIM    COL_ID

        TCF     R_COLOOP

