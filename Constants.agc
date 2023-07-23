# The AGC does not support 'immediate mode', where you can embed a fixed value into the operand.
# So where you might do lda #48 in 6502 to load 48 into A, here 48 must be present somewhere in RAM
# or ROM so that it has an address we can reference in 'CA MYCONSTANT'.
# So these constants are stored in the ROM itself as data to be lookup up when needed.

#-----------------------------------------------------------------------
# Constants and read-only memory.

# Names of CPU registers.
A		EQUALS	0
L		EQUALS	1		# L AND Q ARE BOTH CHANNELS AND REGISTERS.
Q		EQUALS	2
EBANK		EQUALS	3
FBANK		EQUALS	4
Z		EQUALS	5		# ADJACENT TO FBANK AND BBANK FOR DXCH Z
BBANK		EQUALS	6		# (DTCB) AND DXCH FBANK (DTCF).
ZEROES          EQUALS  7               # REGISTER 7 IS A ZERO-SOURCE, USED BY ZL.
ARUPT		EQUALS	10		# INTERRUPT STORAGE.
LRUPT		EQUALS	11
QRUPT		EQUALS	12
SAMPTIME	EQUALS	13		# SAMPLED TIME 1 & 2.
ZRUPT		EQUALS	15		# (13 AND 14 ARE SPARES.)
BANKRUPT	EQUALS	16		# USUALLY HOLDS FBANK OR BBANK.
BRUPT		EQUALS	17		# RESUME ADDRESS AS WELL.
CYR		EQUALS	20
SR		EQUALS	21
CYL		EQUALS	22
EDOP		EQUALS	23


CH10		EQUALS	10
CH11		EQUALS	11
CH12		EQUALS	12
CH15            EQUALS  15
CH32		EQUALS	32
CH13            EQUALS  13
NOKEY           OCT     40

BIT15           DEC     16384
ZERO            EQUALS  ZEROES


LOW5		OCT	37

O37774		OCT	37774
O37777          OCT	37777

TEN		DEC	10
CLEARBTN        DEC     28
RESETBTN        DEC     18
NEG_ONE         DEC     -1

TWENTY          DEC     20
TWENTY1         DEC     21
MASK128         DEC     127
MASK15          DEC     15
TWO56           DEC     256
FOURTEEN        DEC     14

NEG1           DEC     -1
NEG2           DEC     -2
NEG5           DEC     -5
BIT5            DEC     126


