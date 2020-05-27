

%{
#include <stdio.h>
#include "semantic.tab.h"
%}

%option noyywrap
%option yylineno

numero [0-9]
signo ["-"]
id [a-zA-Z_][a-zA-Z0-9_]*
ent [0-9]+
espacio [ \t\n]
caracter [a-zA-Z]
cadena {caracter}*

real ^(signo){numero}


%%

";" { 
        yylval.line = yylineno;
        return PYC;
    }
"," { 
        yylval.line = yylineno;
        return COMA;
    }

"estructura" {
        yylval.line = yylineno;
        return ESTRUCTURA;
    }


"def" {
        yylval.line = yylineno;
        return DEF;
    }




"escribir" {
        yylval.line = yylineno;
        return ESCRIBIR;
    }

"si"  { 
        yylval.line = yylineno;
        return SI;
    }

"devolver"  { 
        yylval.line = yylineno;
        return DEVOLVER;
    }

"sino"  { 
        yylval.line = yylineno;
        return SINO;
    }

"entonces" { 
        yylval.line = yylineno;
        return  ENTONCES;
    }

"mientras" {
        yylval.line = yylineno;
        return MIENTRAS;}

"terminar" { 
        yylval.line = yylineno;
        return TERMINAR;
    }
"fin" { 
        yylval.line = yylineno;
        return FIN;
    }

{id} {  
        yylval.line = yylineno;
        strcpy(yylval.sval, yytext);
        return ID;
    }

{cadena} {
            yylval.line = yylineno;
            yylval.nval = atoi(yytext);
            return CADENA;
        }

{caracter} {
            yylval.line = yylineno;
            yylval.nval = atoi(yytext);
            return CARACTER;
        }
    
{ent} {
            yylval.line = yylineno;
            yylval.nval = atoi(yytext);
            return NUM;
        }
    
{real} {
            yylval.line = yylineno;
            yylval.nval = atoi(yytext);
            return REAL;
        }


{car} {
            yylval.line = yylineno;
            yylval.nval = atoi(yytext);
            return CAR;
        }
{numero} {
            yylval.line = yylineno;
            yylval.nval = atoi(yytext);
            return NUMERO;
        }
"sin"{ 
            yylval.line = yylineno;
            return SIN;
        }
"leer" {
            yylval.line = yylineno;
            return LEER;
        }
"segun" {
            yylval.line = yylineno;
            return SEGUN;
        }
"hacer" {
            yylval.line = yylineno;
            return HACER;
        }
"caso" {
            yylval.line = yylineno;
            return CASO;
        }
"pred" {
            yylval.line = yylineno;
            return PRED;
        }



main { 
        yylval.line = yylineno;
        return MAIN;
    }


        

"{" { 
        yylval.line = yylineno;
        return LKEY;
    }

"}" {   
        yylval.line = yylineno;
        return RKEY;
    }

"=" {   
        yylval.line = yylineno;
        return ASIG;
    }

"o" { 
        yylval.line = yylineno;
        return O;
    }

"y" { 
        yylval.line = yylineno; 
        return Y; 
    }
"no" { 
        yylval.line = yylineno;
        return NO;
    }
"verdadero" { 
        yylval.line = yylineno;
        return VERDADERO;
    }
"falso" { 
        yylval.line = yylineno;
        return FALSO;
    }

"Y" { 
        yylval.line = yylineno; 
        return AND; 
    }

"==" {  
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return EQUAL;
    }
":=" {  
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return ASIGNA;
    }
    
"!=" {  
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return NE;
    }
    
">" {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return GT;
    }
    
"<" {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return LT;
">=" {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return GTI;
    }
":" {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return DPTU;
    }
"pred" {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return PRED;
    }
"." {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return PUNTO;
    }
    
"<=" {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return LTI;
    }
"<>" {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return DLT;
    }
    
"+" { 
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return ADD;}

"-" { 
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return SUB;}

"*" {   
        yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return MUL;}

"/" {   yylval.line = yylineno;
        strcpy(yylval.ssval, yytext);
        return DIV;}


")" { 
        yylval.line = yylineno;
        return  RPAR;
    }

"(" {
        yylval.line = yylineno;
        return LPAR;
    }
    
{espacio} {}

. { printf("ERROR: %s en la línea %d\n", yytext, yylineno);}

%%


