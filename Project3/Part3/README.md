# Project	3	Week 3	Submission
##  Electric Vehicle powertrain model and consumed energy

The following code takes Dynamometer data from the epa.gov website under their fuel and emissions testing section for Urban driving. This model is simpler, without tire slip, and consists of wheels and chassis. The model starts by reading the velocity data from the EPA table and converting it from miles per hour to meters per second. It then goes through a PID controller that takes in the desired velocity from the EPA data and compares it to the current velocity of the car. A throttle and brake percentage command is calculated from the output of the PID controller block. These values then go to the power train and brake systems to calculate wheel torque and inertia and force the brakes to create. This is then put into the wheel subsystem and finally through the longitudinal subsystem to output acceleration, velocity, and position of the car. <br>

This code expands upon the Part 1 code by incorporating an electric motor into the simulation, along with a single-speed transmission and unlimited battery power to calculate the energy efficiency. To calculate the energy consumption of the motor, the power must be calculated using the equation below, in *Figure 1*. Where τ is the torque of the motor, ω is the angular velocity of the motor, and η is the efficiency raised to sign of τ and ω of the motor.


```markdown
Download Instructions
```

Download the updated Project 3 Week 3 Simulink model [Project3_Wk3_Model.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part3/MEEN432_Project3_Wk3_Model.slx), main Matlab code [Project3_run.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project3/Part3/Project3_run.m), and supplementary Matlab code [p3_init.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project3/Part3/p3_init.m) from this main/Project3/Part3 folder. <br>

```markdown
Download Instructions for EPA data from Project 3 Week 1 README.md
```

The following Matlab code contains velocity dynamometer values from the EPA for Urban Driving: <br>
Urban EPA Data: [init_urban_epa.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part1/init_urban_epa.m) <br>
Urban EPA Data (2 cycles): [init_urban_epa_2cycle.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part1/init_urban_epa_2cycle.m) <br>

The following Matlab code contains velocity dynamometer values from the EPA for Highway Driving: <br>
Highway EPA Data: [init_highway.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project3/Part1/init_highway_epa.m) <br>

```markdown
Procedure
```
- Place all the files into the same folder and open the folder's directory in Matlab. <br>
- Run the p3_init.m script <br>
- Run the Project3_run.m script <br>

Optionally, the Project3_run.m script's EPA cycle can be changed by running the desired EPA script first, adding the data to your workspace as urban_epa or highway_epa. Finally, change the variable values in the MODEL INIT section of the script to either urban_epa or highway_epa for urban or highway EPA data, respectively. <br>

```markdown
Input Variables
```
Values for the Project3_run.m code come from the p3_init.m file <br>

Either EPA data can be used for Project3_run.m initial conditions:
- Urban EPA Dynamometer Data
- Highway EPA Dynamometer Data
- Urban EPA Dynamometer Data (2 cycles)

```markdown
Output
```
plot of simulated vehicle speed vs desired vehicle speed

