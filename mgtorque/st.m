function [ST] = st(t)
ST_0=0;
v_e = 0.002737909;    %related to nutation and precision of earth
w_e = 7.292115e-5;   %angular velocity of earth rad/s
ST = ST_0 + w_e*(1+v_e)*t;
