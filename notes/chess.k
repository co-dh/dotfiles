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
    
 / Goal: use relational math to represent a chess board, and solve a simple puzzle (fork).
 / 
 / PGN replay

pgn: "1. e4 e5 2. Nf3 d6 3. d4 Bg4 4. Be2 Be7 5. dxe5 Bxf3 6. Bxf3 dxe5 7. O-O Nf6 8. Bg5 O-O 9. Nc3 c6 10. Qe2 Na6 11. Rfd1 Qc7 12. Bxf6 Bxf6 13. g3 Rfd8 14. Bg2 Rxd1+ 15. Rxd1 Rd8 16. Rxd8+ Qxd8 17. Qd3 Qxd3 18. cxd3 Nc5 19. Bf1 b6 20. Be2 a5 21. a4 Bg5 22. f4 exf4 23. gxf4 Bxf4 24. Kg2 Bc1 25. d4 Bxb2 26. dxc5 Bxc3 27. cxb6 Be5 28. Kf3 c5 29. Ke3 h6 30. h3 g5 31. Kd3 f6 32. Kc4 Bd6 33. Kd5 Bb8 34. Kxc5 Kf7 35. Kb5 Ke7 36. Kxa5 Kd6 37. Kb5 Kd7 38. Bg4+ Kd6 39. a5 Ke5 40. Bf5 h5 41. Kc6 g4 42. hxg4 hxg4 43. Bxg4 Kxe4 44. a6 f5 45. Bxf5+ Kxf5 46. a7 1-0"
pgn: 20#pgn
x:&(" "=pgn)& (1_pgn," ") in "0123456789"
x^pgn
