# PONG-clone-for-comander-x-16
Pong clone for comander x16 written in 6502 Assembly using cc65 toolchain.<br>
<h2>How to build ?</h2>
<h3>On Linux (On probably MAC too) </h3>
if you have ca65 toolchain in $PATH just type make in main folder.<br>
if not go to folder with ca65 toolchaing and type something like :<br>
./cl65 -t cx16 -o PONG.PRG /PATH/TO/THIS/REPO/ON/YOUR/COMPUTER/main.s<br>
<h3> On windows </h3>
IDK. i don't have experience with using cc65 on Windows, but you just have to assemble main.s with cx16 as target.<br>

<h2>How to run ?</h2>
Open comander x16  emulator(for axample official one "x16emu" or box16) (emulator executable and PONG.PNG file have to be in same directory)<br>
Type:<br>
LOAD"PONG.PNG"<br>
Type RUN<br>


