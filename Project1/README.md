# Project 1
## Part 1
![image alt](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project1/Part1/Examples/Project1_Part1_System.png) <br>
*Figure 1: S1 model representation from Project 1 Part 1* <br>

```markdown
Part 1 download instructions
```
Download the Matlab code [Project1_Part1.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part1/Project1_Part1.m) and the Simulink simulation [Project1_shaft.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Project1_shaft.slx) <br>

```markdown
Part 1 Input Varibles
```
Project1_Part1.m uses the following default values but can be modified based on *Figure 1*:
- const_torque = 1    Torque input in Nm
- J = 1               Inertia in kg m^2
- b = 1               Damping Coefficient in Nm/(rad/s)

Project1_Part1.m initial conditions:
- omega0 = 0         Initial Angular Velocity in rad/s
- theta0 = 0         Intial Postion in rad

```markdown
Part 1 Output Plots
```

Project1_Part1.m outputs three graphs:
- Max Simulation Time vs. Time Step
- CPU Time vs. Time Step
- Max Simulation Time vs. CPU Time
  
Here is an example of what the output should look like
[Project1_Part1_plots.pdf](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part1/Project1_Part1_Plots.pdf)

## Part 2
![image alt](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project1/Part2/Examples/Project1_Part2_System.png) <br>
*Figure 2: S1 and S2 model representation from Project 1 Part 2* <br>

```markdown
Part 2 download instructions
```

Download the Matlab code [Project1_Part2.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Project1_Part2.m) and the following Simulink simulations: <br>
Option 1 [Project1_Part2_Op1.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Project1_Part2_Op1.slx) <br>
Option 2 [Project1_Part2_Op2.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Project1_Part2_Op2.slx) <br>
Option 3 [Project1_Part2_Op3.slx](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/tree/main/Project1/Part2/Project1_Part2_Op3.slx) <br>

Once all Part 2 files downloaded place them into the same folder and open the folder's directory in Matlab. <br>

```markdown
Part 2 Input Variables
```
The Project1_Part2.m file uses the following default values but can be modified based on *Figure 2*:
- const_torque = 1     Torque input in Nm
- J1 = 100             Inertia in kg m^2 of S1 shaft
- J2 = 1               Inertia in kg m^2 of S2 shaft
- b1 = 1               Damping Coefficient in Nm/(rad/s) of S1 shaft
- b2 = 1               Damping Coefficient in Nm/(rad/s) of S2 shaft

```markdown
Part 2 Output Variables and Plots
```
Project1_Part2.m Output Varibles
- Omega 1    Output shaft speed of S1 shaft
- Omega 2    Output shaft speed of S2 shaft


Project1_Part2.m will output the following plots:
- Figure 1: Option 1 (ODE 1) Shaft speeds (Omega 1 & 2) at various shaft stiffnesses as a function of time, where DT = 0.1 
- Figure 2: Option 1 (ODE 1) Shaft speeds (Omega 1 & 2) at various shaft stiffnesses as a function of time, where DT = 1
- Figure 3: Option 1 (ODE 4) Shaft speeds (Omega 1 & 2) at various shaft stiffnesses as a function of time, where DT = 0.1
- Figure 4: Option 1 (ODE 4) Shaft speeds (Omega 1 & 2) at various shaft stiffnesses as a function of time, where DT = 1
- Figure 5: Option 1 (ODE 45) Shaft speeds (Omega 1 & 2) at various shaft stiffnesses as a function of time
- Figure 6: Option 2 (ODE 45) Shaft speeds (Omega 1 & 2) at various shaft stiffnesses as a function of time
- Figure 7: Option 2 (ODE 1, 4, 45) Shaft speeds (Omega) at various shaft stiffnesses as a function of time
- Figure 8: Option 3 (ODE 1, 4, 45) Shaft speeds (Omega) at various shaft stiffnesses as a function of time
- Figure 9: CPU Time vs. Time Step for Options 1, 2, and 3




