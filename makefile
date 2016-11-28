CUP        = java java_cup.Main
JFLEX      = java JFlex.Main 
JAVA       = java
JAVAC      = javac

all: JFLEX 

JFLEX: 
	java JFlex.Main base_lex.lex 

CUP: 
	java java_cup.Main -expect 28 projet.cup

compile:  
	javac Yylex.java sym.java parser.java

export:	
	java parser < projetTest > Bibliotheque.html

launch :
	firefox Bibliotheque.html
clean:
	rm -rf *.class
	rm -rf *.java

mrproper: clean
	rm -rf Bibliotheque.html 
	rm -rf *.j*
	
