
RANDOM

        # I tried various methods for generating 'random' numbers. Most traditional methods are designed
        # for 8-bit or 16-bit hardware, and the various xor 'magic numbers' are particular to that paradigm.
        # I'm not patient enough to find values that might work. Using a fast-moving index into a lookup
        # table should be 'good enough' for a game.


        CA      TIME1       # Load a register that is updated very often by the hardware
        AD      COUNTER     # Add previous value of counter in case we were so quick TIME1 didn't change
        MASK    MASK128     # Mask value so now between 0-127.
        TS      COUNTER     # Store this as new counter
        INDEX   COUNTER     # Index using value between 0-127
        CA      RAND1       # Into a table of random numbers between 0 and 9 (generated in Excel)
        INCR    COUNTER     # Move counter on one so next index unlikely to be the same


        RETURN


