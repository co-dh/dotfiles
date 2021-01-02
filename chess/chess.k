/# chess engine in relational math.

/## Relational mathematics in k. Relations are represented as Boolean Matrix.
/~~~
com:{x:|/'y@&:'x; c:#:'x; w:&0=c; @[x;w;:;(#w)#,(|/c)#0b]}; 
lres:{~com[+x;~y]}; Syq:{lres[x;y]&lres[~x;~y]}; Id:{x^(x*x) #1b,x#0b};  univ:{|/|/~com[+x;x]>Id@#x}; 
univ:{&/2>+/'x}; inj:{univ@+x}; tot:{&/|/'x}; surj:{tot@+x}; mapping:{tot[x]&univ[x]}; bij:{inj[x]&surj[x]}; 
Top:{x#,y#1b};  bot:{x#,y#0b}; Vec:{&/=/'x}; reflexive: {&/x ./: i,'i:!#x}; dom:{com[x; Top[#*x;#*x]]}; cod:{dom@+x};
same:{com[x;+x]};
/~~~

/## FEN chess notation display.
/~~~
unicode:"rnbqkpRNBQKP\n "! ("♜";"♞";"♝";"♛";"♚";"♟";"♖";"♘";"♗";"♕";"♔";"♙";"\n"; " ")
map: (,/$1+!8)!(1+!8)#\:" "; map["/"]: "\n"; map[!unicode]:!unicode /decode FEN notation.
board:{ "\n"\:,/map x}                                              /given a FEN, return the board as 8X8 byte arrays of pieces 
bg: {"\033[48;5;106m",x,"\033[m"}                                   /show x with different background color by ansi color (256 colors)
showRow:{[board;row]: ,/(::;bg)[.q.mod[row+!8;2]]@'board[row]}      /show a row of chessboard 
showFen:{(,"\033[2J"),showRow[unicode @/: board x]'!8}              /[2J is clear screen. 
saveFen:{`:fen.txt 0: showFen x}
sh: {.q.show .q.cut[8;] x} /show as 8*8

/~~~
/
    fen:"5b2/p3n2r/3R2pp/k1p1Bp2/2B1p3/1P6/P1P2PPP/2K5"
    ;-1@,/map fen;
    /saveFen fen
    /fswatch -o fen.txt | xargs -n1 -I{} cat fen.txt
\

    
/ There are 64 poistions on a chessboard.
/ Positions are from 0(a8) to 63(h1) as FEN, because it's very natural to display on computer.

/ 6 kind of pieces: King,Queen, Bishop,kNight,Rook,Pawn X 2 colors
/ Each position have at most 1 pieces on it, so it's a partial function.
/ Each live pieces have exactly 1 position, so it's a mapping(full function).
/ Each side have 16 pieces at beginning. 

/ Each piece can have at most 1 position. When it's captured, it has no position

/ So instead of use chess Rank and Files, we use row and column.
/ Each position have a row and rank as relation:

/~~~
Pos2Row: ,/8#',:'(-!8).q.rotate\:10000000b
Pos2Col: ,/8# ,:(-!8).q.rotate\:10000000b
/~~~
/
sh Pos2Row
sh Pos2Col
\

/ What positions are in the same raw?  
/~~~
SameRow: same Pos2Row; 
SameRank:same Pos2Col;
/~~~
/
    sh SameRow
    sh SameRank
\

/  There are each 15 diagonals at goes down and up( read from left to right), we use -7 .. 7 to represent each. 
/  a8 is at up diagonal 7, a7->b8 6

/~~~
    diagonal:  -7+!15 
    pos2Up:  -/(*:&:)''(Pos2Col;Pos2Row)
    pos2Down: ,/| 8^pos2Up
    Pos2Up: pos2Up=\:diagonal
    Pos2Down: pos2Down=\:diagonal
    SameUp:  same Pos2Up;
    SameDown:same Pos2Down; 
/~~~
/
sh pos2Up
sh pos2Down
sh Pos2Up
\

/ Goal: use relational math to represent a chess board, and solve a simple puzzle (mobility analysis).

/ King can move 1 steps in any direction in 1 ply, except those are occupied by it's own piece, or attacked by the opposite.
/
    king:&/2>abs'{x-/:\:x}'(*:&:)''(Pos2Row;Pos2Col)  //row and rank difference < 2
    / function has it's virtual too. Otherwise, how can we express the relation of x+y=z with boolean matrix?
    bd:board fen /FEN start from a8 to h1.
    sh k: king (,/bd)?"k" /king can move to these positions, including it's current position.
       White rook Rd6 attacks rank 6, and row d. We ignore block here first.
   sh@ k: k&~:SameRank (,/bd) ? "R" 
   sh@ k: k&~:SameRow (,/bd) ? "R"
   
    / Pawn attack: white pawn(P) attack up left and up right, so row+1, rank+-1
    / instead of convert position 10000000b to number and +-1, we can shift 
\
    / shift y to the right x digits, with 0 padding
/~~~
    rshift:{ (x#0b),x _ y}
    lshift:{ ((-x) _ y),x#0b}
/~~~
/
    rshift[1; 1 2 3 4]
    lshift[1; 1 2 3 4]
    sh Pos2Row
\
    


