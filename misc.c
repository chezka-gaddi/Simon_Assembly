#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int audio( int num )
{
    if( num == 1 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/A.wav" );
    else if( num == 2 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/B.wav" );
    else if( num == 3 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/C.wav" );
    else if( num == 4 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/D.wav" );
    else if( num == 5 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/E.wav" );
    else if( num == 6 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Cheer.wav" );
    else if( num == 7 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/boo.wav" );

    return 0;
}

int int_rand()
{
    int x;
    srand(time(NULL));
    
    x = (rand() % 5) + 1;
    printf( "Key: %d\n", x );
    return x;
}

void fail()
{
    printf( "Incorrect\n" );
    audio( 7 );
    exit(1);
}

void printArr( int *array[], int size )
{
    printf( "Array Contents: " );
    for( int i = 0; i < size; i++ )
        printf( "%d ", array[i]);
    printf( "\n" );
}
