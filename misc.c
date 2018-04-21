#include <stdlib.h>
#include <stdio.h>
#include <time.h>


//audio function allows the program to pass in an integer (1-5 are buttons)
//using this int it determines which audio flile to play and plays it
int audio( int num )
{
	//1 is the blue button 
    if( num == 1 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/A.wav" );
	
    //2 is the red button
    else if( num == 2 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/B.wav" );
	
    //3 is the yellow button
    else if( num == 3 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/C.wav" );
	
    //4 is the orange button
    else if( num == 4 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/D.wav" );
	
    //5 is the green button
    else if( num == 5 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/E.wav" );
	
    //6 is used as the cheers sound (winning the game)
    else if( num == 6 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Cheer.wav" );
	
    //7 is used as the booing sound (failing at the game)
    else if( num == 7 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/boo.wav" );

    else if( num == 8 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Gamemode.wav" );
    
    else if( num == 9 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Classic.wav" );
    
    else if( num == 10 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Lights_out.wav" );
    
    else if( num == 11 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Learn_a_song.wav" );
    
    else if( num == 12 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Record.wav" );
    
    else if( num == 13 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Difficulty.wav" );
    
    else if( num == 14 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Easy.wav" );
    
    else if( num == 15 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Medium.wav" );
    
    else if( num == 16 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Hard.wav" );
    
    else if( num == 17 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Welcome.wav" );
    
    else if( num == 18 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Goodbye.wav" );
    
    return num;
}


void printArr( int *arr[], int size )
{
    printf( "Array Contents: " );
    for( int i = 0; i < size; i++ )
        printf( "%d ", arr[i] );
    printf( "\n" );
}



//int_rand returns a random number between 1-5
int int_rand( int num )
{
    printf( "Button #: %d\n", num );
    int x;
    srand(time(NULL));
    
    x = (rand() % num) + 1;
    printf( "Key: %d\n", x );
    return x;
}



//fail calls audio with the booing noice and exits the program
void fail()
{
    printf( "Incorrect\n" );
    audio( 7 );
    exit(1);
}



int* read(  int diff )
{
    int array[18] = { 1, 2, 3, 1, 2, 3, 1, 1, 1, 1, 2, 2, 2, 2, 1, 2, 3 };
    return *array;     
}
