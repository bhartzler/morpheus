
%%

"&"[aeiou]"macr;"	printf("%c_", yytext[1] );
"&euml;"	printf("e+");
"&uuml;"	printf("u+");
"&iuml;"	printf("i+");

%%
int main(int argc, char **argv) { return yylex(); }
int yywrap(void) { return 1; }
