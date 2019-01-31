function [magnetic_moment]= mgmoment(x,y,z,V_x,V_y,V_z,rollx,pitchy,yawz,t)
%x=7136635.8;    y=0;    z=0;
%V_x=7.4147;
%V_y=1.2033; 
%V_z=-0.3803;
[Bx,By,Bz]= igrf(x,y,z); %magnetic field in greenwich coordinates
[positionGCS]=[Bx,By,Bz]; %magnetic field in greenwich coordinates to be used in transformation.
[ST] = st(t); %saderial time.
%transformate the magnetic field from greenwich to inertial coordinates
[ positionICS ] = GCStoICS( ST,positionGCS );
% used to get the elements from position and velocity also to get the
% velocity in vector form.
[ i, w, W, v, a, e, V ] = RV2COE(x,y,z,V_x,V_y,V_z);
%transform the magnetic field from inertial to orbital coordinate.
[ positionOCS, angvOCS ] = ICStoOCS(positionICS, i, w, W, V);
% to use the magnetic field only not angular velocity.
vector=positionOCS;
%rollx=20;
%pitchy=30; 
%yawz=10;
%transform from orbital to body coordinate.using euler angles from
%actuators so we use iterations.
[ rotatedvector ] = eanglesrotation(vector, rollx, pitchy, yawz);
spacecraft_effective_magnetic_moment =[0.0035 0.0035 0.0035];
%instantenous magnetic torque= spacecraft effective magnetic moment x
%magnetic field in body coordinate system.
[magnetic_moment] = cross(spacecraft_effective_magnetic_moment ,rotatedvector);
end