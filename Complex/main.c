#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "testMultimixer156.h"

#define MEASURE_PERF

#if defined(EMBEDDED)

void assert(int condition)
{
    if (!condition)
    {
        for ( ; ; ) ;
    }
}
#endif


int Multimixer( void )
{
    #if !defined(EMBEDDED)
        testMultimixer156();
    #endif

    #if defined(EMBEDDED)

    for (;;);

    #else

    return ( 0 );

    #endif
}



int process(int argc, char* argv[])
{
    Multimixer();
    return 0;
}

int main(int argc, char* argv[])
{
    return process(argc, argv);
}
