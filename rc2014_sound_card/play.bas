10 REM BASIC handler for "rc2014 sound card" PLAY by George Beckett
20 REM Created by Justin Skists (@jskists)
40 PRINT "loading machine code"
50 GOSUB 9000 : REM Initialise PLAY routine
60 PRINT "loading machine code...done"
70 PRINT "Playing Hall of the Mountain King"
80 RESTORE 1000
90 GOSUB 8000
95 FOR n=&HD000 to &HD02F: print HEX$(n);"=";HEX$(PEEK(N)): next n
100 STOP

1000 REM Hall of the Mountain King
1010 REM channel 0
1020 DATA "O5T120N3e#fgabg5b3#a#f5#a3af5aN3e#fgabgbENDbgb7D"
1030 DATA ""
1040 REM channel 1
1050 DATA "O5V6N3b#C#DE#F#D5#FN3G#D5G3#F#D5#FN3b#C#DE#F#D5#FN3G#D5G7#F"
1070 DATA ""
1080 REM channel 2
1090 DATA "O5V6N3Dbgb7DN5&E7&N5&E7&N3e#fgabgbE"
1100 DATA ""

2000 REM Blinding Light
2010 REM channel 0
2020 DATA "T168O5W0X8000U7F6F3$EF5G5C6$EN7F6F3$EF5G5C6$EN3$B5G5F6$E3$B"
2030 DATA "5GF$E3FX12000N9F"
2040 DATA ""
2050 REM channel 1
2060 DATA "O4V5N9ff9gg9ggg"
2070 DATA ""
2080 REM channel 2
2090 DATA "O4V5N9$a$a9CC9$b$b$b"
2100 DATA ""

3000 REM Demo tune
3010 REM channel 0
3020 DATA "W0X4000U7&&&&&&&&O4N1gggg3b1bbDDDD3EGCCE1EGE3G3A1GE4G3EG"
3030 DATA "EE1D3E1bX5003D"
3040 DATA ""
3050 REM channel 1
3060 DATA "O4V8N3gggggggggggggef#fgggggggggggggef#fggggggggcccccccc"
3070 DATA "ggggggg"
3080 DATA ""
3090 REM channel 2
3100 DATA "O4V8N3gggggggggggggef#fgggggggggggggef#fggggggggcccccccc"
3110 DATA "ggggggg"
3120 DATA ""

8000 REM Routine to play
8010 LET mb=&HD100
8020 FOR c=0 TO 2: GOSUB 8100: NEXT c
8030 RETURN

8100 POKE &HD000+(16*c), c: REM set channel number
8110 POKE &HD001+(16*c), mb AND 255: REM set LSB addr of start (LSB)
8120 POKE &HD002+(16*c), (mb / 256) AND 255: REM set addr of start (MSB)
8130 POKE &HD003+(16*c), 0: REM LSB reset current position
8140 POKE &HD004+(16*c), 0: REM MSB reset current position

8200 READ x$: IF LEN(x$)=0 THEN goto 8300
8210 PRINT "channel ";c;": ";x$
8220 FOR n=1 TO LEN(x$)
8230 LET a=ASC(MID$(x$, n, 1))
8240 PRINT hex$(mb);" -> ";hex$(a)
8250 POKE mb, a
8260 LET mb=mb+1
8270 NEXT n
8280 GOTO 8200

8300 POKE &HD005+(16*c), mb AND 255: REM set addr of end (LSB)
8310 POKE &HD006+(16*c), (mb / 256) AND 255: REM set addr of end (MSB)
8320 POKE &HD007+(16*c), 255: REM default note duration (LSB)
8330 POKE &HD008+(16*c), 255: REM default note duration (MSB)
8340 POKE &HD009+(16*c), 0: REM current note counter (LSB)
8350 POKE &HD00A+(16*c), 0: REM current note counter (MSB)
8360 POKE &HD00B+(16*c), &H30: REM octave 5 by default
8370 POKE &HD00C+(16*c), &H0F: REM volume

8400 POKE &HC004+(2*c), (16*c): REM set channel c
8410 POKE &HC005+(2*c), &HD0: REM set channel c
8420 RETURN


9000 REM Routine to load machine code
9010 LET mb=&HC000
9020 RESTORE 9210
9030 READ a
9040 IF (a>255) THEN GOTO 9100
9045 REM PRINT hex$(mb);" -> ";a
9050 POKE mb, a
9060 LET mb=mb+1
9070 GOTO 9030

9100 REM Set location of USR address (&H8049 for 32K BASIC)
9110 POKE &H8049, &H00: REM LSB of machine code origin
9120 POKE &H804A, &HC0: REM MSB of machine code origin
9130 RETURN

