k = 1000;
Y = zeros(101);
L = 1;
J = 1;
for l = 0:0.1:10
    for j = 0:0.1:10
        u = zeros(k,1);
        y = u;
        z = u;
        u(k) = l;
        z(k) = j;
        for i = 1:k
            y = circshift(y,-1);
            y(k)=symulacja_obiektu4y(u(k-6),u(k-7),z(k-2),z(k-3),y(k-1),y(k-2));
            u = circshift(u,-1);
            z = circshift(z,-1);
            u(k) = l;
            z(k) = j;
        end
        Y(L,J)=y(k);
        J = J + 1;
    end
    L = L + 1;
    J = 1;
    L
end
plot(Y,0:0.1:10,0:0.1:100);
hold off;
%xlabel('k');
%ylabel('y(k), u(k)');
%legend('y','u');
%saveas(gcf,'odp_skok_u.pdf','pdf');
%save('odp_skok_u.mat','y');