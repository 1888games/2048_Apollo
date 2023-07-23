
# We begin with an interrupt vector table. There are 10 possible interrupts,
# plus the restart vector which comes first.



        RESUME			# T6RUPT
        NOOP
        NOOP
        NOOP

        RESUME			# T5RUPT
        NOOP
        NOOP
        NOOP

        DXCH	ARUPT		# T3RUPT
        EXTEND			# Back up A, L, and Q
        QXCH	QRUPT
        TCF	T3RUPT		# Transfer to the T3RUPT handler

        RESUME			# T4RUPT
        NOOP
        NOOP
        NOOP

        DXCH	ARUPT		# KEYRUPT1, fired whenever a key is pressed
        EXTEND
        QXCH	QRUPT
        TCF	KEYRUPT1

        RESUME			# KEYRUPT2
        NOOP
        NOOP
        NOOP

        RESUME			# UPRUPT
        NOOP
        NOOP
        NOOP

        RESUME			# DOWNRUPT
        NOOP
        NOOP
        NOOP

        RESUME			# RADAR RUPT
        NOOP
        NOOP
        NOOP

        RESUME			# RUPT10
        NOOP
        NOOP
        NOOP

