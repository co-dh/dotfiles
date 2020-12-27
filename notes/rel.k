 / Relational mathematics in shakti. Relations are represented as Boolean Matrix.
com:{x:|/'y@&:'x; c:#:'x; w:&0=c; @[x;w;:;(#w)#,(|/c)#0b]}; 
lres:{~com[+x;~y]}; Syq:{lres[x;y]&lres[~x;~y]}; Id:{x^(x*x) #1b,x#0b};  univ:{|/|/~com[+x;x]>Id@#x}; 
univ:{&/2>+/'x}; inj:{univ@+x}; tot:{&/|/'x}; surj:{tot@+x}; mapping:{tot[x]&univ[x]}; bij:{inj[x]&surj[x]}; 
Top:{x#,y#1b};  bot:{x#,y#0b}; Vec:{&/=/'x}; reflexive: {&/x ./: i,'i:!#x}; dom:{com[x; Top[#*x;#*x]]}; cod:{dom@+x}
same:{com[x;+x]};

/
 left residul: columns of x contains in columns of y
 lres0:{&/''~(+x)>/:\:+y}; 
 x:(0000000000001b;0100000100000b; 0010001101010b;0110000100001b;0001001001101b)
 y:(000101110100b; 100100100100b; 110011010001b;110000101011b;000101110000b)
 lres[x;y]~lres0[x;y]
 x:(111bb;0100b;1111b;0101b)
 com2:{y (?,/@)/:x};/dictinary composition, very slow, can't finish 10kX10k

 randm: {x[0]#,`boolean$x[1]?2}
 x:randm 10000 10000
 y:randm 10000 10000
\t com[x;y]

 com0:{x (|/&)/:\: +y}; /naive. In Shakti, it 2 times slower than com, in Q 4, 6 times slower. Also shakti treat |/() to correct 1...111b
 \t com0[x;y]

 x: randm 10 10
 y: randm 10 10
 com[x;y]

