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
identificateur = [a-zA-Z0-9]+
annee = chiffre}{chiffre}{chiffre}{chiffre}|\_
mois = {chiffre}{chiffre}|{chiffre}|\_
jour = {chiffre}{chiffre}|{chiffre}|\_
heure = {chiffre}{chiffre}|{chiffre}|\_
minutes = {chiffre}{chiffre}| {chiffre}|\_
date = ({annee, mois, jour, heure, minutes) 
caractere = [a-zA-Z]
chaine_de_car = {caractere}+
autre_appareil = tv|hifi|cafetiere|video_proj|lave_vaisselle|lave_linge|seche_linge|ordinateur|portail
appareil = eclairage|volet|chauffage|alarme|fenetre|autre_appareil(tv)|autre_appareil({autre_appareil})
interface = interrupteur|mobile|telephone
condition = "=="|"<="|">="|"<>"
fonction_etat = \.ouvrir|\.fermer |\.eteindre|\.allumer|\.tamiser|\.etat|\.allumer_partiel|\.allumer_eco|\.ouvrir_partiel|\.fermer_partiel|
etat = eteint|demi|eco|ouvvert|ferme
espace = [\ \b\t]+
finligne = [.;]
retour_ligne = \n

erreur_ident = [0-9]+[a-zA-Z]+
erreur_chaine = \"[^\"\n]*\n  

%%
// qqs exemples de règles lexicales légales...
<PROGRAMME_DOMUS>	 { return new Symbol(sym.DEBUT_DOMUS); }
</PROGRAMME_DOMUS>	 { return new Symbol(return new Symbol(sym.FIN_DOMUS); }
<DECLARATION_APPAREILS>	 { return new Symbol(return new Symbol(sym.DEBUT_APPAREIL); }
</DECLARATION_APPAREILS> { return new Symbol(return new Symbol(sym.FIN_APPAREIL); }
<DECLARATION_INTERFACES> { return new Symbol(return new Symbol(sym.DEBUT_INTERFACES);}
</DECLARATION_INTERFACES>{ return new Symbol(return new Symbol(sym.FIN_INTERFACES);} 
<DECLARATION_SCENARII>	 { return new Symbol(sym.DEBUT_SCENARII); }
</DECLARATION_SCENARII>	 { return new Symbol(sym.FIN_SCENARII); }
<SCENARIO>		 { return new Symbol(sym.DEBUT_SCENARIO); }
</SCENARIO>		 { return new Symbol(sym.FIN_SCENARIO); }
<DECLARATIONS_COMMANDES> { return new Symbol(sym.DEBUT_COMMANDES); }
</DECLARATIONS_COMMANDES>{ return new Symbol(sym.FIN_COMMANDES); }
definir			 { return new Symbol(sym.ENUM);}
exectuer_scenario	 { return new Symbol(sym.EXECUTER_SCENARIO);}
associer		 { return new Symbol(sym.ASSOCIER);}
programmer		 { return new Symbol(sym.PROGRAMMER);}
message			 { return new Symbol(sym.MESSAGE);}
pourtout		 { return new Symbol(sym.POURTOUT);}
si			 { return new Symbol(sym.SI);}
alors			 { return new Symbol(sym.ALORS);}
sinon			 { return new Symbol(sym.SINON);}
fsi			 { return new Symbol(sym.FINSI);}
","			 { return new Symbol(sym.VIRGULE);}
"{"			 { return new Symbol(sym.ACOUVRE);}	
"}"			 { return new Symbol(sym.ACFERME);}		 
\"			 { return new Symbol(sym.GUILLEMET);}

{entier} 		 { return new Symbol(sym.ENTIER, new Integer(yytext())); }
{identificateur} 	 { return new Symbol(sym.IDENTIFICATEUR, yytext()); }
{date}			 { return new Symbol(sym.DATE,yytext());}
{appareil}		 { return new Symbol(sym.APPAREIL, yytext());}
{interface}		 { return new Symbol(sym.INTERFACE, yytext());}
{condition}		 { return new Symbol(sym.CONDITION, yytext());}
{fonction_etat}		 { return new Symbol(sym.FONCTION_ETAT, yytext());}
{etat}			 { return new Symbol(sym.ETAT, yytext());}
{espace} 		 {}
{finligne} 		 { return new Symbol(sym.FINLIGNE);} 
{retour_ligne}		 {}

// qqs exemples de règles de détection d'erreurs lexicales...
{erreur_ident} {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => syntaxe identificateur non respectee ! "); }

{erreur_chaine} {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => fin de chaine attendue ! "); }

.  {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => caractÃ¨re inconnu ! "); } 


