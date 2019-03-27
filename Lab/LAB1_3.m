load ('step_response.mat');

normal_step_response=(step_response-step_response(1))/40;
N = length(step_response)-1;
k = linspace (0,N,N+1)';

T=table(k,normal_step_response);
for i=1:N+1
    if (normal_step_response(i)>=0.99*normal_step_response(end))
        cut_step_response = normal_step_response(1:i);
        cut_k=k(1:i);
        break;
    end
end

T1=table(cut_k,cut_step_response);

writetable(T,'normal_step_response','WriteVariableNames',false,'Delimiter','space');
writetable(T1,'cut_step_response','WriteVariableNames',false,'Delimiter','space');

save('normal_step_response.mat','normal_step_response');
save('cut_step_response.mat','cut_step_response');

