#include <stdio.h>
#include <stdlib.h>

int beep( int num )
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
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/E.wav" );
    else if( num == 7 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/E.wav" );

    return 0;
}
