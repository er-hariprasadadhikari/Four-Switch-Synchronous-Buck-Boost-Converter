close all; clear; clc
buck_parameters;
f_sw=1/T;
Vin=12; Vref=1.2;
D=Vref/Vin;
R=10; r_eq=r_L+r_1;
alpha=(R+r_eq)/R;
D_p=D/alpha;
V_p=Vin*D_p;

%% modulator parameters
V_m=10;
Fm=1/V_m;
Vcon=D*V_m;

%% define pole parameters
z_c=sqrt(L/C);
w_o_ideal=1/sqrt(L*C);
w_o=w_o_ideal*(sqrt((R+r_eq)/(R+r_C)));
Q=alpha/(((r_C+r_eq)/z_c)+(z_c/R));

%%  define poles and zeros
delta_p=[1/(w_o^2) 1/(Q*w_o) 1];
w_esr=1/(r_C*C);
w_p=1/((R+r_C)*C);
w_L=r_eq/L;

%% define control to output TF
num_p=(Vin/alpha)*[1/w_esr 1];
den_p=delta_p;
Gvd=tf(num_p,den_p);
Gvc=Fm*Gvd;

%% define output impedence
num_o=(r_eq/alpha)*[1/(w_L*w_esr) ((1/w_esr)+(1/w_L)) 1];
den_o=delta_p;
Z_o=tf(num_o,den_o);

%% define audio susceptibility
num_a=(D/alpha)*[1/w_esr 1];
den_a=delta_p;
Gvg=tf(num_a,den_a);

% %%PID control design using SISO Tool
% pidtool(Gvc);
% Gc=Gc_siso;
% [num_siso,den_seso] = tfdata(Gc_siso);
% num_con=num_siso{1};
% den_con=den_siso{1};

% %% loop gain and closed loop TF
% G_loop=Gvd*Fm*Gc; %% lopp gain
% Z_oc=Z_o/(1+G_loop); %% closed loop output impedance
% G_cl=G_loop/(1+G_loop); %% closed loop TF
% G_vgc=Gvg/(1+G_loop); %% closed loop audio susc
%% frequency response
figure(3)
bode(Gvc,'b');
hold on;
%%root locus 
figure(4)
rlocus(Gvc);
hold on;

%% Transient parameters and transient response

t_sim=5e-3;
t_step=3e-3;
delta_D=0; delta_Vcon=delta_D*V_m;
delta_Io=10; delta_Vin=0;
[y_s,t_s]=step(Z_o,(t_sim-t_step));
v_o_ac=-delta_Io*y_s;

% transient in input voltage
t_sim=4e-3;
t_step=2e-3;
delta_D=0; delta_Vcon=delta_D*V_m;
delta_Io=0; delta_Vin=-2;
[y_s,t_s]=step(Gvg,(t_sim-t_step));
v_o_ac=delta_Vin*y_s;

%% change in duty ratio
% t_sim=4e-3;
% t_step=2e-3;
% delta_D=0.1; delta_Vcon=delta_D*V_m;
% delta_Io=0; delta_Vin=0;
% [y_s,t_s]=step(Gvc,(t_sim-t_step));
% v_o_ac=delta_Vcon*y_s;


%% acutal switch simulation
open_system('small_signal_verification.slx')
sim('small_signal_verification.slx')
t=ans.simout_buck.time; t_scale=t*1e3;
x=ans.simout_buck.data;
i_L=x(:,1);
V_o=x(:,2);

figure(1)
plot(t_scale,i_L,'r','Linewidth',2);
hold on;
figure(2)
plot(t_scale,V_o,'b','Linewidth',2);
hold on;

%% Plot buck simulation 
figure(2)
plot((t_s+t_step)*1e3,V_p+v_o_ac,'r','Linewidth',2);
xlabel('Time(ms)','FontSize',15);
ylabel('Output voltage (V)','FontSize',15);
hold on;
grid on;
