load('step_responsez_20.mat');

normal_step_response=(step_responsez_20-step_responsez_20(1))/20;

N = length(step_responsez_20)-1;
k = linspace (0,N,N+1)';

save('normal_step_response.mat','normal_step_response');
for i=1:N+1
    if (normal_step_response(i)>=0.995*normal_step_response(end))
        cut_step_response = normal_step_response(1:i);
        cut_k=k(1:i);
        break;
    end
end