chess.md: chess.q ../qnote
	../qnote chess.q | sed 's/q)//' | tail +4 > chess.md
	cp chess.md ../
fen.txt:
	fswatch -o fen.txt | xargs -n1 -I{} cat fen.txt
watch:
	fswatch -o chess.q| xargs -n1 -I{} make chess.md 