9200 REM PLAY.BIN
9210 DATA 195,10,192,0,244,196,1,197,14,197,243,253
9220 DATA 34,226,195,237,115,228,195,205,211,194,175,245
9230 DATA 205,47,195,241,60,254,3,32,246,205,9,195
9240 DATA 253,203,0,126,40,7,6,6,0,16,253,24
9250 DATA 34,253,94,9,253,86,10,122,179,32,13,58
9260 DATA 237,196,205,173,195,205,110,192,56,13,24,7
9270 DATA 27,253,115,9,253,114,10,33,238,196,52,58
9280 DATA 237,196,60,50,237,196,254,3,32,195,175,50
9290 DATA 237,196,58,238,196,167,40,100,175,50,238,196
9300 DATA 24,179,205,20,194,48,9,205,28,195,253,203
9310 DATA 0,254,55,201,254,48,56,52,254,58,48,48
9320 DATA 205,150,194,205,162,194,124,167,194,202,196,125
9330 DATA 167,202,202,196,254,10,210,202,196,61,95,22
9340 DATA 0,33,230,195,25,70,237,91,239,196,33,0
9350 DATA 0,25,16,253,253,117,7,253,116,8,24,186
9360 DATA 33,249,193,1,9,0,237,177,203,33,33,1
9370 DATA 194,9,94,35,86,235,205,19,194,208,24,162
9380 DATA 205,141,195,253,42,226,195,251,33,3,192,54
9390 DATA 0,201,205,51,194,253,70,12,124,181,32,2
9400 DATA 6,0,197,58,237,196,203,39,93,87,205,182
9410 DATA 195,92,20,205,182,195,193,58,237,196,198,8
9420 DATA 87,88,205,182,195,253,203,12,102,40,9,58
9430 DATA 243,196,95,22,13,205,182,195,253,94,7,253
9440 DATA 86,8,253,115,9,253,114,10,167,201,205,162
9450 DATA 194,124,167,194,202,196,125,254,16,210,202,196
9460 DATA 58,237,196,198,8,87,93,205,182,195,253,117
9470 DATA 12,55,201,205,162,194,58,237,196,167,40,2
9480 DATA 55,201,235,62,30,14,240,205,204,195,71,33
9490 DATA 239,196,113,35,112,55,201,205,162,194,124,167
9500 DATA 194,202,196,125,254,64,210,202,196,47,22,7
9510 DATA 95,205,182,195,55,201,55,201,205,162,194,125
9520 DATA 254,11,210,202,196,167,202,202,196,175,6,12
9530 DATA 133,16,253,253,119,11,55,201,253,126,12,246
9540 DATA 31,253,119,12,95,58,237,196,198,8,87,205
9550 DATA 182,195,33,241,196,78,35,70,22,11,89,197
9560 DATA 205,182,195,193,20,88,205,182,195,58,243,196
9570 DATA 95,22,13,205,182,195,55,201,205,162,194,124
9580 DATA 167,194,202,196,125,254,8,210,202,196,6,0
9590 DATA 79,33,217,193,9,126,50,243,196,95,22,13
9600 DATA 205,182,195,55,201,0,4,11,13,8,12,14
9610 DATA 10,205,162,194,235,33,241,196,115,35,114,235
9620 DATA 22,11,93,205,182,195,20,92,205,182,195,55
9630 DATA 201,79,86,78,84,77,85,87,88,218,192,225
9640 DATA 193,184,193,136,193,87,193,59,193,110,193,30
9650 DATA 193,112,193,233,253,110,3,253,102,4,125,253
9660 DATA 190,5,32,6,124,253,190,6,40,11,126,253
9670 DATA 52,3,32,3,253,52,4,167,201,55,201,14
9680 DATA 0,254,35,32,6,12,205,20,194,24,246,254
9690 DATA 36,32,6,13,205,20,194,24,236,254,38,32
9700 DATA 4,33,0,0,201,203,111,32,6,245,62,12
9710 DATA 129,79,241,230,223,214,65,218,219,196,254,7
9720 DATA 210,219,196,33,143,194,95,22,0,25,126,129
9730 DATA 253,134,11,214,21,48,4,33,191,15,201,254
9740 DATA 108,210,219,196,203,39,33,242,195,95,22,0
9750 DATA 25,94,35,86,235,167,201,9,11,0,2,4
9760 DATA 5,7,253,126,3,253,53,3,167,192,253,53
9770 DATA 4,201,33,0,0,22,0,229,205,20,194,225
9780 DATA 56,23,254,48,56,16,254,58,48,12,214,48
9790 DATA 205,202,194,79,6,0,9,20,24,229,205,150
9800 DATA 194,122,167,192,55,201,84,93,6,9,25,216
9810 DATA 16,252,201,205,141,195,175,50,237,196,175,50
9820 DATA 238,196,17,66,0,33,239,196,115,35,114,1
9830 DATA 64,31,33,241,196,113,35,112,22,11,89,197
9840 DATA 205,182,195,193,20,88,205,182,195,62,0,50
9850 DATA 243,196,95,22,13,205,182,195,201,58,237,196
9860 DATA 33,4,192,79,203,33,6,0,9,78,35,70
9870 DATA 197,253,225,201,71,4,62,128,7,16,253,33
9880 DATA 236,196,182,119,22,7,95,205,182,195,201,245
9890 DATA 33,4,192,203,39,79,6,0,9,78,35,70
9900 DATA 197,253,225,241,245,253,119,0,71,4,62,127
9910 DATA 7,16,253,33,236,196,166,119,22,7,95,205
9920 DATA 182,195,241,198,8,87,30,15,205,182,195,253
9930 DATA 115,12,62,60,253,119,11,253,126,1,253,119
9940 DATA 3,253,126,2,253,119,4,253,54,9,0,253
9950 DATA 54,10,0,17,66,0,33,0,0,6,24,25
9960 DATA 16,253,253,117,7,253,116,8,201,62,255,33
9970 DATA 236,196,119,22,7,95,205,182,195,22,8,30
9980 DATA 0,205,182,195,20,30,0,205,182,195,20,30
9990 DATA 0,205,182,195,201,198,8,87,30,0,205,182
10000 DATA 195,201,122,1,216,0,237,121,123,1,208,0
10010 DATA 237,121,201,122,1,216,0,237,121,237,88,201
10020 DATA 33,0,0,6,16,203,17,23,237,106,237,82
10030 DATA 48,1,25,63,16,243,203,17,23,201,0,0
10040 DATA 0,0,6,9,12,18,24,36,48,72,96,4
10050 DATA 8,16,94,16,117,15,140,14,197,13,253,12
10060 DATA 62,12,144,11,233,10,75,10,190,9,49,9
10070 DATA 172,8,47,8,186,7,70,7,0,6,126,6
10080 DATA 31,6,200,5,116,5,37,5,223,4,152,4
10090 DATA 86,4,23,4,221,3,163,3,113,3,63,3
10100 DATA 15,3,228,2,186,2,146,2,111,2,76,2
10110 DATA 43,2,11,2,238,1,209,1,184,1,159,1
10120 DATA 135,1,114,1,93,1,73,1,55,1,38,1
10130 DATA 21,1,5,1,247,0,232,0,220,0,207,0
10140 DATA 195,0,185,0,174,0,164,0,155,0,147,0
10150 DATA 138,0,130,0,123,0,116,0,110,0,103,0
10160 DATA 97,0,92,0,87,0,82,0,77,0,73,0
10170 DATA 69,0,65,0,61,0,58,0,55,0,51,0
10180 DATA 48,0,46,0,43,0,41,0,38,0,36,0
10190 DATA 34,0,32,0,30,0,29,0,27,0,25,0
10200 DATA 24,0,23,0,21,0,20,0,19,0,18,0
10210 DATA 17,0,16,0,15,0,14,0,13,0,12,0
10220 DATA 12,0,11,0,10,0,10,0,9,0,9,0
10230 DATA 8,0,205,141,195,237,123,228,195,253,42,226
10240 DATA 195,33,3,192,54,2,201,205,141,195,237,123
10250 DATA 228,195,253,42,226,195,33,3,192,54,1,201
10260 DATA 255,0,0,66,0,64,31,0,0,27,197,0
10270 DATA 0,75,197,255,255,0,0,48,15,1,75,197
10280 DATA 0,0,134,197,255,255,0,0,48,15,1,134
10290 DATA 197,0,0,169,197,255,255,0,0,48,15,79
10300 DATA 53,84,49,50,48,78,51,101,35,102,103,97
10310 DATA 98,103,53,98,51,35,97,35,102,53,35,97
10320 DATA 51,97,102,53,97,78,51,101,35,102,103,97
10330 DATA 98,103,98,69,78,68,98,103,98,55,68,79
10340 DATA 53,86,54,78,51,98,35,67,35,68,69,35
10350 DATA 70,35,68,53,35,70,78,51,71,35,68,53
10360 DATA 71,51,35,70,35,68,53,35,70,78,51,98
10370 DATA 35,67,35,68,69,35,70,35,68,53,35,70
10380 DATA 78,51,71,35,68,53,71,55,35,70,79,53
10390 DATA 86,54,78,51,68,98,103,98,55,68,78,53
10400 DATA 38,69,55,38,78,53,38,69,55,38,78,51
10410 DATA 101,35,102,103,97,98,103,98,69
10420 DATA 999: REM end marker
