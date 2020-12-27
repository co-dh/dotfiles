\l rel.k
/ chess engine is relational math.
    
/ There are 64 poistions.
/ 6 kind of pieces: King,Queen, Bishop,kNight,Rook,Pawn X 2 colors
/ Each position have at most 1 pieces on it, so it's a partial function.
/ Each live pieces have exactly 1 position, so it's a mapping(full function).
/ Each side have 16 pieces at beginning. 

pieces:("kqbbnnrr",8#"p"),"KQBBNNRR",8#"P"  

/ Each piece can have at most 1 position. When it's captured, it has no position

/ Positions are from 0(a1) to 63(h8).
/ Each position have a row and rank as relation: 
    rot:{x: .q.mod[#y; x]; ((-x)#y),((#y)-x)#y} /rotate array y x element to the right. 
    Pos2Row: ,/8#','(!8) rot\: 10000000b
    Pos2Rank: ,/8#,(!8)rot\:10000000b

/ What positions are in the same raw?  
    SameRow: same Pos2Row; 
    SameRank:same Pos2Rank; 

/  There are each 15 diagonals at goes down and up( read from left to right), we use -7 .. 7 to represent each. 
/  a8 is at up diagonal 7, a7->b8 6 
    diagonal:  -7+!15 
    pos2Up:  -/(*&)''(Pos2Rank;Pos2Row)
    pos2Down: ,/| 8^pos2Up
    Pos2Up: pos2Up=\:diagonal
    Pos2Down: pos2Down=\:diagonal
    SameUp:  same Pos2Up;
    SameDown:same Pos2Down; 

/ and the relation from position to diagonals are:
    
/ Goal: use relational math to represent a chess board, and solve a simple puzzle (mobility analysis).
/ 
