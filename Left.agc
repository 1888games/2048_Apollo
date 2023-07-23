 # See Down.agc for detailed explanation of how the code
 # to move and combine numbers works. The only differences between them
 # is to reverse directions and/or swap rows for columns (if horizontal)

MOVE_LEFT

        CA      ZERO
        TS      MATCHMD
        TS      MATCH1
        TS      MATCH2
        TS      MATCH3
        TS      MATCH4

MOVING_LT

        CA      STA_LEFT
        TS      GM_STATE

        CA      ZERO
        TS      PLAY_ID

        CA      DEC1
        TS      COL_ID

L_COLOOP

        INDEX   COL_ID
        CA      COL_STRT
        TS      CUR_ID
        AD      DEC15
        TS      END_ID

L_ROLOOP

        INDEX   CUR_ID
        CA      GRID_ROW
        TS      CELLROW

        INDEX   CUR_ID
        CA      VALUES
        TS      CELL_VALUE
        AD      DEC1
        EXTEND
        BZF     L_NOROW


CHK_LFT

        CA      CUR_ID
        AD      NEG1
        TS      CHK_ID

        INDEX   CHK_ID
        CA      VALUES
        TS      CHK_VALUE
        AD      DEC1
        EXTEND
        BZF     MOV_LEFT

L_SOMEHR

        INDEX   CELLROW
        CA      MATCHMD
        EXTEND
        BZF     L_NOMAT

        TCF     L_NOROW

L_NOMAT

        CA      CELL_VALUE
        EXTEND
        SU      CHK_VALUE
        EXTEND
        BZF     L_MATCH

        TCF     L_NOROW

L_MATCH


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

        TCF     L_NOROW
MOV_LEFT

        INCR    PLAY_ID

        CA      CELL_VALUE
        INDEX   CHK_ID
        TS      VALUES

        CA      NEG_ONE
        INDEX   CUR_ID
        TS      VALUES

L_NOROW

        CA      CUR_ID
        AD      DEC5
        TS      CUR_ID
        EXTEND
        SU      END_ID
        EXTEND
        BZF     L_NXTCOL

        TCF     L_ROLOOP

L_NXTCOL
        TS      NEWJOB

        CA      DEC4
        EXTEND
        SU      COL_ID
        EXTEND
        BZF     D_DONE


        INCR    COL_ID

        TCF     L_COLOOP


