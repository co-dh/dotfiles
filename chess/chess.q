/# chess engine in relational math.

\l rel.k

/## FEN chess notation display.

/ There are 6 kind of pieces: King,Queen, Bishop,kNight,Rook,Pawn.
/ The Forsyth-Edwards Notation use lower case letter for black pieces, and upper case for white pieces.
/ There are 64 poistions in a chessboard.
/ Positions are listed from 0(a8) to 63(h1) as FEN, as it's very natural to display it on a monitor.
/ So instead of use chess ranks and files, we use row and column.
/~~~
map: (raze string 1+til 8)!(1+til 8)#\:" "         ; / number 1 to 8 represent spaces.
map["/"]: "\n"                                     ; / / to separate each row.
unicode:"rnbqkpRNBQKP\n "! ("♜";"♞";"♝";"♛";"♚";"♟";"♖";"♘";"♗";"♕";"♔";"♙";"\n"; " ");
map[key unicode]:key unicode;

board:{ "\n"vs raze map x}                         ; /given a FEN, return the board as 8X8 byte arrays of pieces 
bg: {"\033[48;5;106m",x,"\033[m"}                  ; /show x with different background color with ansi color. 
showRow:{[b;r]: raze(::;bg)[r+til[8]mod 2]@'b[r]}  ; /show a row of chessboard
clr:(enlist"\033[2J")                              ; /clear screen 
showFen:{clr,showRow[unicode@/:board x]each til 8} ; /show board with unicode and color
saveFen:{`:fen.txt 0: showFen x}                   ; / save board to a txt file, and cat in another terminal.
sh:{}                                              ; / show functions are empty in normal code
Show:{}
/~~~
/
    sh: {show 8 cut x;}       / But show x as 8 rows when generating Markdown.
    Show: show;               / 
    fen:"5b2/p3n2r/3R2pp/k1p1Bp2/2B1p3/1P6/P1P2PPP/2K5"
    ;-1@raze map fen;         / Chess displayed in ascii,
    ;-1@raze unicode map fen; /   and in unicode.
    saveFen fen               /and you can cat fen.txt in a terminal to see the colors.
\

/## Chess Pieces attack positions.

/ Each position have at most 1 pieces on it, so it's a partial function.
/ Each live pieces have exactly 1 position, so it's a mapping(full function).

/### Rook and Queen move and attacks in row and column.

/~~~
sh Pos2Row: raze 8#'enlist each(neg til 8)rotate\:10000000b; / The relation from position to row
sh Pos2Col: raze 8# enlist     (neg til 8)rotate\:10000000b; /   and to column.
sh SameRow: same Pos2Row                                   ; / Positions of the same row
sh SameCol:same Pos2Col                                   ; /   and same rank.
/~~~

/### Bishop and Queen move and attack in diagonals
/  There are each 15 diagonals at goes down and up( read from left to right), we use -7 .. 7 to represent each. 
/  a8 is at up diagonal 7, a7->b8 6

/~~~
diagonal: -7+til 15                                     ; 
sh pos2Up: raze (-). (first where)@''(Pos2Col;Pos2Row)  ;
sh pos2Down: raze flip  8 cut pos2Up                    ;
sh Pos2Up:   pos2Up  =\:diagonal                        ;
sh Pos2Down: pos2Down=\:diagonal                        ;
sh SameUp:  same Pos2Up                                 ;
sh SameDown:same Pos2Down                               ; 
/~~~

/### King move/attack in 1 step.

/ King can move/attack 1 step in any direction, except those are occupied by it's own piece, or attacked by the opposite.
/
    sh                 raze (first where)@'Pos2Row  /convert boolean array to row
    sh {2>abs x-/:\:x} raze (first where)@'Pos2Row  /positions with row difference <2
\

/~~~
Show king: (and). {2>abs x-/:\:x} each raze each (first where)@''(Pos2Row;Pos2Col); 
/~~~
    
/        
    / Given above board,
    / Here is where the king can move to.
    bd: board fen
    sh k: king (raze bd)?"k" 
    / White rook Rd6 attacks rank 6, and file d. We ignore block here first.
    sh k&: not SameCol raze[bd] ? "R" 
    sh k&: not SameRow raze[bd] ? "R"
\

/#### Pawn attack: white pawn(P) attack up left and up right, so row+1, rank+-1

    / instead of convert position 10000000b to number and +-1, we can shift 
    / shift y to the right x digits, with 0 padding
/~~~
rshift:{ (x#0b),neg[x] _ y}
lshift:{ (x _ y),x#0b}
/~~~
/
    rshift[1; 1000b]
    lshift[1; 0100b]
\
    
/## Goal: use relational math to represent a chess board, and solve a simple puzzle (mobility analysis).


