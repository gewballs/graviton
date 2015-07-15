# graviton
![alt tag](https://raw.githubusercontent.com/gewballs/graviton/master/pictures/graviton_gibs.jpg)


SNES Graviton

This is a small project to demonstrate how a SNES game works.
Also this project is trying to get people involved with game
development, even if they don't know how they can contribute.

The code is written in 65816 assembler, and assembled by a
custom assembler (very useful, but very old and clunky, so I
am not making it available), and data is stored in various
binary files.  The file types are as follows:

*.asm // Assembly text file

*.pal // Palette    binary file, ie colors

*.chr // Character  binary file, ie tiles

*.nmt // Name table binary file, ie tile map

Everything flows from main.asm, so to read the program, begin
there.

Assembler statments begin with a semi-colon ;.  Statments come
in three varieties, assembly, label, and directive.

The easiest to understand are assembly statments, as defined
by the 65916 architecture

Sometimes you see non-standard {+End} or {-} as operands.  By
themselves, they form label declarations. As operands they are
references to labels.  They can be any name, and optionally
may have + or - prefix to force search in on direction.

Assembler directives give the assembler special instructions
to ease programming.  Directives start with a hash #.

\#LoROM    // This defines how to map ROM to CPU addresses

\#Name     // Names define constants

\#Code     // Uses the value of the current PC as code address

\#Data     // Data is defined between braces { }.  A name with
          // a hash # prefix will insert that binary data file
          
\#File     // Include a text file

\# Comment // A Hash followed by whitespace is a comment

More to come
