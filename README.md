# SGCT
Simple Graphics Cluster Toolkit (SGCT) är som namnet antyder ett bibliotek för hantera datorgrafik i nätverkskluster, det fungerar även ypperligt att använda för applikationer med en nod. Se https://c-student.itn.liu.se/wiki/ för mer information om SGCT.

## Installation
#### Windows
På windows krävs [MinGW 4.7.0](https://c-student.itn.liu.se/wiki/_media/develop:mingw_4.7.0.zip) och [MSYS](http://www.mingw.org/wiki/MSYS) (båda i windows PATH). Kör sedan "make install-windows" för att installera nödvändiga dll filer.
För att "make install-windows" ska fungera krävs det att kommandotolken är startad med administratörsrättigheter. Högerklicka på länken till cmd.exe och välj "Kör som administratör". 

	// windows från en kommandotolk som är startad med administratörsrättigheter
	$ make install-windows

Föredrar du manuell installation är det bara att kopiera sgct_0_9_5/win_mingw32_alut/*.dll till C:/Windows/system32/.

#### Mac OSX
Kör "make install-macosx". 

	// mac
	$ make install-macosx

Sciptet kopierar sgct_0_9_5/mac_alut/ALUT.framework och sgct_0_9_5/mac_alut/ALUT.framework.dSYM/ till /System/Library/Frameworks/. 

#### Ubuntu
Kör "make install-ubuntu".
	
	// ubuntu
	$ make install-ubuntu

Scriptet kör "sudo apt-get install libalut0 libalut-dev".

## Använda byggsystemet

Kommandon som Makefilen stödjer är följande

	// lista tillgängliga kommandon
	$ make help 

    // Kompilera projektet, eller kompilera om de .cpp filer som ändrats (kompilerar ej de som ej ändrats)
    $ make
	
	// kompilera med gtest
	$ make TEST=1
	
	// kompilera med ljud kräver viss handpåläggning med installation av openal, se c-student för mer info.
	$ make SOUND=1
	
	// ta bort objektfilerna från src och UnitTestSrc
	$ make clean
	
	// ta bort alla objektfiler från src och UnitTestSrc samt gtest objektfiler samt binärer
	$ make clean-all
	
## Köra programmet

SGCT använder konfigurationsfiler för att sätta upp viewporten, därför måste en flagga med sökvägen till konfigurationsfilen användas vid start av programmet. För att förenkla används sgct_sim scriptet. Windows kräver att MSYS är installerat och finns i PATH.

	// Exempel utan skriptet (linux och mac)
	$ ./Program -config data/sgct_config/single.xml
	
	// köra simulator (linux och mac)
	$ ./sgct_sim.sh
	
	// windows
	$ sh sgct_sim.sh
	
	// för att starta VR-simulator (en master och 3st slavar)
	$ ./sgct_sim.sh VR
	
## Utöka och förändra för egna projekt
Det som behöver ändras i Makefilen är att definera de object (kompilerade .cpp filer) som ska ingå. Det görs genom att utöka eller byta ut

	// Första raden är med ?= då det går att kompilera temporära object med 'make OBJECTS="src/Fil.o src/AnnanFil.o"'
	OBJECTS ?= src/main.o 
	OBJECTs += src/MyEngine.o
	OBJECTS += src/MySound.o
	
För att lägga till extra bibliotek (exempelvis openmp), ändra CXXFLAGS och FLAGS. Läs mer om gcc och bibliotek på:
https://www.google.com/
http://gcc.gnu.org/onlinedocs/gcc/
http://gcc.gnu.org/onlinedocs/gcc/Link-Options.html

	// Kompilera alla objekt med OpenMP
	CXXFLAGS = -fopenmp
	
	// Flagga endast vid länkning (bibliotek etc)
	FLAGS += -lnameoflibrary
	
	
