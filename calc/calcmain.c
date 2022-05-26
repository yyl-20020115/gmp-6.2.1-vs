#include <string.h>
#include <stdio.h>
#include <gmp.h>

extern mpz_t  variable[26];
extern mpz_t    stack[100];

int calc_option_readline = -1;
#ifndef numberof
#define numberof(x)  (sizeof (x) / sizeof ((x)[0]))
#endif
int main(int argc, char* argv[])
{
    int  i = 0;

    for (i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--readline") == 0)
            calc_option_readline = 1;
        else if (strcmp(argv[i], "--noreadline") == 0)
            calc_option_readline = 0;
        else if (strcmp(argv[i], "--help") == 0)
        {
            printf("Usage: calc [--option]...\n");
            printf("  --readline    use readline\n");
            printf("  --noreadline  don't use readline\n");
            printf("  --help        this message\n");
            printf("Readline is only available when compiled in,\n");
            printf("and in that case it's the default on a tty.\n");
            exit(0);
        }
        else
        {
            fprintf(stderr, "Unrecognised option: %s\n", argv[i]);
            exit(1);
        }
    }

#if WITH_READLINE
    calc_init_readline();
#else
    if (calc_option_readline == 1)
    {
        fprintf(stderr, "Readline support not available\n");
        exit(1);
    }
#endif

    for (i = 0; i < numberof(variable); i++)
        mpz_init(variable[i]);

    for (i = 0; i < numberof(stack); i++)
        mpz_init(stack[i]);

    return yyparse();
}
