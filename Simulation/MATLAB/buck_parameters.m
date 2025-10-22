L=0.5e-6;  %inductance
C=200e-6;  %capacitance 
T=2e-6;    %switching time period
r_L=5e-3;  %inductor DCR
r_1=5e-3;  %HIGH-side MOSFET on resistance
r_2=5e-3;  %LOW-side MOSFET on resistance
r_C=3e-3;  %capacitor ESR
Vin=12;    % input voltage
Vref=1.2;    %referece output voltage
D=Vref/Vin;% Duty ratio
R=1;       %Load resistance
iL_0=0; 
vC_0=0;
  