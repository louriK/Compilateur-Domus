// Specification JFlex
import java_cup.runtime.Symbol;

%%
%unicode
%cup
%line
%column

%{
	public int getYyLine(){
		return yyline+1;
	}
	public int getYyColumn(){
		return yycolumn+1;
	}
	public String getYyText(){
		return yytext();
	}
%}

// qqs exemples de macros...
chiffre = [0-9]
entier = {chiffre}+

erreur_ident = [0-9]+[a-zA-Z]+
erreur_chaine = \"[^\"\n]*\n  

%%
// qqs exemples de règles lexicales légales...
{entier} { return new Symbol(sym.ENTIER, new Integer(yytext())); }
{ident} { return new Symbol(sym.IDENT, yytext()); }
{espace} {}
{finligne} {} 

// qqs exemples de règles de détection d'erreurs lexicales...
{erreur_ident} {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => syntaxe identificateur non respectee ! "); }

{erreur_chaine} {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => fin de chaine attendue ! "); }

.  {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => caractÃ¨re inconnu ! "); } 


