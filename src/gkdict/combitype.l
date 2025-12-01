
%%

"</itype>"[ \t]+"<itype>"	printf(", ");

%%
int main(int argc, char **argv) { return yylex(); }
int yywrap(void) { return 1; }
