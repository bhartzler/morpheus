

%%

"<itype>"[^<]+"</itype>\t<gen>"[^<]+"</gen>"	printf("%s\n", yytext );
"<gen>"[^<]+"</gen>"	printf("%s\n", yytext );

.	;
\n	;

%%
int main(int argc, char **argv) { return yylex(); }
int yywrap(void) { return 1; }
