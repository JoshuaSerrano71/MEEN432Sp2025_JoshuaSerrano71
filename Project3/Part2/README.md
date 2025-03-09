# Project	3	Week	2	Submission
##  Electric Vehicle powertrain model and integrate with the longitudinal vehicle dynamics

The following code takes Dynamometer data from the epa.gov website under their fuel and emissions testing section for Urban driving. This model is simpler, without tire slip, and consists of wheels and chassis. The model starts by reading the velocity data from the EPA table and converting it from miles per hour to meters per second. It then goes through a PID controller that takes in the desired velocity from the EPA data and compares it to the current velocity of the car. A throttle and brake percentage command is calculated from the output of the PID controller block. These values then go to the power train and brake systems to calculate wheel torque and inertia and force the brakes to create. This is then put into the wheel subsystem and finally through the longitudinal subsystem to output acceleration, velocity, and position of the car. <br>

This code expands upon Part 1 code by incorporating an electric motor into the simulation, along with a single-speed transmission and unlimited battery power to calculate the energy efficiency.


```markdown
Download Instructions
```
CHANGE THIS
Download the Simulink model [MEEN432_Project3_start.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part1/MEEN432_Project3_start.slx) and Matlab code [Project3_init.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project3/Part1/Project3_init.m) <br>

```markdown
Download Instructions for EPA data from Project 3 Week 1 README.md
```

The following Matlab code contains velocity dynamometer values from the EPA for Urban Driving: <br>
Urban EPA Data: [init_urban_epa.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part1/init_urban_epa.m) <br>
Urban EPA Data (2 cycles): [init_urban_epa_2cycle.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part1/init_urban_epa_2cycle.m) <br>

The following Matlab code contains velocity dynamometer values from the EPA for Highway Driving: <br>
Highway EPA Data: [init_highway.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project3/Part1/init_highway_epa.m) <br>

Once the Simulink model and desired EPA files from Week 1 files are downloaded, place them into the same folder and open the folder's directory in Matlab. The Project 3 init script is set to run the urban EPA cycle but this can be changed by running the desired EPA script first and changing the variable values in the MODEL INIT section of the script. <br>

```markdown
Input Variables
```
Project3_Week1.m uses the following default values: <br>
r = 0.3  ------- Radius of wheels in m <br> 
m = 1000 ---- Mass of car in kg <br>
I = 1600 ------ Inertia for the car in kg-m^2 <br>
I_w = 0  ------- Inertia for the wheel in kg-m^2 <br>
F_drag = 0   --- Drag force in N <br>

Either EPA data can be used for [Project3_init.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project3/Part1/Project3_init.m) initial conditions:
- Urban EPA Dynamometer Data
- Highway EPA Dynamometer Data
- Urban EPA Dynamometer Data (2 cycles)

```markdown
Output Plot
```
Urban EPA Data: Simulated Vehicle Velocity vs Time

