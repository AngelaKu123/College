執行環境: windows vmware ubuntu 22.04

程式內容:
利用指令"lsl"簡化多次"add"；以"mov r4, r1, lsl #1"為例，將r1向左平移一格，相當於r1*2^1，再將r1賦值給r4，r5亦同。
"mov r6, r3, lsl #3"，將r3向左平移3格，相當於r3*2^3；"sub r6, r6, r3"，r6 - r3 以完成題目中的 7*r3。
後續"add"、"sub"計算 r0 = 2 * r1 + 4 * r2 - 7 * r3。

編譯:
ptt提供的"arm-none-eabi-gcc -g -O0 hw2.s –o hw2.exe"

執行:
ptt提供的" arm-none-eabi-insight"，在GDB ARM simulator執行成功。
