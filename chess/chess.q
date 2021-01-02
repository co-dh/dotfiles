/# chess puzzle solver in relational mathematics.

\l rel.k

/## FEN chess notation display.

/ There are 6 kind of pieces: King,Queen, Bishop,kNight,Rook,Pawn.
/ The Forsyth-Edwards Notation use lower case letter for black pieces, and upper case for white pieces.
/ There are 64 poistions in a chessboard.
/ Positions are listed from 0(a8) to 63(h1) as FEN, as it's very natural to display it on a monitor.
/ So instead of use chess ranks and files, we use row and column.

/~~~q
sh: Show: out: {}                          ; / show functions are empty in normal code.
// sh: {show 8 cut x;}; Show: show; out: {-1@x;}         
map: (raze string 1+til 8)!(1+til 8)#\:" " ; / number 1 to 8 represent spaces.
map["/"]: "\n"                             ; / / to separate each row.
pieces: "rnbqkpRNBQKP "
map[pieces]: pieces;
unicode: pieces!("♜";"♞";"♝";"♛";"♚";"♟";"♖";"♘";"♗";"♕";"♔";"♙";enlist" "); / count of 1 unicode char is not 1.
fen: "5b2/p3n2r/3R2pp/k1p1Bp2/2B1p3/1P6/P1P2PPP/2K5" ; / an example
board: { "\n"vs raze map x}                       ; /given a FEN, return the board as 8X8 byte arrays of pieces
// -1@bd: board fen;
/~~~

/### show chess board as Markdown table
/~~~q
mdRow: {"|",("|" sv x),"|"} ; / render a row as Markdown table row.
out first chessHeader: mdRow each enlist@'' ("abcdefgh"; 8#"-")

chessRow: {mdRow raze unicode enlist each x } ; / display row as Markdown
// -1@chessRow bd[2];

mdBoard: {-1@"\n"; -1@chessHeader,chessRow each x; -1@"\n";} ; / generate MD table for a chess board. x: str[]
/~~~

// mdBoard board fen

/## Chess Piece attacks position.
/~~~q
attack:()!()    ; / dictionary from piece to attack relation.
/~~~

/### Rook attacks in row and column.
/~~~q
sh Pos2Row: raze 8#'enlist each(neg til 8)rotate\:10000000b; / The relation from position to row
sh Pos2Col: raze 8# enlist     (neg til 8)rotate\:10000000b; /   and to column.
sh pos2Row: raze (first where)@' Pos2Row;                  ; / The array form of the same relation 
sh pos2Col: raze (first where)@' Pos2Col;                  ; / The array form of the same relation 
sh first SameRow: same Pos2Row                             ; / Positions of the same row
sh first SameCol: same Pos2Col                             ; /   and same rank.
sh first attack[`R]:attack[`r]: SameRow | SameCol          ; / Rook can attack by row and rank. (Ignore block for now)
/~~~

/### King attack in 1 step.
/ King can move/attack 1 step in any direction, except those are occupied by it's own piece, or attacked by the opposite.
/~~~q
diff :{x-/:\:x} /diff table of an array to itself
// diff 1 2 3 4
// sh first diff pos2Row       / row difference between position 0 and others.
// sh first 2>abs diff pos2Row / positions with row difference to position 0 < 2

sh first attack[`k]:attack[`K]: (and). 2>abs each diff each (pos2Row;pos2Col);
/ At position 0(A8), king can only move to 3 positions above, plus position 0.
/~~~

/#### Pawn attack: white pawn(P) attack up left and up right, so row-1, column+-1
/~~~q
// sh last 1=    diff pos2Row   / all positions in rank 2 are 1 row less than h1. 
// sh last 1=abs diff pos2Col   / file 7 is 1 column less than h1.
sh first -2 # attack[`P]:( 1=diff pos2Row)&(1=abs diff pos2Col) /Pg1 attacks f2 and h2.
sh first      attack[`p]:(-1=diff pos2Row)&(1=abs diff pos2Col) /pa8 attacks b7
/~~~

/### Bishops and Queen move and attack in diagonals
/  There are each 15 diagonals at goes down and up( read from left to right), we use -7 .. 7 to represent each. 
/  a8 is at up diagonal 7, a7->b8 6
/~~~q
diagonal    : -7+til 15                 ; / Diagonal are numbered from -7 to 7 for symetry.
sh pos2Down : pos2Col-pos2Row       ; / Each position have a right down diagonal,
sh pos2Up   : -7+pos2Col+pos2Row    ; /   and a right up diagonal.  
Pos2Up      : pos2Up  =\:diagonal   ;
Pos2Down    : pos2Down=\:diagonal   ;
attack[`B]: attack[`b]: same[Pos2Up] | same Pos2Down;
// sh attack[`B]35 / Bd4 attacks these positions.
/~~~

/## King mobility analysis.

/ Given board like this:
// mdBoard board fen
/~~~q
Attack:{[piece; board]; any attack[piece] where board=piece}
/~~~
/
    bd: `$/:raze bd;
    sh Attack[`R; bd]; /R attack following pieces.(Blocking ignored)
    sh Attack[`B; bd]; /B attack 
    sh Attack[`P; bd]; /P attack
    sh attacked: any `R`B`P Attack\:bd
    sh Attack[`k; bd]; /where k can move to.
    sh k:Attack[`k; bd] & not attacked; /k cannot move to attacked positions.
\

/To solve the puzzle, we need to find a piece that can attack ememy's king and all of it's legal positions.
/~~~q
move: attack ; / most pieces move and attack the same way, except pawns.
/~~~

/
    show B:where bd = `B //B's positions are at e5(28), c4(34)
    sh first ma:com[move[`B];attack[`B]]B //Be5 can attack these positions in 2 steps
    all each k <=/: ma  /and it covers all kings legal positions.
\
