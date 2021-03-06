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

    //8 is "Choose Gamemode"
    else if( num == 8 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Gamemode.wav" );
    
    //9 is "Classic"
    else if( num == 9 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Classic.wav" );
    
    //10 is "Lights Out"
    else if( num == 10 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Lights_out.wav" );
    
    //11 is "Learn a Song"
    else if( num == 11 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Learn_a_song.wav" );
    
    //12 is "Record 20 Notes"
    else if( num == 12 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Record.wav" );
    
    //13 is "Choose Difficulty"
    else if( num == 13 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Difficulty.wav" );
    
    //14 is "Easy"
    else if( num == 14 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Easy.wav" );
    
    //15 is Medium
    else if( num == 15 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Medium.wav" );
    
    //16 is Hard
    else if( num == 16 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Hard.wav" );
    
    //17 is "Welcome"
    else if( num == 17 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Welcome.wav" );
    
    //18 is "Goodbye"
    else if( num == 18 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Goodbye.wav" );
   
    //19 is "Recording"
    else if( num == 19 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/recording.wav" );

    //20 is "Generating Song"
    else if( num == 20 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/generating.wav" );

    //21 is "Memorize Buttons to Sounds"
    else if( num == 21 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/Memorize.wav" );

    //22 is "Ready, Go!"
    else if( num == 22 )
        system( "aplay /home/pi/Documents/Programs/Prog2/sounds/ready.wav" );

    //23 is "Exit"
    else if( num == 23 )
      system( "aplay /home/pi/Documents/Programs/Prog2/sounds/exit.wav" );

    //return audio played
    return num;
}




//int_rand returns a random number between 1-5
int int_rand( int num )
{
    int x;
    srand(time(NULL));
    
    x = (rand() % num) + 1;
    printf( "Key: %d\n", x );
    return x;
}
