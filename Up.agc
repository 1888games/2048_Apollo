 # See Down.agc for detailed explanation of how the code
 # to move and combine numbers works. The only differences between them
 # is to reverse directions and/or swap rows for columns (if horizontal)

MOVE_UP

        TC      SETUPMOV    # Setup a table and check if can proceed - may never return!
        CA      GM_DONE         # Load game complete status into A
        EXTEND
        BZF     MOVING_UP       # Flag is zero, not complete yet

        TCF     MAINLOOP

MOVING_UP

        CA      STA_UP
        TS      GM_STATE

        CA      ZERO
        TS      PLAY_ID

        CA      DEC1
        TS      ROW_ID

U_ROLOOP

        INDEX   ROW_ID
        CA      ROW_STRT
        TS      CUR_ID
        AD      DEC5
        TS      END_ID

U_COLOOP

        INDEX   CUR_ID
        CA      GRID_COL
        TS      CELLCOL

        INDEX   CUR_ID
        CA      VALUES
        TS      CELL_VALUE
        AD      DEC1
        EXTEND
        BZF     U_NOCOL


CHK_ABV

        CA      CUR_ID
        AD      NEG5
        TS      CHK_ID

        INDEX   CHK_ID
        CA      VALUES
        TS      CHK_VALUE
        AD      DEC1
        EXTEND
        BZF     MOV_UP

U_SOMEHR

        INDEX   CELLCOL
        CA      MATCHMD
        EXTEND
        BZF     U_NOSOF

        TCF     U_NOCOL

U_NOSOF

        CA      CELL_VALUE
        EXTEND
        SU      CHK_VALUE
        EXTEND
        BZF     U_MATCH

        TCF     U_NOCOL

U_MATCH

        INDEX   CELLCOL
        INCR    MATCHMD         # Set flag that we have combined in this column

        TC      UPGRADE          # Increase target cell, empty orig cell

        TCF    U_NOCOL
MOV_UP

        INCR    PLAY_ID

        CA      CELL_VALUE
        INDEX   CHK_ID
        TS      VALUES

        CA      NEG_ONE
        INDEX   CUR_ID
        TS      VALUES

U_NOCOL

        INCR    CUR_ID
        CA      CUR_ID
        EXTEND
        SU      END_ID
        EXTEND
        BZF     U_NXTRW

        TCF     U_COLOOP

U_NXTRW

        TS      NEWJOB

        CA      DEC2
        EXTEND
        SU      ROW_ID
        EXTEND
        BZF     D_DONE


        INCR    ROW_ID

        TCF     U_ROLOOP

