
close all;

x0=[10,11,0.3,2];

options = optimoptions('fmincon','Display','iter');

superrozwiazanie=fmincon(@aprox_error,x0,[],[],[],[],[-100,-100,-100,0],[100,100,100,100],[],options);

error=aprox_error(superrozwiazanie);


save('error.mat','error');
