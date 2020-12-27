unicode:"rnbqkpRNBQKP\n "! ("♜";"♞";"♝";"♛";"♚";"♟";"♖";"♘";"♗";"♕";"♔";"♙";"\n"; " ");
map: (,/$1+!8)!(1+!8)#\:" "; map["/"]: "\n"; map[!unicode]:!unicode;
bg: {"\033[48;5;106m",x,"\033[m"}
showRow:{[board;row]: ,/(::;bg)[.q.mod[row+!8;2]]@'board[row]}
showFen:{(,"\033[2J"),showRow[unicode @/: board ]'!8} /

/
board:"\n"\:,/map fen;
`:fen.txt 0: showFen fen
fswatch -o fen.txt | xargs -n1 -I{} cat fen.txt
