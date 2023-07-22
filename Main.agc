
		SETLOC	4000
# We begin with an interrupt vector table. There are 10 possible interrupts,
# plus the restart vector which comes first. Currently only the TIME3
# interrupt is used in Validation.
		INHINT			# GO
		CA	O37774		# Schedule the first TIME3 interrupt
		TS	TIME3
		TCF	INIT		# Proceed with initialization

$Vectors.agc

		# Initialization.
INIT		RELINT
		CA	ZEROES		# zero out A
		TS	ERRNUM		# and the error-code
                TS      CUR_ID

                CA      TWENTY1
                TS      NUM_SEGS

LOOP
		CS      NEWJOB
		TCF     LOOP


$Display.agc
$Interrupts.agc
$Input.agc
$Random.agc
$Constants.agc
$Ram.agc

