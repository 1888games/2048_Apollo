KEYRUPT1

                TC      RANDOM
                INDEX   CUR_ID
                TS      VALUES

                INCR    CUR_ID
                TC      RANDOM
                INDEX   CUR_ID
                TS      VALUES

                EXTEND
                DIM     CUR_ID

                TC      DISPNUM
                CA      CUR_ID
                EXTEND
                SU      NUM_SEGS
                EXTEND
                BZF     WRAPID

                INCR    CUR_ID

                TCF     EXITRUPT

WRAPID
                CA      ZEROES
                TS      CUR_ID
                TCF     EXITRUPT

                EXTEND
                READ    CH15
                MASK	LOW5
                TS      TEMPK
                INDEX   TEMPK
                TCF     JMPTABLE

                #CA      CLEARBTN
               # TS      TEMPI
               # CA      TEMPK
               # EXTEND
               # SU      TEMPI
               # EXTEND
              #  BZF     DISPLAY2
EXITRUPT
                RESUME

JMPTABLE
                TCF     EXITRUPT         # NOTHING
                TCF     EXITRUPT         # 1
                TCF     EXITRUPT         # 2
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT
                TCF     EXITRUPT

