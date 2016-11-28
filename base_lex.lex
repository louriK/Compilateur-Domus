

%%
%class lexer
%unicode
%int
%standalone		//debug ou standalone
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
identificateur = [a-zA-Z0-9\_]+
annee = {chiffre}{chiffre}{chiffre}{chiffre}|\_
mois = {chiffre}{chiffre}|{chiffre}|\_
jour = {chiffre}{chiffre}|{chiffre}|\_
heure = {chiffre}{chiffre}|{chiffre}|\_
minutes = {chiffre}{chiffre}| {chiffre}|\_
date = ({annee},{mois},{jour},{heure},{minutes}) 
autre_appareil = tv|hifi|cafetiere|video_proj|lave_vaisselle|lave_linge|seche_linge|ordinateur|portail
appareil = eclairage|volet|chauffage|alarme|fenetre|autre\_appareil\({autre_appareil}\)
interface = interrupteur|mobile|telephone|telecommande|tablette
operateur = "=="|"<="|">="|"!=" | "||" | "&&"
fonction_etat = ouvrir|fermer|eteindre|allumer|tamiser|etat|allumer_partiel|allumer_eco|ouvrir_partiel|fermer_partiel
etat = eteint|demi|eco|ouvvert|ferme
espace = [\ \b\t]+
retour_ligne = \n
commentaire = \/\/ ~\n
texte = \" ~ \"
erreur_chaine = \"[^\"\n]*\n  

%%
// qqs exemples de règles lexicales légales...
{date}				{return new Symbol(sym.DATE,yytext());}
{appareil}			{return new Symbol(sym.APPAREIL, yytext());}
{interface}			{return new Symbol(sym.INTERFACE, yytext());}
{operateur}			{return new Symbol(sym.OPERATEUR, yytext());}
{fonction_etat}			{return new Symbol(sym.FONCTION_ETAT, yytext());}
{etat}				{return new Symbol(sym.ETAT, yytext());}
{espace} 			{}
{retour_ligne}			{}
{commentaire}			{}
{texte}				{ return new Symbol(sym.TEXTE, yytext());}

"<PROGRAMME_DOMUS>"	 	{return new Symbol(sym.DEBUT_DOMUS);}
"</PROGRAMME_DOMUS>"	 	{return new Symbol(sym.FIN_DOMUS);}
"<DECLARATION_APPAREILS>"	{return new Symbol(sym.DEBUT_APPAREIL);}
"</DECLARATION_APPAREILS>" 	{return new Symbol(sym.FIN_APPAREIL);}
"<DECLARATION_INTERFACES>" 	{return new Symbol(sym.DEBUT_INTERFACES);}
"</DECLARATION_INTERFACES>"	{return new Symbol(sym.FIN_INTERFACES);} 
"<DECLARATION_SCENARII>"	{return new Symbol(sym.DEBUT_SCENARII);}
"</DECLARATION_SCENARII>"	{return new Symbol(sym.FIN_SCENARII);}
"<DECLARATION_COMMANDES>" 	{return new Symbol(sym.DEBUT_COMMANDES);}
"</DECLARATION_COMMANDES>"	{return new Symbol(sym.FIN_COMMANDES); }
"<SCENARIO"			{return new Symbol(sym.DEBUT_SCENARIO);}
"</SCENARIO"			{return new Symbol(sym.FIN_SCENARIO);}
"<"				{return new Symbol(sym.INFERIEUR);}
">"				{return new Symbol(sym.SUPERIEUR);}
definir			 	{return new Symbol(sym.ENUM);}
executer_scenario	 	{return new Symbol(sym.EXECUTER_SCENARIO);}
associer		 	{return new Symbol(sym.ASSOCIER);}
programmer		 	{return new Symbol(sym.PROGRAMMER);}
message			 	{return new Symbol(sym.MESSAGE);}
pourtout		 	{return new Symbol(sym.POURTOUT);}
si			 	{return new Symbol(sym.SI);}
alors			 	{return new Symbol(sym.ALORS);}
sinon			 	{return new Symbol(sym.SINON);}
faire			 	{return new Symbol(sym.FAIRE);}
fait				{return new Symbol(sym.FAIT);}
fsi			 	{return new Symbol(sym.FINSI);}
","			 	{return new Symbol(sym.VIRGULE);}
"{"			 	{return new Symbol(sym.ACOUVRE);}	
"}"			 	{return new Symbol(sym.ACFERME);}		 
\"			 	{return new Symbol(sym.GUILLEMET);}
"="				{return new Symbol(sym.ASSIGNATION);}
":" 				{return new Symbol(sym.PARCOURS);}
"("				{return new Symbol(sym.PAROUVRE);}
")"				{return new Symbol(sym.PARFERME);}
"."				{return new Symbol(sym.POINT, yytext());}
";"				{return new Symbol(sym.POINT_VIRGULE, yytext());} 

{identificateur} 	 	{System.out.print("identificateur"); }

{erreur_chaine} {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => fin de chaine attendue ! "); }

.  {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => caractÃ¨re inconnu ! "); } 


