clear; close all;
clc;
%%% loading and setting parameters
buck_parameters;
R=1; t_slew=0.1e-3;
V_m=10; K_p=30; K_i=200000; K_d=0.04;
t_sim = 1e-3;
Vtrans=6;
T_transient=0.0005;
%%%% Initializing simulation 
open_system('buck_converter_VMC_soft_feedforward.slx')
sim('buck_converter_VMC_soft_feedforward.slx')
t=ans.simout_buck.time;
x=ans.simout_buck.data;

%%% plotting 
i_L=x(:,1);
V_o=x(:,2);
figure(1)
plot(t,i_L,'r')
hold on;
figure(2)
plot(t,V_o,'g')
hold on;