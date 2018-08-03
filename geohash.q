core: {[lrib]
    ; x: lrib 0; bs: lrib 1
    ; bs ,: enlist b:  `int$ x[2] >=  m: 0.5 * x[0] + x[1]
    ; x[0]: b'[x[0];m]
    ; x[1]: b'[m;x[1]]
    ; (x; bs)  
    }

base32: {"0123456789bcdefghjkmnpqrstuvwxyz"  sum 16 8 4 2 1 * x} 

encode: {[lat; lon; precision]
    ; n: 2* count lat
    ; lrib: ((n#-180f; n#180f ; lon,2*lat); ())
    ; loop: ceiling precision*2.5
    ; x: loop core/ lrib
    ; bits: (5*precision) #/:(0N; 2*loop)#raze flip raze each (2; 0N)#flip x 1
    ; (base32 each) each (0N; 5)#/:bits   
    }
/latitude: -90 ~ 90, longitude: -180 ~ 180
lat: 42.605 20 10f 
lon: -5.539 -75 -10f
precision: 5 /number of chars in result
g: 10000000 /0.1billian
show lat: -90+g?180f
show lon: -180+g?360f
\t encode[lat; lon; precision]
/3.5s / million 
