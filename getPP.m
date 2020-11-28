%% 

clc
clear all

%% inputs

% length of frame(L), 
% length of links(a1, a2), 
% width of center rectangle(wc)

wc = 100
L = 500
a1 = 350
a2 = 350

%% calculate ox oy oz(end parametric point(w.r.t each subsystem coordinate) of each links)

world_fx = [L/2, L,   0];
world_fy = [0  , L/2, L];
world_fz = [0  ,   0, L/2];

ori_fx = [1 0 0;
          0 1 0;
          0 0 1];
ori_fy = [0 1 0;
          0 0 1;
          1 0 0];
ori_fz = [0 0 1; 
          0 -1 0; 
          1 0 0];
      
world_ox = [L/2, L/2 + wc/2, L/2];
world_oy = [L/2 - wc/2, L/2, L/2];
world_oz = [L/2, L/2 - wc/2, L/2];

ox = ori_fx*(world_ox-world_fx)'
oy = ori_fy*(world_oy-world_fy)'
oz = ori_fz*(world_oz-world_fz)'

%% calculate ppx, ppy, ppz(w.r.t each subsystem coordinate)


Dx = (ox(2)^2 + ox(3)^2 - a1^2 - a2^2) / (2*a1*a2); 
Dy = (oy(2)^2 + oy(3)^2 - a1^2 - a2^2) / (2*a1*a2); 
Dz = (oz(2)^2 + oz(3)^2 - a1^2 - a2^2) / (2*a1*a2); 

th2x = atan2d(sqrt(1 - Dx^2), Dx);
th2y = atan2d(sqrt(1 - Dy^2), Dy);
th2z = atan2d(sqrt(1 - Dz^2), Dz);

% must 
if th2x < 0
    th2x = atan2d(-sqrt(1 - Dx^2), Dx);
end
if th2y < 0
    th2y = atan2d(-sqrt(1 - Dy^2), Dy);
end
if th2z < 0
    th2z = atan2d(-sqrt(1 - Dz^2), Dz);
end

th1x = atan2d(ox(3), ox(2)) - atan2d(a2*sind(th2x), a1+a2*cosd(th2x));
th1y = atan2d(oy(3), oy(2)) - atan2d(a2*sind(th2y), a1+a2*cosd(th2y));
th1z = atan2d(oz(3), oz(2)) - atan2d(a2*sind(th2z), a1+a2*cosd(th2z));

ppx = [0, a1*cosd(th1x), a1*sind(th1x)];
ppy = [0, a1*cosd(th1y), a1*sind(th1y)];
ppz = [0, a1*cosd(th1z), a1*sind(th1z)];

o = [ox';oy';oz']
pp = [ppx; ppy; ppz]
