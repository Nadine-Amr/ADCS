function [ nx, ny, nz] = pulses( Bx,By,Bz,Tx,Ty,Tz ) %nx,ny,nz: number of pulses sent to the magnetorquer in 3 directions
%Bx,By,Bz: magnetic flux affecting the sattellite 
%Tx,Ty,Tz: Torque.

B=[Bx By Bz];
T=[Tx Ty Tz];
B_sval= (Bx^2)+(By^2)+(Bz^2); %absolute value of magnetic flux squared
M= cross(B,T)/B_sval; %dipole moment
Lx=M(1);
Ly=M(2);
Lz=M(3);
L=sqrt((Lx^2)+(Ly^2)+(Lz^2)); 
Lmax=0.076;
h=0.3; %sampling time
delta= 0.04*0.076; %minimal possible value of L 
t_proc=0.4; %processing time
t_pulse=0.1; %pulse width of power control unit
t_sample=4; %sampling time of control mode
if L> delta
    lambda=(1-(delta/L))/(1+h); 
elseif L <= delta
    lambda=0;
end
%lambda: efficiency factor of control

if abs(lambda*Lx) < Lmax
    Lx= - lambda*Lx;
elseif abs(lambda*Lx) >= Lmax
    Lx= - Lmax* sign(lambda*Lx);
end

if abs(lambda*Ly) < Lmax
    Ly= - lambda*Ly;
elseif abs(lambda*Ly) >= Lmax
    Ly= - Lmax* sign(lambda*Ly);
end

if abs(lambda*Lz) < Lmax
    Lz= - lambda*Lz;
elseif abs(lambda*Lz) >= Lmax
    Lz= - Lmax* sign(lambda*Lz);
end

nx= abs(Lx*(t_sample-t_proc)/t_pulse);
ny= abs(Ly*(t_sample-t_proc)/t_pulse);
nz= abs(Lz*(t_sample-t_proc)/t_pulse);

end

