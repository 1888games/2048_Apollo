
		SETLOC	4000


RESTART
		INHINT			# Turn off interrupts
		CA	O37774		# Schedule the first TIME3 interrupt
                TS	TIME3
		TCF	INIT		# Proceed with initialization

$Vectors.agc                            # Add table of interrupt vectors

		# Initialization.
INIT
		CA	ZERO	       # Load 0 to A
                TS      ACTIVE         # Set game not started
                TS      GM_DONE        # Set game not completed

                EXTEND
                WRITE   CH11           # Clear any DSKY lights


                CA      NOKEY          # Clear the keypad buffer variable
                TS      KEYBUF         # to initially hold an illegal keycode.

                TC      RESETALL       # Set all grid items to empty (-1)
                TC      DISP15         # Clear the grid

                CA      STA_WAIT       # Set game status to wait for any key
                TS      GM_STATE

                RELINT                 # Enable interrupts

MAINLOOP
                CS      NEWJOB         # Each loop, nudge hardware watchdog


CHK_STATE

                INDEX	GM_STATE        # Index into game state jump table
                TCF	ST_TABLE        # Will jump to appropriate function below based on state
ST_TABLE
                TCF	CHECK_KEY	# 0
                TCF	MOVING_DN	# 1
                TCF	MOVING_UP       # 2
                TCF	MOVING_LT       # 3
                TCF	MOVING_RT       # 4
                TCF     NEWNUM          # 5
                TCF     WAITKEY         # 6


# Include the rest of the code modules below

$Grid.agc
$Down.agc
$Up.agc
$Left.agc
$Right.agc
$Display.agc
$Interrupts.agc
$Input.agc
$Random.agc

$Constants.agc
$Tables.agc
$Ram.agc

