clear variables
close all

% zmienne i macierze regulatora
load('odp_skoks')
s = su;
z = sz;
D=116;
N=116;
Nu=4;
DZ = 25;
lambda = 1;

M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=s(i-j+1);
      end
   end
end

MP=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)=s(i+j)-s(j);
      else
         MP(i,j)=s(D)-s(j);
      end    
   end
end

MZP=zeros(N,DZ);
for i=1:N
    MZP(i,1) = z(i);
   for j=2:DZ
      if i+j-1<=DZ
         MZP(i,j)=z(i+j-1)-z(j);
      else
         MZP(i,j)=z(DZ)-z(j);
      end      
   end
end

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
kz=K(1,:)*MZP;
ke=sum(K(1,:));
deltaup=zeros(1,D-1);
deltazp=zeros(1,DZ-1);
deltaup_bez = deltaup;

% dane
n = 1000;
tau = 7;
U0 = 0;
Z0 = 0;
Y0 = 0;
start = 10;

U = U0*ones(1,n);
U_bez = U;
Z = Z0*ones(1,n);
for i = 1:n
    Z(i) = sin(i/20)/2;
end
Y = Y0*ones(1,n);
Y_bez=Y;
Yz = Y;
Yz(10:end) = 1;
e = zeros(1,n);
e_bez = e;

hold on
for k = start:n
    Y(k) = symulacja_obiektu4y(U(k-6),U(k-7),Z(k-2),Z(k-3),Y(k-1),Y(k-2));
    Y_bez(k)=symulacja_obiektu4y(U_bez(k-6),U_bez(k-7),Z(k-2),Z(k-3),Y_bez(k-1),Y_bez(k-2));
    e(k) = Yz(k) - Y(k);
    e_bez(k) = Yz(k)-Y_bez(k);
    
    %uwzglêdnianie zak³ócenia
    for i = DZ:-1:2
       deltazp(i) = deltazp(i-1);
    end
    deltazp(1) = Z(k) - Z(k-1);

    % Prawo regulacji
    deltauk = ke*e(k)-ku*deltaup'-kz*deltazp';
    deltauk_bez = ke*e_bez(k)-ku*deltaup_bez';

    for i = D-1:-1:2
      deltaup(i) = deltaup(i-1);
      deltaup_bez(i) = deltaup_bez(i-1);
    end
    deltaup(1) = deltauk;
    deltaup_bez(1) = deltauk_bez;
    U(k) = U(k-1)+deltaup(1);
    U_bez(k) = U_bez(k-1)+deltaup_bez(1);
end
Err = (Yz-Y)*(Yz-Y)';
plot(Yz, 'r--')
hold on
plot(Y, 'b')
plot(Y_bez, 'g')
title('Error='+string(Err));
xlabel('k')
ylabel('Y(k), Yzad(k), Y_bez(k)');
legend('Yzad','Y','Y bez uwzgledniania zaklocenia')