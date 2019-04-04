k = 200;
u = zeros(k,1);
y = u;
z = u;
Y = zeros(1000);
a = 2;
u(k) = 0;
z(k) = a;
for i = 1:k
    y = circshift(y,-1);
    y(k)=symulacja_obiektu4y(u(k-6),u(k-7),z(k-2),z(k-3),y(k-1),y(k-2));
    u = circshift(u,-1);
    z = circshift(z,-1);
    u(k) = 0;
    z(k) = a;
end
% plot(y);
% hold on;
plot(z);
hold on;
xlabel('k');
ylabel('z(k)');
% legend('y','u');
% saveas(gcf,'odp_skok_z.eps','epsc');
%save('odp_skok_u.mat','y');