function [ i, w, W, v, a, e ,V] = RV2COE(x,y,z,V_x,V_y,V_z)
%R=[-500.2 924.1 -6967.3];
R=[x y z]; %position vector
V=[V_x V_y V_z];% velocity vector
u=3.986*10^14; % gravitational constant

h=cross(R,V); %specific angular momentum
K=[0 0 1]; % unit vector in z direction
n=cross(K,h);% ascending node vector

e1=((norm(V)^2-u/norm(R))*R-dot(R,V)*V)/u; %eccentricity vector
e=norm(e1); % magnitude of eccentricity
E=(norm(V)^2/2)-(u/norm(R));% specific energy
a=(-u)/(2*E);% semimajor axis
if  e~=1
p=a*(1-e^2);
else
    p=norm(h)^2/u;
    fprintf('parabolic orbit, a=inf');
end
i=acosd(h(3)/norm(h)); %inclination


if (e==0 && i==0)
%circular equatorial
% true longitude
truelong=acosd(R(1)/norm(R));
if (R(2)<0) 
    truelong=360-truelong; 
end
elseif ( e==0)%circular inclined
        %argument of latitude
        U=acosd((dot(n,R))/(norm(n)*norm(R)));
        if ( R(3)<0) 
            U=360-U; 
        end
    W =acosd(n(1)/norm(n));
    if(n(2)<0)
        W=360-W;
    end    
    elseif (i==0) %elliptic equatorial
            W_true= acosd(e(1)/e);
            if (e1(2)<0)
                W_true=360-W_true;
            end
            v=acosd(dot(e1,R)/(e*norm(R)));
    if (dot (R,V) <0 )
        v=360-v;
    end
else
    %ascending node
    W =acosd(n(1)/norm(n));
    if(n(2)<0)
        W=360-W;
    end
    %argument of perigee
    w=acosd(dot(n,e1)/(norm(n)*e));
    if (e1(3)<0)
        w=360-w;
    end
    %true anamoly at this particular moment
    v=acosd(dot(e1,R)/(e*norm(R)));
    if (dot (R,V) <0 )
        v=360-v;
    end
end
end