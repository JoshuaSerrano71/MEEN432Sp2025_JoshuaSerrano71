# Project 2
## Part 1
Download [Project2_Part1.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project2/Part1/Project2_Part1.m) to view the Matlab code for Project 2 Part 1 <br>

This MATLAB script will plot the race track using only one set of x variables making it one continuous line that starts and ends at the origin. It also plots a patch, the car, moving around the track with xc, yc being the center point of the patch/car. The trail of the patch is also animated as a blue line based on the xc and yc values stated earlier. The script will run completely when 'Run' is hit and no other action is required. This was done by splitting the track into four separate sections, with the curved parts using parametric equations for a circle. The patch, or car, was plotted using a copy of the x and y values generated from the track since no other simulation was used for this portion of the project, but these values can easily be changed to an array that comes from a Simulink model.

TA Notes:
1. ReadME is sufficient.
2. Simulink needed(Week1 exempted but going forward for Week2 is necessary)
3. Implementation of Vd = R/Psi(dot) not visible. Do this before moving forward of implementing dynamics to code.


## Part 2
Download [project2.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project2/Part2/project2.slx) to view the Simulink file for updated project.

## Part 3
Download [MEEN432_Project2_Wk3.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project2/Part3/MEEN432_Project2_Wk3.slx) and [MEEN432_Project2_init.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project2/Part3/MEEN432_Project2_init.m). Open the Simulink file and then run the matlab code. (NOTE: This will clear your Workspace and Command Window)

This MATLAB script will plot the race track using only one set of x variables making it one continuous line that starts and ends at the origin. It also plots a patch, the car, moving around the track with xc, yc being the center point of the patch/car. The trail of the patch is also animated as a blue line based on the xc and yc values stated earlier. The script will run completely when 'Run' is hit while the simulink file is open. This was done by splitting the track into four separate sections, with the curved parts using parametric equations for a circle. The simulink model is based around the dynamics of the car and its tires while the "driver" predicts the required course based the car's positional relation to the centerline of the track (look-ahead technique). The patch, or car, was plotted using the simulink data of the car's position. The code will output the number of laps completed, the lap time for each lap and a plot of the track with animated car movements.
