a = 1:0.0001:2;
Ea = arrayfun(@(x)E3(x), a);

plot(a, Ea); %sanity check

[~,i]=min(Ea); % Z=2/a; c000 c020 c001
[a(i) , Ea(i)]

function e = E3(a)
A = [Ht(0,0,0,0,0,0,a) Ht(0,0,0,0,2,0,a) Ht(0,0,0,0,0,1,a);
 Ht(0,2,0,0,0,0,a) Ht(0,2,0,0,2,0,a) Ht(0,2,0,0,0,1,a);
 Ht(0,0,1,0,0,0,a) Ht(0,0,1,0,2,0,a) Ht(0,0,1,0,0,1,a)];

B = [N6(0,0,0,0,0,0,a) N6(0,0,0,0,2,0,a) N6(0,0,0,0,0,1,a);
 N6(0,2,0,0,0,0,a) N6(0,2,0,0,2,0,a) N6(0,2,0,0,0,1,a);
 N6(0,0,1,0,0,0,a) N6(0,0,1,0,2,0,a) N6(0,0,1,0,0,1,a)];

% % A = [Ht(0,0,0,0,0,0,a) Ht(0,0,0,1,0,0,a) Ht(0,0,0,0,0,1,a);
% %  Ht(1,0,0,0,0,0,a) Ht(1,0,0,1,0,0,a) Ht(1,0,0,0,0,1,a);
% %  Ht(0,0,1,0,0,0,a) Ht(0,0,1,1,0,0,a) Ht(0,0,1,0,0,1,a)];
% % 
% % B = [N6(0,0,0,0,0,0,a) N6(0,0,0,1,0,0,a) N6(0,0,0,0,0,1,a);
% %  N6(1,0,0,0,0,0,a) N6(1,0,0,1,0,0,a) N6(1,0,0,0,0,1,a);
% %  N6(0,0,1,0,0,0,a) N6(0,0,1,1,0,0,a) N6(0,0,1,0,0,1,a)];

% NOTATION:  (H-NE)a=0  ===  (A-Ba)x=0
[Y, beta] = eig(B);

isb = inv(sqrt(beta));

C_ = isb*Y'*A*Y*isb;

[z,eC] = eig(C_);

e = min(min(eC));

end

% %sanity check 
% x = Y*isb*z(:,3);
% (x'*A*x) 



% %sanity check
% ritz = @(x)(Ht(0,0,0,0,0,0,x)/N(0,0,0,x));
% plot(1:0.001:1.5, arrayfun(ritz, 1:0.001:1.5)) 


function h = Ht(j,k,m,jd,kd,md,a)
    J = j+jd;
    K = k+kd;
    M = m+md;
    h = Tt(j,k,m,jd,kd,md,a) + Ct(J,K,M,a) + Wt(J,K,M,a);
end

function c = Ct(J,K,M,a)
    c = -2*C(J,K,M,a);
end
function t = Tt(j,k,m,jd,kd,md,a)

    t = T(j,k,m,jd,kd,md,a) / 2 ;
end
function w = Wt(J,K,M,a)
    w = W(J,K,M,a);
end

function t = T(j,k,m,jd,kd,md,a)
    J = j+jd;
    K = k+kd;
    M = m+md;
    t = (1/2)*((m*kd + md*k)*(C(J+1,K,M-2,a) - C(J-1,K,M,a)));
    t = t + (1/2)*((m*jd + md*j)*(C(J-1,K,M,a) - C(J-1, K+2, M-2,a)));
    t = t + (1/2)*(-(M*2/a)*(C(J,K,M,a) - C(J,K+2,M-2,a)));
    t = t + 2*((4/(a*a))*N(J,K,M,a) - J*(2/a)*N(J-1,K,M,a) + j*jd*N(J-2,K,M,a) + k*kd*N(J,K-2,M,a) + m*md*N(J,K,M-2,a) );   
        
end
function c = C(J,K,M,a)
    if(M == -2)
       c = 0;
       return;
   end
    c = 8*pi*pi;
    c = c * factorial(J+K+M+4);
    c = c * ((a/4)^(J+K+M+5));
    c = c * (1/(M+2));
    c = c * (1/(K+1) - 1/(K+M+3));
end

function n = N(J,K,M,a)
   if(M == -2)
       n = 0;
       return;
   end
   n = 2*pi*pi;
   n = n * factorial(J+K+M+5);
   n = n * ((a/4)^(J+K+M+6));
   n = n * (1/(M+2));
   t = (1/(K+1) - 1/(K+3) - 1/(K+M+3) + 1/(K+M+5));
   n = n * t;   
end

function n = N6(j,k,m,jd,kd,md,a)
    J = j+jd;
    K = k+kd;
    M = m+md;
    n = N(J,K,M,a);
end
function w = W(J,K,M,a)
    w = N(J,K,M-1,a);
end


