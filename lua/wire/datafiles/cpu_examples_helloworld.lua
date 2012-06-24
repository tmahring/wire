local path = "CPUChip/examples/helloworld.txt"

local contents = [[
//Wired Hello World!
//Connect CPU membus input to console screen
//Connect CPUs CLK input to button (toggle)
//Notice how you can store your 
//subroutines/calls in DATA area
jmp _code;
message:
  db 'Hello World!',0;
WriteString: //ESI - String pointer, EDX - Param
  mov eax,65536;
  AWriteLoop:
    cmp #esi,0; //Terminate on char 0
    je AEnd;
    mov #eax,#esi; //Output char
    inc eax;
    mov #eax,edx; //Output char param
    inc eax;
    inc esi;
  jmp AWriteLoop;
  AEnd:
ret //Return from call

_code:
  mov esi,message;
  mov edx,000999; //White foreground on black background
  call WriteString;

//More about colors:
//Lower 3 digits are foreground, 
//and higher 3 digits are background
//Each of 3 digits shows amount of
//RED, GREEN, and BLUE (in order)
//Each color has 10 shades - from 0 to 9
//
//For example, 999044 will be dark yellow (044) on
//a white background (999)
//
//Experiment with colors!
//
//Also, the 7th digit (if its not equal to 0) will
//cause the character to blink by changing foreground and
//background places (actual data in memory wont change)

]]

local f = file.Open(path, "w", "DATA")
if (f) then
	f:Write(contents)
	f:Close()
end