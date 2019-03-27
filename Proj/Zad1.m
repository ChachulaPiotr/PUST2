k = 1000;
u = zeros(k,1);
y = u;
z = u;
Y = zeros(1000);
u(k) = 1;
z(k) = 1;
for i = 1:k
    y = circshift(y,-1);
    y(k)=symulacja_obiektu4y(u(k-6),u(k-7),z(k-2),z(k-3),y(k-1),y(k-2));
    u = circshift(u,-1);
    z = circshift(z,-1);
    u(k) = 1;
    z(k) = 1;
end
plot(y);
hold on;
plot(u);
hold off;
xlabel('k');
ylabel('y(k), u(k)');
legend('y','u');
%saveas(gcf,'odp_skok_u.pdf','pdf');
%save('odp_skok_u.mat','y');