clear 
clc
% All distances will be expressed in kilometers%
p = 9.08*10^-6 %Radiation pressure for reflection%
epsilon = 23.44 % angle that spesifies the tilting between the ecliptic and the equatorial plane%
rsun = 149600000 ; % distance from the sun to Earth%
mu = 398600;
area = input('please enter the area of contact:' );
raan = input('please enter your right asencsion:' ); 
i = input('please enter your inclination:' ); 
omega = input('please enter your argument of perigee:' );
nu = input('please enter your true anomaly:' );
a = input('please enter your semimajor axis value:' );
e = input('please enter your eccintricity value:' );
h = input('please enter your angular momentum value:' );
lambda = input ('please input your number:' );  % The sun's angular position is specified by %
% this angle, varies from lambda = 0 in the march equinox to 360 degrees after one year %
s = rsun*[cosd(lambda) sind(lambda)*cosd(epsilon) sind(lambda)*sind(epsilon)]; %Expressing the sun%
%vector in equatorial reference frame%
trans1 = [cosd(i)*cosd(raan) cosd(i)*sind(raan) sind(i)]%transformation matrix for the distance%
%between the center of the earth and the origin of the periocal plain%
d = (a*e).*trans1 ;%the distance%
rfocus = s-d; % this term expresses the radius of the sun to earth as seen from focus but 
%with axes as same as orientation of the xyz plain of the equatorial%
%Next step is to transform the s into a unit vector and apply
%transformations from the xyx plain of the focus to the perifocal frame and
%also equate the satellite r in the perifocal frame
usun = s./rsun ; % sun unit vector%  
trans2 = [cosd(raan)*cosd(omega)-sind(raan)*sind(omega)*cosd(i) sind(raan)*cosd(omega)+cosd(raan)*cosd(i)*sind(omega)
 sind(raan)*sind(i);
 sind(raan)*cosd(omega)+cosd(raan)*cosd(i)*sind(omega) -sind(raan)*sind(omega)+cosd(raan)*cosd(omega)*cosd(i)
 sind(i)*cosd(omega);
  sind(raan)*sind(i) -cosd(raan)*sind(i) cosd(i)];%this is a matrix that transforms the xyz into pqw%
usunperi = usun.'*tans2;%new unit vector in perifocal frame%
rsunperi = rsun.*usunperi; % the vector itself %
%the next two line will be specified for the determination of the satellite
%r in perifocal frame%
rsat= (h^2/mu)*(1/(1+ecosd(nu)));
rsatperi = r*[cosd(nu) *sin(nu) 0];
%finally, having all the distances we need, we calculate the radius of the
%sun as seen from the satellite in the perifocal frame%
rfinal = rsunperi - rsatperi.'; 
torque = cross(rfinal,(area*p)); 