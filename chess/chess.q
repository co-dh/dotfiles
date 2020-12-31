/# chess engine in relational math.

\l rel.k

/## FEN chess notation display.

/ There are 6 kind of pieces: King,Queen, Bishop,kNight,Rook,Pawn.
/ The Forsyth-Edwards Notation use lower case letter for black pieces, and upper case for white pieces.
/ There are 64 poistions in a chessboard.
/ Positions are listed from 0(a8) to 63(h1) as FEN, as it's very natural to display it on a monitor.
/ So instead of use chess ranks and files, we use row and column.
/~~~Q
sh     :{}                                         ; / show functions are empty in normal code
Show   :{}

map: (raze string 1+til 8)!(1+til 8)#\:" "         ; / number 1 to 8 represent spaces.
map["/"]: "\n"                                     ; / / to separate each row.
pieces:"rnbqkpRNBQKP "
map[pieces]: pieces;
unicode:pieces! ("♜";"♞";"♝";"♛";"♚";"♟";"♖";"♘";"♗";"♕";"♔";"♙";enlist" "); / count of 1 unicode char is not 1.

board  :{ "\n"vs raze map x}                       ; /given a FEN, return the board as 8X8 byte arrays of pieces 
mdRow: {"|",("|" sv x),"|" } ; / render a row as Markdown table row.
chessHeader: mdRow each enlist@'' ("abcdefgh"; 8#"-")
chessRow: {mdRow raze unicode enlist each y } ; / display row x ( with content in y ) as Markdown
mdBoard: {-1@"\n"; -1@chessHeader,string[reverse 1+til 8]chessRow'x; -1@"\n";} ; / generate MD table for a chess board. x: str[]
/~~~

/
    sh  : {show 8 cut x;}     / But show x as 8 rows when generating Markdown.
    Show: show;               / 
    fen : "5b2/p3n2r/3R2pp/k1p1Bp2/2B1p3/1P6/P1P2PPP/2K5"
    ;-1@raze map fen;         / Chess displayed in ascii,
    
    style: " <style>"
    style,:"   table tr:nth-child(odd) td:nth-child(even) { background:#aab } \n"
    style,:"   table tr:nth-child(even) td:nth-child(odd) { background:#aab } \n"
    style,:"   table td { font-size:150%; text-align: center} \n"
    style,:" </style>\n"
\

//Markdown -1@style;
//Markdown mdBoard board fen

/## Chess Pieces attack positions.

/ Each position have at most 1 pieces on it, so it's a partial function.
/ Each live pieces have exactly 1 position, so it's a mapping(full function).

/### Rook and Queen move and attacks in row and column.
/~~~Q
sh Pos2Row: raze 8#'enlist each(neg til 8)rotate\:10000000b; / The relation from position to row
sh Pos2Col: raze 8# enlist     (neg til 8)rotate\:10000000b; /   and to column.
sh pos2Row: raze (first where)@' Pos2Row;                  ; / The array form of the same relation 
sh pos2Col: raze (first where)@' Pos2Col;                  ; / The array form of the same relation 
sh first SameRow: same Pos2Row                             ; / Positions of the same row
sh first SameCol: same Pos2Col                             ; /   and same rank.
/~~~

/### Bishop and Queen move and attack in diagonals
/  There are each 15 diagonals at goes down and up( read from left to right), we use -7 .. 7 to represent each. 
/  a8 is at up diagonal 7, a7->b8 6

/~~~Q
diagonal: -7+til 15                 ; / Diagonal are numbered from -7 to 7 for symetry.
sh pos2Down : pos2Col-pos2Row       ; / Each position have a right down diagonal,
sh pos2Up   : -7+pos2Col+pos2Row    ; /   and a right up diagonal.  
Pos2Up      : pos2Up  =\:diagonal   ;
sh Pos2Down : pos2Down=\:diagonal   ;
sh @[;35]SameUp  : same Pos2Up      ; / All the positions that's in the same up diagonal as d4.
sh @[;35]SameDown: same Pos2Down    ;

diff :{x-/:\:x} /diff table of an array to itself
/~~~
/
Show Pos2Up[35]
\
/### King move/attack in 1 step.

/ King can move/attack 1 step in any direction, except those are occupied by it's own piece, or attacked by the opposite.
/
    diff 1 2 3 4
    sh first diff pos2Row       / row difference between position 0 and others.
    sh first 2>abs diff pos2Row / positions with row difference to position 0 < 2
\

/~~~Q
sh first king: (and). 2>abs each diff each (pos2Row;pos2Col);
/~~~
/ At position 0(A8), king can only move to 3 positions above, plus position 0. 
/        
    / Given below board, here is where the king can move to.
    -1@bd: board fen;
    sh k: king (raze bd)?"k" 
    / White rook Rd6 attacks rank 6, and file d. We ignore blocks here now.
    sh k&: not SameCol raze[bd] ? "R" 
    sh k&: not SameRow raze[bd] ? "R"
\

/#### Pawn attack: white pawn(P) attack up left and up right, so row-1, column+-1
/
    sh last 1=diff pos2Row
    sh last 1=abs diff pos2Col
\
/~~~Q
sh first -2 # P:( 1=diff pos2Row)&(1=abs diff pos2Col)
sh first      p:(-1=diff pos2Row)&(1=abs diff pos2Col) /black pawn attack downwards. 
/~~~
    
/## Goal: use relational math to represent a chess board, and solve a simple puzzle (mobility analysis).


