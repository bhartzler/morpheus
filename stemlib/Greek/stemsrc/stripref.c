#include <stdio.h>
#include <string.h>

int main(void)
{
	char line[1000];
	char curlemma[BUFSIZ];
	char *s;

	while(fgets(line, sizeof(line), stdin)) {
		line[strcspn(line, "\n")] = 0;  /* strip newline */
		if( ! strncmp(":le:",line,4)) {
			strcpy(curlemma,line+4);
			continue;
		}
		printf("%s\t", curlemma );
		s = line+4;
		while(*s&&*s!='-') putchar(*s++);
		if(*s=='-') { putchar(' '); s++;}
		printf("%s\n", s );
	}
}

