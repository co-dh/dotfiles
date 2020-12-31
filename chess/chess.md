
# chess engine in relational math.

\l rel.k

## FEN chess notation display.

 There are 6 kind of pieces: King,Queen, Bishop,kNight,Rook,Pawn.
 The Forsyth-Edwards Notation use lower case letter for black pieces, and upper case for white pieces.
 There are 64 poistions in a chessboard.
 Positions are listed from 0(a8) to 63(h1) as FEN, as it's very natural to display it on a monitor.
 So instead of use chess ranks and files, we use row and column.

~~~
map: (raze string 1+til 8)!(1+til 8)#\:" "         ; / number 1 to 8 represent spaces.
map["/"]: "\n"                                     ; / / to separate each row.
unicode:"rnbqkpRNBQKP\n "! ("♜";"♞";"♝";"♛";"♚";"♟";"♖";"♘";"♗";"♕";"♔";"♙";"\n"; " ");
map[key unicode]:key unicode;

board  :{ "\n"vs raze map x}                       ; /given a FEN, return the board as 8X8 byte arrays of pieces
bg     :{"\033[48;5;106m",x,"\033[m"}              ; /show x with different background color with ansi color.
showRow:{[b;r]: raze(::;bg)[(r+til 8)mod 2]@'b[r]} ; /show a row of chessboard
clr    :(enlist"\033[2J")                          ; /clear screen
showFen:{clr,showRow[unicode@/:board x]each til 8} ; /show board with unicode and color
saveFen:{`:fen.txt 0: showFen x}                   ; / save board to a txt file, and cat in another terminal.
sh     :{}                                         ; / show functions are empty in normal code
Show   :{}

~~~

~~~
sh  : {show 8 cut x;}     / But show x as 8 rows when generating Markdown.
Show: show;               /
fen : "5b2/p3n2r/3R2pp/k1p1Bp2/2B1p3/1P6/P1P2PPP/2K5"
;-1@raze map fen;         / Chess displayed in ascii,
     b  
p   n  r
   R  pp
k p Bp  
  B p   
 P      
P P  PPP
  K     
;-1@raze unicode map fen; /   and in unicode.
     ♝  
♟   ♞  ♜
   ♖  ♟♟
♚ ♟ ♗♟  
  ♗ ♟   
 ♙      
♙ ♙  ♙♙♙
  ♔     
saveFen fen               /and you can cat fen.txt in a terminal to see the colors.
`:fen.txt

~~~

## Chess Pieces attack positions.

 Each position have at most 1 pieces on it, so it's a partial function.
 Each live pieces have exactly 1 position, so it's a mapping(full function).

### Rook and Queen move and attacks in row and column.

~~~
sh Pos2Row: raze 8#'enlist each(neg til 8)rotate\:10000000b; / The relation from position to row
10000000b 10000000b 10000000b 10000000b 10000000b 10000000b 10000000b 10000000b
01000000b 01000000b 01000000b 01000000b 01000000b 01000000b 01000000b 01000000b
00100000b 00100000b 00100000b 00100000b 00100000b 00100000b 00100000b 00100000b
00010000b 00010000b 00010000b 00010000b 00010000b 00010000b 00010000b 00010000b
00001000b 00001000b 00001000b 00001000b 00001000b 00001000b 00001000b 00001000b
00000100b 00000100b 00000100b 00000100b 00000100b 00000100b 00000100b 00000100b
00000010b 00000010b 00000010b 00000010b 00000010b 00000010b 00000010b 00000010b
00000001b 00000001b 00000001b 00000001b 00000001b 00000001b 00000001b 00000001b
sh Pos2Col: raze 8# enlist     (neg til 8)rotate\:10000000b; /   and to column.
10000000b 01000000b 00100000b 00010000b 00001000b 00000100b 00000010b 00000001b
10000000b 01000000b 00100000b 00010000b 00001000b 00000100b 00000010b 00000001b
10000000b 01000000b 00100000b 00010000b 00001000b 00000100b 00000010b 00000001b
10000000b 01000000b 00100000b 00010000b 00001000b 00000100b 00000010b 00000001b
10000000b 01000000b 00100000b 00010000b 00001000b 00000100b 00000010b 00000001b
10000000b 01000000b 00100000b 00010000b 00001000b 00000100b 00000010b 00000001b
10000000b 01000000b 00100000b 00010000b 00001000b 00000100b 00000010b 00000001b
10000000b 01000000b 00100000b 00010000b 00001000b 00000100b 00000010b 00000001b
sh pos2Row: raze (first where)@' Pos2Row;                  ; / The array form of the same relation
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 1
2 2 2 2 2 2 2 2
3 3 3 3 3 3 3 3
4 4 4 4 4 4 4 4
5 5 5 5 5 5 5 5
6 6 6 6 6 6 6 6
7 7 7 7 7 7 7 7
sh pos2Col: raze (first where)@' Pos2Col;                  ; / The array form of the same relation
0 1 2 3 4 5 6 7
0 1 2 3 4 5 6 7
0 1 2 3 4 5 6 7
0 1 2 3 4 5 6 7
0 1 2 3 4 5 6 7
0 1 2 3 4 5 6 7
0 1 2 3 4 5 6 7
0 1 2 3 4 5 6 7
sh first SameRow: same Pos2Row                             ; / Positions of the same row
11111111b
00000000b
00000000b
00000000b
00000000b
00000000b
00000000b
00000000b
sh first SameCol: same Pos2Col                             ; /   and same rank.
10000000b
10000000b
10000000b
10000000b
10000000b
10000000b
10000000b
10000000b

~~~

### Bishop and Queen move and attack in diagonals
  There are each 15 diagonals at goes down and up( read from left to right), we use -7 .. 7 to represent each. 
  a8 is at up diagonal 7, a7->b8 6


~~~
diagonal: -7+til 15                 ; / Diagonal are numbered from -7 to 7 for symetry.
sh pos2Down : pos2Col-pos2Row       ; / Each position have a right down diagonal,
0  1  2  3  4  5  6  7
-1 0  1  2  3  4  5  6
-2 -1 0  1  2  3  4  5
-3 -2 -1 0  1  2  3  4
-4 -3 -2 -1 0  1  2  3
-5 -4 -3 -2 -1 0  1  2
-6 -5 -4 -3 -2 -1 0  1
-7 -6 -5 -4 -3 -2 -1 0
sh pos2Up   : -7+pos2Col+pos2Row    ; /   and a right up diagonal.
-7 -6 -5 -4 -3 -2 -1 0
-6 -5 -4 -3 -2 -1 0  1
-5 -4 -3 -2 -1 0  1  2
-4 -3 -2 -1 0  1  2  3
-3 -2 -1 0  1  2  3  4
-2 -1 0  1  2  3  4  5
-1 0  1  2  3  4  5  6
0  1  2  3  4  5  6  7
Pos2Up      : pos2Up  =\:diagonal   ;
sh Pos2Down : pos2Down=\:diagonal   ;
000000010000000b 000000001000000b 000000000100000b 000000000010000b 000000000001000b 000000000000100b 000000000000010b 000000000000001b
000000100000000b 000000010000000b 000000001000000b 000000000100000b 000000000010000b 000000000001000b 000000000000100b 000000000000010b
000001000000000b 000000100000000b 000000010000000b 000000001000000b 000000000100000b 000000000010000b 000000000001000b 000000000000100b
000010000000000b 000001000000000b 000000100000000b 000000010000000b 000000001000000b 000000000100000b 000000000010000b 000000000001000b
000100000000000b 000010000000000b 000001000000000b 000000100000000b 000000010000000b 000000001000000b 000000000100000b 000000000010000b
001000000000000b 000100000000000b 000010000000000b 000001000000000b 000000100000000b 000000010000000b 000000001000000b 000000000100000b
010000000000000b 001000000000000b 000100000000000b 000010000000000b 000001000000000b 000000100000000b 000000010000000b 000000001000000b
100000000000000b 010000000000000b 001000000000000b 000100000000000b 000010000000000b 000001000000000b 000000100000000b 000000010000000b
sh @[;35]SameUp  : same Pos2Up      ; / All the positions that's in the same up diagonal as d4.
00000001b
00000010b
00000100b
00001000b
00010000b
00100000b
01000000b
10000000b
sh @[;35]SameDown: same Pos2Down    ;
00000000b
10000000b
01000000b
00100000b
00010000b
00001000b
00000100b
00000010b

diff :{x-/:\:x} /diff table of an array to itself

~~~

~~~
Show Pos2Up[35]
000000010000000b

~~~
### King move/attack in 1 step.

 King can move/attack 1 step in any direction, except those are occupied by it's own piece, or attacked by the opposite.

~~~
diff 1 2 3 4
0 -1 -2 -3
1 0  -1 -2
2 1  0  -1
3 2  1  0 
sh first diff pos2Row       / row difference between position 0 and others.
0  0  0  0  0  0  0  0 
-1 -1 -1 -1 -1 -1 -1 -1
-2 -2 -2 -2 -2 -2 -2 -2
-3 -3 -3 -3 -3 -3 -3 -3
-4 -4 -4 -4 -4 -4 -4 -4
-5 -5 -5 -5 -5 -5 -5 -5
-6 -6 -6 -6 -6 -6 -6 -6
-7 -7 -7 -7 -7 -7 -7 -7
sh first 2>abs diff pos2Row / positions with row difference to position 0 < 2
11111111b
11111111b
00000000b
00000000b
00000000b
00000000b
00000000b
00000000b

~~~


~~~
sh first king: (and). 2>abs each diff each (pos2Row;pos2Col);
11000000b
11000000b
00000000b
00000000b
00000000b
00000000b
00000000b
00000000b

~~~
 At position 0(A8), king can only move to 3 positions above, plus position 0. 

~~~
/ Given below board, here is where the king can move to.
-1@bd: board fen;
     b  
p   n  r
   R  pp
k p Bp  
  B p   
 P      
P P  PPP
  K     
sh k: king (raze bd)?"k"
00000000b
00000000b
11000000b
11000000b
11000000b
00000000b
00000000b
00000000b
/ White rook Rd6 attacks rank 6, and file d. We ignore blocks here now.
sh k&: not SameCol raze[bd] ? "R"
00000000b
00000000b
11000000b
11000000b
11000000b
00000000b
00000000b
00000000b
sh k&: not SameRow raze[bd] ? "R"
00000000b
00000000b
00000000b
11000000b
11000000b
00000000b
00000000b
00000000b

~~~

#### Pawn attack: white pawn(P) attack up left and up right, so row-1, column+-1

~~~
sh last 1=diff pos2Row
00000000b
00000000b
00000000b
00000000b
00000000b
00000000b
11111111b
00000000b
sh last 1=abs diff pos2Col
00000010b
00000010b
00000010b
00000010b
00000010b
00000010b
00000010b
00000010b

~~~

~~~
sh first -2 # P:( 1=diff pos2Row)&(1=abs diff pos2Col)
00000000b
00000000b
00000000b
00000000b
00000000b
00000000b
00000101b
00000000b
sh first      p:(-1=diff pos2Row)&(1=abs diff pos2Col) /black pawn attack downwards.
00000000b
01000000b
00000000b
00000000b
00000000b
00000000b
00000000b
00000000b

~~~

## Goal: use relational math to represent a chess board, and solve a simple puzzle (mobility analysis).



