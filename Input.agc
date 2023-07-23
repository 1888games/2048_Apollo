KEYRUPT1                          # Triggered automatically when a key is pressed

                CA      NOKEY     # Load code for 'NO KEY PRESSED'
                TS      KEYBUF    # Clear key buffer so we don't persist presses from when they are not wanted

                CA      ACTIVE    # Load whether game is active
                EXTEND
                BZF     CAN_READ  # If not active, we can accept key press to start the game

                CA      GM_STATE  # Load game state into A
                EXTEND
                BZF     CAN_READ  # If not 'check_key', we don't care about key presses

                TCF     EXITRUPT  # Exit, we're not listening for key presses while processing happens

CAN_READ

                EXTEND
                READ    CH15      # Read I/O channel that contains the keycode
                MASK    LOW5      # Retain only lower 5 bits
                TS      KEYBUF    # Store into keyboard buffer variable for main loop to pick up

EXITRUPT
                CA      ZEROES    # Clear the input channel
                EXTEND
                WRITE   CH15

                DXCH      ARUPT   # Restore A, L, and Q, and exit the interrupt
                EXTEND
                QXCH      QRUPT
                RESUME




WAITKEY                                 # Waiting for any key press to start game
                                        # If we didn't wait, the RNG would always start in same state

                CA      NOKEY           # Load key code for 'no key pressed'
                EXTEND
                SU      KEYBUF          # Subtract the key code read
                EXTEND
                BZF     WAITMORE        # If zero, nothing pressed, continue waiting

                CA      NOKEY           # Clear keyboard buffer so not carried into game
                TS      KEYBUF

                CA      STA_ADD         # Set game state to add the two starting numbers and exit
                TS      GM_STATE

WAITMORE
                TCF     MAINLOOP



CHECK_KEY                                       # Check whether key press in buffer from interrupt

                CA              NOKEY           # Load key code for nothing pressed into A
                XCH             KEYBUF          # Swap A and buffer. A is now key code and buffer is clear.
                INDEX		A               # Index using the keycode
                TCF		KEYTABL         # Into a jump table with jumps for each possible key

                # We ignore all presses except for 2, 4, 6, 8 for game control and ENTER/RESTART to reset game.
KEYTABL
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# 1
                TCF		MOVE_DOWN	# 2
                TCF		ENDKYCK		# 3
                TCF		MOVE_LEFT	# 4
                TCF		ENDKYCK		# 5
                TCF		MOVE_RT		# 6
                TCF		ENDKYCK		# 7
                TCF		MOVE_UP		# 8
                TCF		ENDKYCK		# 9
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# 0
                TCF		ENDKYCK		# VERB
                TCF		INIT		# RSET
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# KEY REL
                TCF		ENDKYCK		# +
                TCF		ENDKYCK		# -
                TCF		INIT		# ENTR
                TCF		ENDKYCK		# unused
                TCF		ENDKYCK		# CLR
                TCF		ENDKYCK		# NOUN
                TCF		ENDKYCK		# NOKEY

ENDKYCK
                TCF  MAINLOOP   # When we do nothing, just exit back to main loop to wait for a valid key

