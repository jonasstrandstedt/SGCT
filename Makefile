OS = $(shell uname -s)
CC = g++
MV = mv
CP = cp
RM = rm
MESSAGE =

#specify dependency list for all .cpp files
OBJECTS ?= src/main.o src/MyEngine.o
OUTPUT ?= Program
FLAGS ?=
CXXFLAGS ?= 
INCPATH ?= -isystem"sgct_0_9_5/include"

# Specify what needs to be includes
OPENGL=1
#SOUND=1
#TEST=1
#RELEASE=1

# check if argument OPENGL=1 is set, reguires glfw to be properly installed
ifdef OPENGL
	MESSAGE += OpenGL,
	ifeq ($(OS),Linux)
		FLAGS += -lsgct -lGL -lGLU -lX11 -lXrandr -static-libgcc -static-libstdc++ -L"sgct_0_9_5/linux_lib"
	else ifeq ($(OS),Darwin)
		FLAGS += -framework Cocoa -framework OpenGL -lglfw -lsgct -L"sgct_0_9_5/mac_lib"
	else ifeq ($(OS),MINGW32_NT-6.1)
		OUTPUT = Program.exe
		FLAGS += -L"sgct_0_9_5/win_mingw32_lib" -lsgct32 -lopengl32 -lglu32 -lws2_32 -static-libgcc -static-libstdc++
	endif
endif

# check if argument TEST=1 is set, reguires googletest
ifdef TEST
	MESSAGE += Test,
	OBJECTS += src/UnitTestSrc/UnitTests.o
	# includes necessary .h files and defines
	INCPATH += -isystem"src/UnitTestSrc" -D"_TEST_" -isystem"googletest"
	CXXFLAGS += -pedantic -Wall -Wshadow -Wextra -O2
	ifeq ($(OS),Linux)
		FLAGS += -lgtest -L"googletest/lib/linux_lib"
	else ifeq ($(OS),Darwin)
		FLAGS += -lgtest -L"googletest/lib/mac_lib"
	else ifeq ($(OS),MINGW32_NT-6.1)
		# TODO: compile gtest on windows
		FLAGS += 
	endif
endif

# check if argument SOUND=1 is set
ifdef SOUND
	MESSAGE += Sound,
	ifeq ($(OS),Linux)
		FLAGS += -lalut
	else ifeq ($(OS),Darwin)
		FLAGS += -framework ALUT -framework OpenAL
	else ifeq ($(OS),MINGW32_NT-6.1)
		FLAGS += -lalut
	endif
else
	# Adding a define so the source files knows if built with or without sound
	INCPATH += -D"_NOSOUND_"
endif

# check if argument RELEASE=1 is set (and not TEST)
ifndef TEST
	ifdef RELEASE
		MESSAGE += Release,
		CXXFLAGS += -O3
	else
		MESSAGE += Debug,
		CXXFLAGS += -g

	endif
endif

all: $(OBJECTS)
	-@echo "Linking for $(OS)"
	-@echo "Including $(MESSAGE)"
	-@echo " "
	$(CC) -o $(OUTPUT) $(OBJECTS) $(INCPATH) $(CXXFLAGS) $(FLAGS) 

clean:
	-@echo "Cleaning"
	-$(RM) src/*.o
	-$(RM) src/UnitTestSrc/*.o

# pattern that compiles all .o files
%.o: %.cpp
	$(CC) $(CXXFLAGS) $(INCPATH) -c $< -o $@


