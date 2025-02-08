# Project 1
## Part 1

Before downloading the files above please ensure there are no files of the same name in the folder <br>
Open [Project1_Part1.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part1/Project1_Part1.m) and [Project1_shaft.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Project1_shaft.slx) to view the Matlab code for Part 1

The Project1_Part1.m file uses the following default values and can be modified by the user:
- const_torque = 1    Torque input in Nm
- J = 1               Inertia in kg m^2
- b = 1               Damping Coefficient in Nm/(rad/s)
- tout = 25           Simulink simulation stop time in seconds
- dt = [1 0.1 0.001]  Time step values in seconds

Project1_Part1.m initial conditions:
- omega0 = 0         Initial Angular Velocity in rad/s
- theta0 = 0         Intial Postion in rad

Project1_Part1.m outputs three graphs:
- Max Simulation Time vs. Time Step
- CPU Time vs. Time Step
- Max Simulation Time vs. CPU Time
  
Here is an example of what the output should look like
[Project1_Part1_plots.pdf](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part1/Project1_Part1_Plots.pdf)

## Part 2
![*Figure 2: S1 and S2 model representation from Project 1 Part 2*](./Project1/Part2/Examples/Project1_Part2_System.png) <br>
![Alt text](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Examples/Project1_Part2_System.png) 

Open [Project1_Part2.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Project1_Part2.m) for the base code. <br>

Open Simulink models for each Option: <br>
For Option 1 open [Project1_Part2_Op1.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Project1_Part2_Op1.slx) <br>
For Option 2 open [Project1_Part2_Op2.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Project1_Part2_Op2.slx) <br>
For Option 3 open [Project1_Part2_Op3.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Project1_Part2_Op3.slx) <br>

Once all Part 2 files downloaded (4 files) place them into the same folder and open the folder's directory in Matlab. <br>
The following variables can be modified:






