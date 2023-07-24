
RESETALL

             CA         TWENTY1         # Set loop counter to 21
             TS         CUR_ID
RESETLOOP

             EXTEND
             DIM        CUR_ID          # Decrement id so we start at 20, end at 0
             CA         NEG_ONE         # Load -1 to A (empty cell)
             INDEX      CUR_ID          # Index by current loop count
             TS         VALUES          # Save -1 to empty this grid cell

             CA         CUR_ID          # Load loop counter
             EXTEND
             BZF        RESETEND        # If zero, we've cleared all of VALUES array

             TCF        RESETLOOP       # Not zero, loop back for next cell


RESETEND
             RETURN                     # Return to Init


SECOND

             INCR       ACTIVE          # Set game to active now two cells will be populated
NEWNUM

             TC         IODELAY         # Delay a bit before generating the number
             TC         GENZERO         # Call function to generate a 0 or 1 in empty cell
             TC         DISP15          # Call function Display the new grid state

             CA         ACTIVE          # Load whether game is active
             EXTEND
             BZF        SECOND          # If not, generate another new number

             TC         IODELAY         # Delay before returning control to player

             CA         STA_INPUT       # Change game state to player control
             TS         GM_STATE

             TCF        MAINLOOP        # Return to start of game loop



GENZERO                                 # Generate a 0 or 1 in an empty grid cell
             EXTEND
             QXCH       RET_ADR2         # Save the return address of the calling function

CHECKEMP                                 # Check whether all grid spaces taken
             CA         TWENTY1          # Load 21 into A for loop counter
             TS         CUR_ID           # Store into loop counter
CHKLOOP

             EXTEND
             DIM        CUR_ID          # Decrement id so we start at 20, end at 0

             INDEX      CUR_ID          # Index by current loop count
             CA         VALUES          # Get this grid cell
             AD         DEC1            # Add 1, if empty (-1) will be 0
             EXTEND
             BZF        NEWBOX          # When found first empty cell, start process to find random one

             CA         DEC6            # Load 6 into accumulator
             EXTEND
             SU         CUR_ID          # Subtract id. If 6, is first ID of game grid.
             EXTEND
             BZF        EXITGEN        # If zero, all cells are occupied, don't bother

             TCF        CHKLOOP


NEWBOX

        CA      MASK15           # Load a mask to keep only the bottom 4 bits
        TS      TEMPI            # Store into temp variable

        TC      RANDOM           # Get a random number (and discard)
        CA      COUNTER          # Load the random number counter (0-127)
        MASK    MASK15           # Mask it down to 0-15
        TS      PLAY_ID          # Store it as the grid cell to try and add to
        EXTEND
        SU      TEMPI            # Subtract 15 from this cell number
        EXTEND
        BZF     ADD5             # If is 0, we have cell 16 and there only 15.

ADD6                             # Is not 0, we can safely add grid offset of 6

        CA      PLAY_ID         # Load the number we know is from 0-14
        AD      DEC6            # Add 6 to get the first display segment in the grid

        TCF     CHKVALID        # Now check whether this grid cell is empty

ADD5
        CA      PLAY_ID         # We know the number is 15
        AD      DEC5            # So only add 5 so we still get a valid cell

CHKVALID

        TS      PLAY_ID       # Store the cell id to check is empty
        INDEX   PLAY_ID       # Index by the cell id
        CA      VALUES        # Get the value held for cell in VALUES array
        AD      DEC1          # Add one, if it was empty (-1) it's now zero'
        EXTEND
        BZF     ISEMPTY       # If empty, we can use this cell for new number

NOTEMPTY

        TS      NEWJOB        # Nudge watchdog in case it takes a while to find cell
        TCF     NEWBOX        # We can't use this cell, try again

ISEMPTY

        TC      RANDOM        # Get a random number from 0-9
        TS      TEMPI         # Save to temp variable
        CA      DEC4          # Load 4 into A
        EXTEND
        SU      TEMPI         # Subtract 0-9 from 5
        EXTEND
        BZMF    MAKEONE       # if zero or negative, make cell = 1

        CA      ZERO          # is >0, make cell = 0
        TCF     STORENEW

MAKEONE
        CA      DEC1          # Load 1 into A

STORENEW

        INDEX   PLAY_ID       # Index by chosen cell ID
        TS      VALUES        # Store 0-1 into values array by index

EXITGEN
        EXTEND
        QXCH      RET_ADR2    # Restore return address of calling func

        RETURN                # Return to NEWNUM
