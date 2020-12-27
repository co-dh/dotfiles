
/ 
Show:{-1@,/unicode 72#,/map x;}
Show fen:"5b2/p3n2r/3R2pp/k1p1Bp2/2B1p3/1P6/P1P2PPP/2K5"
\


/
8 color
Color:`Black`Red`Green`Yellow`Blue`Magenta`Cyan`White!$(!8)
fg: {"\033[3",Color[x],"m",y,"\033[m"}  
bg: {"\033[4",Color[x],"m",y,"\033[m"}
 ;-1 fg[`Red; "hello"]
 ;-1 bg[`White; "hello"]
\
