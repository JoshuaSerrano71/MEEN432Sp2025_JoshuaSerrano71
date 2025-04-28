# Project	4	Week 4	Submission
##  Updated Electric Vehicle Lateral and Longitudinal Simulation
<br>
The updated week 4 code integrates the lateral and longitudinal models with additional improvements to the driver model. The driver model switches between corner and straight speeds by analyzing changes in the y-direction; this was changed to minimize the difference between desired and actual speed in the simulation. 
<br>
<br>

```markdown
Download Instructions
```
Download the updated Project 4 Week 1 Simulink model [MEEN432_Project4_Model_V2.slx)](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Week4/MEEN432_Project4_Model_V2.slx), initialization Matlab code [Project4_init.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Project4_init.m) , and main Matlab code [Project4_track.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Week4/Project4_track.m) <br>


```markdown
Procedure
```
- Place all the files into the same folder and open the folder's directory in Matlab. <br>
- Run the Project4_init.m script <br>
- Open the MEEN432_Project4_Model_V2.slx Simulink in the background
- Run the Project4_track.m Matlab code <br>


```markdown
Output
```
Project4_track.m <br>
- Figure 1: SOC (State of Charge) vs Time (*Figure 1*)
- Figure 2: Race track view (Race track view is NOT live and only shows where the car was after the simulation)  (*Figure 2*)
- Command Window: Displays lap counter, average lap time, and total simulation time. (*Figure 3*)
  
<br>

![image alt](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Photos/Wk4_Figure1.png)
<br>
*Figure 1: Project4_track.m Figure 1 Output example photo* <br>

![image alt](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Photos/Wk4_Figure2.png) <br>
*Figure 2: Project4_track.m Figure 2 Output example photo* <br>

![image alt](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Photos/Wk4_command_window.png) <br>
*Figure 3: Command window view after successfully running both Matlab codes* <br>





