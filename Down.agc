

MOVE_DOWN                       # The down key (8) has been pressed

        CA      ZERO            # Load 0 into A
        TS      MATCHMD         # Clear array of 5 that indicates whether two numbers
        TS      MATCH1          # have already been combined for the given row/col
        TS      MATCH2
        TS      MATCH3          # Otherwise moving left on a row of 0-0-1 would end as 2-x-x.
        TS      MATCH4          # When it should be 1-1-x.

MOVING_DN                       # Once in a state of 'sta_down', come here each 'frame'
                                # until no more cells can move down

        CA      STA_DOWN        # Load the game status of 'moving down'
        TS      GM_STATE        # Save as game state

        CA      ZERO            # Load 0 into A
        TS      PLAY_ID         # Reset number of cells moved this iteration.

        CA      DEC1            # Start from middle row, checking below to see if we can move into it.
        TS      ROW_ID          # Store 1 into ROW_ID

D_ROLOOP                        # Loop through rows, checking each column to see if number can move down

        INDEX   ROW_ID          # Index by the row_id
        CA      ROW_STRT        # Get the first cell id in this row
        TS      CUR_ID          # Store this as current id
        AD      DEC5            # Add 5
        TS      END_ID          # Store cur_id + 5 to know when to stop processing row

D_COLOOP                        # Loop through each cell on a row


        INDEX   CUR_ID          # Index by the current cell id
        CA      GRID_COL        # Get the column this cell belongs to
        TS      CELLCOL         # And save value to ram for later

        INDEX   CUR_ID          # Index by the current cell id again
        CA      VALUES          # Get the value in this cell
        TS      CELL_VALUE      # Save cell value
        AD      DEC1            # Add 1. If empty (-1), this is now 0.
        EXTEND
        BZF     D_NOCOL         # If empty, don't bother checking cell below


CHK_BEL                         # This cell has a number, check below

        CA      CUR_ID          # Load the current cell id
        AD      DEC5            # Add 5 (number of columns) to get cell below
        TS      CHK_ID          # Store cell check id

        INDEX   CHK_ID          # Index using the cell below's id
        CA      VALUES          # Get the value in the cell below
        TS      CHK_VALUE       # Store the cell below's value
        AD      DEC1            # Add 1. If empty (-1), this is now 0.
        EXTEND
        BZF     MOV_DN          # If cell below empty, we can move straight into it.

D_SOMEHR                        # There's a number below. Check what it is.

        INDEX   CELLCOL         # Index by the column our cell is in
        CA      MATCHMD         # Get whether we already combined cells in this column
        EXTEND
        BZF     D_NOSOF         # If 0, we didn't already combine so we can check for match

        TCF     D_NOCOL         # We already combined so we don't want to try and combine again

D_NOSOF

        CA      CELL_VALUE      # Load the value in original cell
        EXTEND
        SU      CHK_VALUE       # Subtract the value in cell below
        EXTEND
        BZF     D_MATCH         # If zero, they are the same. Combine them.

        TCF     D_NOCOL         # Not the same, can't move as way is blocked

D_MATCH

        INCR    PLAY_ID         # Increase counter as something is going to move

        INDEX   CELLCOL         # Index by the column these cells are in
        INCR    MATCHMD         # Set flag that we have combined in this column

        CA      CELL_VALUE      # Load value in original cell
        AD      DEC1            # Add 1 because we are combining
        INDEX   CHK_ID          # Index using cell below id
        TS      VALUES          # Set cell below to be +1

        CA      NEG_ONE         # Load -1 to A (empty)
        INDEX   CUR_ID          # Index by original cell id
        TS      VALUES          # Set original cell to now be empty

        TCF     D_NOCOL         # Move along to next column
MOV_DN

        INCR    PLAY_ID         # We are moving a number into empty space. Inc move counter.

        CA      CELL_VALUE      # Load the value in cell that's moving
        INDEX   CHK_ID          # Index by cell below id
        TS      VALUES          # Set cell below to value of original cell

        CA      NEG_ONE         # Load -1 to A (empty)
        INDEX   CUR_ID          # Index by original cell id
        TS      VALUES          # Set original cell to now be empty

D_NOCOL                         # End of processing for this column

        INCR    CUR_ID          # Move cell id to next column
        CA      CUR_ID          # Load id into A
        EXTEND
        SU      END_ID          # Subtract id of first cell in row below
        EXTEND
        BZF     D_NXTRW         # If zero, we have no more columns, goto next row

        TCF     D_COLOOP        # More columns to process, loop back up

D_NXTRW

        TS      NEWJOB          # Nudge watchdog as this processing might take a while
        CA      ROW_ID          # Load the row id
        EXTEND

        BZF     D_DONE          # If row id is zero, we've done all rows now

        EXTEND
        DIM     ROW_ID          # Not last row, move up into next row

        TCF     D_ROLOOP        # Process the next row

D_DONE

        CA      PLAY_ID         # Did we move anything in this iteration?
        EXTEND
        BZF     D_NOWT          # If 0 we did not so return control to player

D_UPDATE

        TC      DISP15          # We moved something, update display
        TC      IODELAY         # Delay a bit so numbers don't move instantly from one end to other
        TCF     MAINLOOP        # Return to main loop to see if anything still to move

D_NOWT
        CA      STA_ADD         # All movement handled, now add new number to grid
        TS      GM_STATE        # Save to game state, we'll do in next main loop

        TC      IODELAY         # A little delay before adding so it's obvious where it went

        TCF     MAINLOOP        # Return to main loop which will add a new number next time
