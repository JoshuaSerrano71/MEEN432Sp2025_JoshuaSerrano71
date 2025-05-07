# The non-flat track :)

This *individual* folder contains the updated Project4_track.m code, which attempts to generate a 3D track using the function <br>
*Height(x) = exp((x-450)/50) / (1 + exp((x-450)/50)) * 10;* <br>
However, as seen below in the Output Example section. The track does not have a steady elevation change. Nevertheless, the updated code does plot the track in a 3D enviornment and does have some, somewhat, smooth elevation changes in some parts. 
Also, since a z direction was not added to the Simulink model, the z position of the car was instead estimated based on its X and Y coordinates, which is what likely caused the large dips seen in the Output Example image. (Since they were not true Simulink simulation z values)


```markdown
Download Instructions
```
- Download the Matlab code for Initialization [MEEN432_Project4_Model_V2.slx)](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Week4/MEEN432_Project4_Model_V2.slx)
- Download the Matlab Simulink file [Project4_init.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Week4/Project4_init.m)
- Download the UPDATED Matlab code for the track [Project4_track.m](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Individual/Project4_track.m)

```markdown
Procedure
```
- Run the Project4_init.m code
- Open the MEEN432_Project4_Model_V2.slx simulink
- Run the Project4_track.m

```markdown
Output Example
```
This is what the track should look like in Figure 2 of the Matlab output: <br>

![image alt](https://github.com/JoshuaSerrano71/MEEN432Sp2025_JoshuaSerrano71/blob/main/Project4/Photos/fig2.png)
<br>


