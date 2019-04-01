function [Err] = DMC_Z ()
    % zmienne i macierze regulatora
    load('odp_skoks');
    s = su;
    z = sz;
    D=116;
%     N=paras(1);
%     Nu=paras(2);
%     lambda = paras(3);
%    DZ = 36;
    N = 116;
    Nu = 4;
    lambda = 1;
    DZ = 25;
    
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

    % dane
    n = 200;
    tau = 7;
    U0 = 0;
    Z0 = 0;
    Y0 = 0;
    start = 10;

    U = U0*ones(1,n);
    Z = Z0*ones(1,n);
    Z(100:end) = 1;
    Y = Y0*ones(1,n);
    Yz = Y;
    Yz(10:end) = 1;
%     Yz(10:200) = 1;
%     Yz(201:400) = 0.5;
%     Yz(401:600) = 1.5;
%     Yz(601:800) = 0;
%     Yz(801:end) = 0.5;
    e = zeros(1,n);

    %hold on
    for k = start:n
        Y(k) = symulacja_obiektu4y(U(k-6),U(k-7),Z(k-2),Z(k-3),Y(k-1),Y(k-2));
        %Y(k) = symulacja_obiektu3y(U(k-5),U(k-6),Z(k-2),Z(k-3),Y(k-1),Y(k-2));
        e(k) = Yz(k) - Y(k);

        %uwzglêdnianie zak³ócenia
        for i = DZ:-1:2
           deltazp(i) = deltazp(i-1);
        end
        deltazp(1) = Z(k) - Z(k-1);

        % Prawo regulacji
        deltauk = ke*e(k)-ku*deltaup'-kz*deltazp';

        for i = D-1:-1:2
          deltaup(i) = deltaup(i-1);
        end
        deltaup(1) = deltauk;
        U(k) = U(k-1)+deltaup(1);
    end
    Err = (Yz-Y)*(Yz-Y)';
    subplot(2,1,1);
    plot(Yz, 'r--')
    hold on
    plot(Y, 'b')
    title('Error='+string(Err));
    xlabel('k')
    ylabel('Y(k), Yzad(k)');
    legend('Yzad','Y')
    subplot(2,1,2);
    plot(U)
    hold on
    plot(Z)
    xlabel('k');
    ylabel('u(k), z(k)');
    legend('u','z');
end