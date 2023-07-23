
            BLOCK   02
T3RUPT
            CAF     O37774      # Schedule another TIME3 interrupt
            TS      TIME3       # ... and don't do anything else, yet...

            INCR    COUNTER     # Increment counter for random number generation

RESUME      DXCH    ARUPT       # Restore A, L, and Q, and exit the interrupt
            EXTEND
            QXCH    QRUPT
            RESUME
