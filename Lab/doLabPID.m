clear all;
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
% 
K=9.65;
Ti=60;
Td=0.17;
% Czas probkowania
T=1;
error=0;
sim_len=900;

% Parametry wygodnego, dyskretnego PIDa
r0=K*(1+T/(2*Ti)+Td/T);
r1=K*(T/(2*Ti)-2*Td/T-1);
r2=K*Td/T;

Y=zeros(sim_len,1);
U=zeros(sim_len,1);
e=zeros(sim_len,1);
y=zeros(sim_len,1);
u=zeros(sim_len,1);
Yzad=zeros(sim_len,1);

Ypp=readMeasurements(1);
Upp=29;

Y(1:30)=Ypp;
U(1:30)=Upp;
kk=linspace(1,sim_len,sim_len)';


Yzad(1:sim_len/3-1)=37.0;
Yzad(sim_len/3:2*sim_len/3-1)=33.0;
Yzad(2*sim_len/3:sim_len)=34.5;


% U w przedziale 1.2:2.8; u w przedziale -0.8:0.8
Umin=0;
Umax=100;
deltaumax=100;
umin=Umin-Upp;
umax=Umax-Upp;

for k=31:sim_len
 measurements = readMeasurements(1:7); % read measurements from 1 to 1
 
    Y(k)=measurements(1);
    
    y(k)=Y(k)-Ypp;
    e(k)=Yzad(k)-Y(k);
    error=error+e(k)^2;
    
    u_wyliczone=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
%     u_wyliczone=1;
    % Rzutowanie ograniczen na wartosc sterowania
    if u_wyliczone<umin
        u_wyliczone=umin;
    elseif u_wyliczone>umax
        u_wyliczone=umax;
    end
    % Rzutowanie ograniczen na wartosc zmiany sterowania
    if u_wyliczone-u(k-1)<-deltaumax
        u_wyliczone=u(k-1)-deltaumax;
    elseif u_wyliczone-u(k-1)>deltaumax
        u_wyliczone=u(k-1)+deltaumax;
    end
    u(k)=u_wyliczone;
    U(k)=u_wyliczone+Upp;
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
    [50, 0, 0, 0, U(k), 0]);  % new corresponding control valuesdisp(measurements); % process measurements
    disp([Y(k),U(k)]);
    waitForNewIteration();
end

plot(Y);
hold on;
plot(Yzad,'--');
hold on;
title(num2str(error));
plot (U);
hold off;

T=table(kk,Yzad);
writetable(T,'LAB1_4_Yzad','WriteVariableNames',false,'Delimiter','space');



T=table(kk,Y);
name="LAB1_PID_EXP K="+string(K)+" Ti="+string(Ti)+" Td="+string(Td)+"error= "+string(error)+".txt";
% name="PROJ1_PID_OPT K="+string(K)+" Ti="+string(Ti)+" Td"+string(Td);
writetable(T,char(name),'WriteVariableNames',false,'Delimiter','space');
T=table(kk,U);
name="LAB1_PID_EXP_STER K="+string(K)+" Ti="+string(Ti)+" Td="+string(Td)+"error= "+string(error)+".txt";
writetable(T,char(name),'WriteVariableNames',false,'Delimiter','space');


    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
    [50, 0, 0, 0, 29, 0]);  % new corresponding control valuesdisp(measurements); % process measurements
