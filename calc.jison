%lex

%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER';
"*"                   return '*';
"/"                   return '/';
"-"                   return '-';
"+"                   return '+';
"^"                   return '^';
"("                   return '(';
")"                   return ')';
"PI"                  return 'PI';
"E"                   return 'E';
<<EOF>>               return 'EOF';

/lex

%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS

%start expressions

%%

expressions
  : exp EOF
    { return $1; }
  ;

exp
  : exp '+' exp
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
  | NUMBER
    { $$ = { type: 'NUMBER', body: Number(yytext) }; }
  | PI
    { $$ = '3.14'; }
  ;
