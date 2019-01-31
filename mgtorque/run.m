clear;
clc;
%to check the code
t=3;
x=9635000.8;
y=7623000;
z=8652000;
V_x=7000.4;
V_y=1000.2;
V_z=-1000.38;

rollx=20;
pitchy=30; 
yawz=10;
[magnetic_moment]= mgmoment(x,y,z,V_x,V_y,V_z,rollx,pitchy,yawz,t)