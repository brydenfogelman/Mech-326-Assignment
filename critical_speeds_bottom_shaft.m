A = 3; B = 9.5; C = 39;
d1 = 20; % mm
d2 = 30; % mm

w_shaft1
w_shaft2
w_shaft3

y_shaft1
y_shaft2
y_shaft3

w = [w_shaft1 w_shaft2 w_shaft3]
y = [y_shaft1 y_shaft2 y_shaft3]

critical_speed = rayleigh_method(w,y)