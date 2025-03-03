# Project	3	Week	1	Submission
##  Simple Longitudinal simulation model of a vehicle

The following Matlab code takes Dynamometer data from the epa.gov website under their fuel and emissions testing section for Urban and Highway driving. This model is a simpler model without tire slip and only consists of the wheels and chasis. The model starts by reading the velocity data from the EPA table and converting it from miles per hour to meters per second. It then goes through a PID controller that takes in the desired velocity from the EPA data and compares it to the current velocity of the car. A throttle and brake percentage command is calucated from the output of the PID controller block. These values then go to the power train and brake systems respectively to calculate wheel torque, inertia, and force created by the brakes. This is then put into the wheel subsystem and finally through the longitudinal subsystem to output acceleration, velocity, and position of the car.


```markdown
Download Instructions
```
Download the Simulink model [MEEN432_Project3_start.slx]https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part1/Project3_init.m)(https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project3/Part1/MEEN432_Project3_start.slx)) <br>

The following Matlab code contains velocity dynamometer values from the EPA for Urban and Highway Driving: <br>
Urban EPA Data (2 cycles): [init_urban_epa_2cycle.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part1/init_urban_epa_2cycle.m)
Highway EPA Data: [init_highway_epa.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project3/Part1/init_highway_epa.m) <br>

Once both Week 1 files are downloaded, place them into the same folder and open the folder's directory in Matlab. <br>

```markdown
Input Variables
```
Project3_Week1.m uses the following default values: <br>
r = 0.3 <br>
m = 1000 <br>
I = 1600 <br>
I_w = 0 <br>
F_drag = 0 <br>

Project3_Week1.m initial conditions:
- Urban EPA Dynamometer Data
- Highway EPA Dynamometer Data

```markdown
Output Plots
```
- Urban EPA Data: Simulated Vehicle Velocity vs Time
- Highway EPA Data: Simulated Vehicle Velocity vs Time

