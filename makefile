CUP        = java java_cup.Main
JFLEX      = java JFlex.Main 
JAVA       = java
JAVAC      = javac

all: JFLEX CUP compile export

JFLEX: 
	java JFlex.Main base_lex.lex 

CUP: 
	java java_cup.Main -expect 44 base_cup.cup

compile:  
	javac Yylex.java sym.java parser.java

export:	
	java parser < exemple_projet_domus.txt


clean:
	rm -rf *.class
	rm -rf *.java

mrproper: clean
	rm -rf Bibliotheque.html 
	rm -rf *.j*
	
