

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
point = [.]
point_virgule = [;]
retour_ligne = \n
commentaire = \/\/ ~\n
texte = \" ~ \"
erreur_chaine = \"[^\"\n]*\n  

%%
// qqs exemples de règles lexicales légales...
{date}				{ System.out.print("date");}
{appareil}			{ System.out.print("appareil");}
{interface}			{ System.out.print("interface");}
{operateur}			{ System.out.print("operateur");}
{fonction_etat}			{ System.out.print("fonction_etat");}
{etat}				{ System.out.print("etat");}
{espace} 			{ System.out.print(yytext());}
{point} 			{ System.out.print(yytext());}
{point_virgule} 		{ System.out.print(yytext());} 
{retour_ligne}			{ System.out.print("\n");}
{commentaire}			{ System.out.println("// commentaire");}
{texte}				{ System.out.print("texte");}

"<PROGRAMME_DOMUS>"	 	{ System.out.print("<PROGRAMME_DOMUS>"); }
"</PROGRAMME_DOMUS>"	 	{ System.out.print("</PROGRAMME_DOMUS>"); }
"<DECLARATION_APPAREILS>"	{ System.out.print("<DECLARATION_APPAREILS>"); }
"</DECLARATION_APPAREILS>" 	{ System.out.print("</DECLARATION_APPAREILS>"); }
"<DECLARATION_INTERFACES>" 	{ System.out.print("<DECLARATION_INTERFACES>");}
"</DECLARATION_INTERFACES>"	{ System.out.print("</DECLARATION_INTERFACES>");} 
"<DECLARATION_SCENARII>"	{ System.out.print("<DECLARATION_SCENARII>"); }
"</DECLARATION_SCENARII>"	{ System.out.print("</DECLARATION_SCENARII>"); }
"<DECLARATION_COMMANDES>" 	{ System.out.print("<DECLARATION_COMMANDES>"); }
"</DECLARATION_COMMANDES>"	{ System.out.print("</DECLARATION_COMMANDES>"); }
"<SCENARIO"			{ System.out.print("<SCENARIO");}
"</SCENARIO"			{ System.out.print("</SCENARIO");}
"<"				{ System.out.print("<");}
">"				{ System.out.print(">");}
definir			 	{ System.out.print("definir");}
executer_scenario	 	{ System.out.print("executer_scenario");}
associer		 	{ System.out.print("associer");}
programmer		 	{ System.out.print("programmer");}
message			 	{ System.out.print("message");}
pourtout		 	{ System.out.print("pourtout");}
si			 	{ System.out.print("si");}
alors			 	{ System.out.print("alors");}
sinon			 	{ System.out.print("sinon");}
faire			 	{ System.out.print("faire");}
fait				{ System.out.print("fait");}
fsi			 	{ System.out.print("fsi");}
","			 	{ System.out.print(",");}
"{"			 	{ System.out.print("{");}	
"}"			 	{ System.out.print("}");}		 
\"			 	{ System.out.print("guillemet");}
"="				{ System.out.print("=");}
":" 				{ System.out.print(":");}
"("				{ System.out.print("(");}
")"				{ System.out.print(")");}

{identificateur} 	 	{ System.out.print("identificateur"); }

{erreur_chaine} {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => fin de chaine attendue ! "); }

.  {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+yytext()+" => caractÃ¨re inconnu ! "); } 


