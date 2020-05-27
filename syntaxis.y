%{
#include <stdio.h>
#include "symbols.h"

extern FILE *yyin;
extern int yylex();
void yyerror(char *s);


int dir;
int temporales;
int etiquetas;
int siginst;


%}

%union{
    char sval[32];
    int line;
}

%token <sval> ID
%token NUM
%token REAL
%token SIN
%token CAR
%token CADENA
%token CARACTER
%token MAIN 
%token SI ENTONCES FIN
%token PYC
%token NUMERO
%token COMA
%token SEGUN
%token LKEY RKEY
%token LEER
%token DEVOLVER
%token HACER
%token SINO
%token MIENTRAS
%token TERMINAR
%token PRED
%token CASO
%token VERDADERO
%token FALSO
%token DPTU





%left ASIG
%left O
%left Y
%left NO
%left EQUAL NE
%left GT LT GTI LTI  DLT
%left ADD SUB
%left MUL DIV
%nonassoc RPAR LPAR
%left IFX
%left ELSE



%start program

%%

program : {init();} 
          decl function {
            print_table();            
         };



decl: tipo  lista_var PYC
		| tipo_registro lista_var {
            if(existe($2)==-1){                
                symbol sym;
                strcpy(sym.id, $2);
                sym.dir = dir;
                sym.type = 1;
                sym.var = 0;
                insert(sym);
                dir+= 4;
            }else{
                yyerror("Identificador duplicado");
            }
    } decl | ;

function: DEF tipo  ID  RPAR argumentos RKEY INICIO declara sents FIN ;

declara: tipo lista_var PYC delacara
		| tipo_registro lista_var PYC decl;

tipo_registro: ESTRUCTURA INICIO decl FIN ;

tipo: base tipo_arreglo;
base: NUM
	| REAL
	| CAR 
	| SIN
	;
tipo_arreglo: RPAR NUMERO LPAR tipo_arreglo
argumentos: listar_arg
		| SIN
		;
lista_var : ID lista_varP;
lista_varP : COMA lista_varP;

lista_arg: arg lista_argP;
lista_argP: COMA lista_argP;

arg: tipo_arg ID;

tipo_arg: base param_arr;
param_arr : LPAR RPAR param_arr;

        

sents: sents sent | sent ;

sent:     SI cond ENTONCES sent FIN
        | SI cond ENTONCES sent SINO sent FIN
        | MIENTRAS cond  HACER sent FIN
        | HACER sent MIENTRAS cond  PYC
        | SEGUN LPAR var  RPAR HACER casos prede FIN
        | var ASIGNA expre  PYC
        | ESCRIBIR expre PYC
        | LEER var PYC | DEVOLVER
        | TERMINAR PYC
        | INICIO sent FIN ;

 casos: CASO NUMERO DPTU sent casos 
 		| CASO NUMERO DPTU sent
 		;

 prede : PRED DPTU sent;



exp :  exp ADD exp 
        | exp SUB exp
        | exp MUL exp
        | exp DIV exp
        | NUM 
        | ID
        | LPAR exp RPAR
        ;

 rel : EQUAL 
        | NE
        | GT
        | LT
        | DLT
        | LTI
        | GTI
        ;
     
 cond :  cond O cond
        | cond Y cond
        | NO cond 
        | exp rel exp
        | VERDADERO
        | FALSO 
        ;   

var : ID variable_comp;
variable_comp: dato_est_sim 
			|arreglo 
			|LPAR exp RPAR
			;
dato_est_sim : dato_est_simP;
dato_est_simP : id PUNTO dato_est_simP;
arreglo: LPAR exp RPAR 
		| arreglo LPAR exp RPAR 
		;
parametros : lista_param;
lista_param: exp lista_paramP;
lista_paramP: COMA exp lista_paramP;




 %%

void yyerror(char* s){
    printf("ERROR:%s, en  la linea %d\n",s, yylval.line);
}



void init(){
    dir = 0;
    temporales = 0;
    etiquetas = 0;
    init_table();
}

int existe(char *id){
    return search(id);
}

int main(int argc, char** argv){
    if(argc>1){
        yyin = fopen(argv[1], "r");
        if(!yyin) return 1;
        yyparse();
        fclose(yyin);
    }
}