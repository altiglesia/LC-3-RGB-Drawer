# LC-3-RGB-Drawer
Author: Avi Serebrenik
Created during March 2023
Base concept based on lab instructions by Professor Chris Murphy.


Hello!

This is a short program that allows you to draw in three colors (Red, Green, and Blue) using the LC-3 (Little Computer 3) and Assembly Language.
To run it, please follow this step by step setup guide. If you're already set up with LC-3, feel free to skip down to the "Instructions" section.
This program requires Java to run.

SETUP:
  1. Download the LC3Sim.jar file and the RGB.asm file.
  2. Put them in the same folder.
  3. In your terminal, navigate to this folder, and run "java -jar LC3Sim.jar" which should run the LC-3.
  4. In the LC-3, you should be able to type into a text box right below the "Next" button. Type "as RGB.asm" into this box and press enter. The box below it should say "Assembly of 'RGB.asm' was completed without errors or warnings." This will create the RGB.obj and RGB.sym files that are also here. You can theoretically just download the files here and skip this step, but I would recommend generating them yourself.
  5. Next, type in "ld RGB.obj" in the same box and press enter. The box below should tell you that the .obj and the .sym file were loaded.
  6. Now you are done and you can run the program by pressing the "Continue" button above the text box. You should see a red dot appear in the middle of the screen.
  7. To stop the program, simply quit the LC-3.


INSTRUCTIONS:
  You can move your drawing pointer around using the 'wasd' keys respectively.
  To change the color of your drawing pointer, press 'r' for red, 'g' for green, or 'b' for blue.
  To toggle drawing/moving mode, press 't'. (Moving over a drawn pixel in moving mode will erase that pixel's color)
  To clear the entire screen and reset, press 'c'.


Happy drawing!
