
DISPNUM         # CUR_ID is the index of next segment to display (0=left prog, 20 = digit 5 bottom row)
                # Print value held in VALUES array to correct segment

                # Data is sent to the DSKY via Channel 10 two digits at a time.
                # Bits 10-14 select which pair of digits we want to draw
                # Bits 0-4 selects which digit to draw on the right segment
                # Bits 5-9 selects which digit to draw on the left segment

                CA      ZEROES     # Load 0 into accumulator from a fixed rom constant
                TS      DIGIT_L    # Reset left digit calculation to 0 (empty)
                TS      DIGIT_R    # Reset right digit calculation to 0 (empty)

                INDEX   CUR_ID  # Index next instruction by segment id
                CA      SEG_0   # Get which pair of digits this segment belongs to
                TS      SEG_OUT # Save ID to RAM

                INDEX   SEG_OUT  # Index next instruction by segment pair id
                CA      SEGCODE  # Get value required in bits 10-14 to select pair, using id
                TS      DSKY_OUT  # Save to RAM to use later when we have the digit data

                INDEX   CUR_ID  # Index next instruction by segment id
                CA      VALUES  # Get the value in RAM we want to display here
                TS      TEMPI   # Save to temporary RAM variable

                INDEX   CUR_ID   # Index next instruction by segment id
                CA      LEFTRIGHT  # Get whether this segment is left or right of its pair
                EXTEND          # Extend to use a new Block 2 AGC instruction
                BZF     SKIPLEFT  # If zero (is right), skip the left digit

CALCLEFT
                INDEX   TEMPI   # Index next instruction by our digit (0-9)
                CA      DSP0     # Get the 5-bit code for this digit to send to DSKY
                TS      CYL     # Transfer it to the shift left register
                CA	CYL     # Shift left no 1
		CA	CYL     # Shift left no 2
		CA	CYL     # Shift left no 3
		CA	CYL     # Shift left no 4
		CA	CYL     # Shift left no 5 (is now in bits 5-9 for the left digit)
		TS      DIGIT_L # Save to RAM to use later

                INCR    CUR_ID  # Move onto the right segment of the pair
                INDEX   CUR_ID  # Index by new segment id
                CA      VALUES  # Get value to display on right digit
                TS      DIGIT_R # Save to RAM to use later

                TCF     DIDLEFT # Skip the code to set only the right digit if left not drawn

SKIPLEFT
                CA      TEMPI   # Load the value for this digit to draw on the right of pair
                TS      DIGIT_R # Store to RAM

DIDLEFT

                INDEX   DIGIT_R # Index by value of right digit
                CA      DSP0    # Get the 5-bit code for this digit to send to DSKY

OUTPUT
                AD      DSKY_OUT  # Add bits 10-14
                AD      DIGIT_L   # Add bits 5-9
                EXTEND            # Extend in order to use I/O channel instruction
                WRITE   CH10      # Send the value to channel 10 to display on DKSY

                RETURN            # Return from subroutine
