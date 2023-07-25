# 2048_Apollo

This is a port of the popular mobile game 2048 for the Apollo Guidance Computer.

Playable in the browser here: https://1888games.github.io/agc.html

Instead of making 2048, you need to create a 9 (the equivalent of 1024 in the original game).

Press any key to begin, then use the 2, 4, 6, and 8 keys to 'swipe' all the numbers in that direction. When two numbers of the same value crash into each other, they merge to form the next number. Create a 9 to complete the game! You can press Enter or Restart to start the game again.




The game is written in AGC assembly, just like the Command Module and Lunar Lander software from the Apollo missions, and takes up just over 75% one of the 2K-word fixed memory banks, or around 1500 bytes. (where 2000 octal = 1024 decimal and a 15-bit word is roughly two bytes).

Fortunately, unlike the pioneering programmers of that software, I didn't have to enter my code onto punch cards (one per instruction, two if the comment was long...), have it saved onto tape and then wait two months for it to be hand-woven into core rope memory. The joys of modern technology means it assembles in milliseconds and can then be tested in a Linux-based emulator, VirtualAGC. 

I have commented each line of code to show what it does, for anyone who has written 8-bit or 16-bit assembly it should be fairly easy to follow. The way interrupt vectors are setup at regular intervals just after the entry point at 4000 is similar to Z80. Being such an early computer, the AGC has a reputation of being primitive and difficult to program, but coming from C64 and Channel F development it didn't seem all that different - but then I'm making 2048, not calculating the required thrust to achieve lunar orbit.....

This website was an essential resource, it contains everything anyone would ever want to know about the AGC and more: http://www.ibiblio.org/apollo/

Some common instructions I used a lot in this code and their nearest 6502 equivalent:

    CA      LDA   Load into accumulator (no immediate mode, must be address)
    TS      STA   Store accumulator into RAM (erasable memory)
    TCF     JMP   Jump to label
    TC      JSR   Jump to subroutine
    RETURN  RTS   Return from subroutine (no stack, so for nested routines you need to save return address)
    BZF     BEQ   Branch if A = zero
    AD      ADC   Add to accumulator (no immediate mode, must be address)
    SU      SBC   Subtract from accumulator (as above)
    INCR    INC   Increment value held in address (A register is address 0)

And by far the handiest one is the INDEX instruction. It can preceed any instruction that has an address operand, and that instruction will then use that index value added to the base address. For example:

    INDEX  ARRAY_ID
    CA    MY_ARRAY

Will load the Nth value in MY_ARRAY depending on the value in the ARRAY_ID address. Or you can do INDEX A to index from the accumulator, INDEX a TCF instruction to create a jump table, INDEX a TS to store directly into an array position. The index value can even be negative!

You'll also notice the EXTEND instruction pop up through out the code. The original 'Block 1' AGC had a much smaller instruction set. As they didn't want to change the architecture too much to accomodate more instructions, the EXTEND instruct basically says the next instruction is a new 'Block 2' instruction. So many assembly errors were down to me forgetting to put EXTEND before SU or BZF...thankfully the yaYUL assembler does spit out exceptionally clear error messages so you know exactly what you've done wrong.


