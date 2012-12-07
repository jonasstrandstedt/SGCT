SGCT
====

Se https://c-student.itn.liu.se/wiki/ för mer information om SGCT.

SGCT fungerar för windows (mingw 4.7.0), linux och mac.

    // Kompilera projektet
    $ make
	
	// kompilera med gtest (fungerar ej på windows än)
	$ make TEST=1
	
	// kompilera med ljud kräver viss handpåläggning med installation av openal, se c-student för mer info.
	$ make SOUND=1
	
För att köra programmet finns det en körfil som heter sgct_sim.sh. Windows kräver att msys finns med sh i path.

	// köra simulator (linux och mac)
	$ ./sgct_sim.sh
	
	// windows
	$ sh sgct_sim.sh
	
	// för att starta VR-simulator
	$ ./sgct_sim.sh VR
	
Feedback mottages tacksamt.