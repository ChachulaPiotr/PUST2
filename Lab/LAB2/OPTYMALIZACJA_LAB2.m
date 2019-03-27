
close all;

x0=[10,11,0.3,2];

options = optimoptions('fmincon','Display','iter');

approx_params=fmincon(@aprox_error,x0,[],[],[],[],[-100,-100,-100,0],[100,100,100,100],[],options);

error=aprox_error(superrozwiazanie);

save('aprox_params.mat','approx_params');
save('error.mat','error');

load ('approx.mat');
N=length(Y);
for i=1:N+1
    if (Y(i)>=0.99*Y(end))
        cut_step_response = Y(1:i);       
        break;
    end
end

Dz=length(cut_step_response);

k=linspace(0,Dz-1,Dz)';
T=table(k,cut_step_response);
writetable(T,'cut_step_response','WriteVariableNames',false,'Delimiter','space');


save ('cut_step_response.mat','cut_step_response');