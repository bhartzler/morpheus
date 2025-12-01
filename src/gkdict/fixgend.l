
%%


"<gen>f.</gen>\t<gen>m."	printf("<gen>c.");
"<gen>m.</gen>\t<gen>f."	printf("<gen>c.");

%%
int main(int argc, char **argv) { return yylex(); }
int yywrap(void) { return 1; }
