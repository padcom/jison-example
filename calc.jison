%lex

number               [0-9]+("."[0-9]+)?\b
id                   [a-z][a-z0-9]*

%%

\n                    /* skip new lines */
\s+                   /* skip whitespace */
{number}              return 'NUMBER';
{id}                  return 'VAR';
"*"                   return '*';
"/"                   return '/';
"-"                   return '-';
"+"                   return '+';
"^"                   return '^';
"("                   return '(';
")"                   return ')';
"="                   return '=';
";"                   return 'SEMICOLON';
//<<EOF>>               return 'EOF';

/lex

%right '='
%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS

%start input

%%

input
    :
    | input line
        { return $2 }
    ;

line
    : exp SEMICOLON line
        { $$ = [ $1, $3 ]; }
    | exp SEMICOLON
        { $$ = [ $1 ]; }
    ;

exp
    : NUMBER
        { $$ = { type: 'NUMBER', body: Number(yytext) }; }
    | VAR
        { $$ = { type: 'VARIABLE', body: yytext }; }
    | VAR '=' exp
        { $$ = { type: 'ASSIGNMENT', variable: $1, body: $3 }; }
    | exp '+' exp
        { $$ = { type: 'PLUS', body: [ $1, $3 ] }; }
    | exp '-' exp
        { $$ = { type: 'MINUS', body: [ $1, $3 ] }; }
    | exp '*' exp
        { $$ = { type: 'MUL', body: [ $1, $3 ] }; }
    | exp '/' exp
        { $$ = { type: 'DIV', body: [ $1, $3 ] }; }
    | '-' exp %prec UMINUS
        { $$ = { type: 'NEGATIVE', body: $2 }; }
    | '(' exp ')'
        { $$ = { type: 'PARENTS', body: $2 }; }
    ;
