%PURPOSE: Writing DT(w,x,k,n) and testing it for correctness.
%REF: https://www.jstor.org/stable/2158264

format short
[ws,x] = wpfun('db1', 1, 3);
a = ws(1,:);
b = ws(1,:);
clf
k = 3; n = 0;
[bkn, xkn] = DT(b,x,k,n);  %keep n <= (2K - 1)(2^k - 1)
%[bkn, xkn] = singlediff(bkn, xkn);
hold on
plot(x,a)
plot(xkn,bkn)
hold off

%trapz( a .* a) * x(2)
%trapz( upsample(a, round(x(2) / (xkn(2) - xkn(1)))) .* bkn ) * (xkn(2) - xkn(1))

function [DTw, DTx] = DT(w,x,k,n)   
    %keep n <= (2K - 1)(2^k - 1)
    DTw = w;
    DTx = x+n;
    
    DTw = 2^(k/2)*DTw;
    DTx = DTx/(2^k);
    
    newxstep = DTx(2) - DTx(1);
    Lpad = round(DTx(1) / newxstep);
    
    DTx = wextend('1', 'asymw', DTx, length(DTx)*(2^k - 1), 'r');
    
    DTw = [DTw , zeros(1,(length(DTx) - length(DTw)))];
    DTw = circshift(DTw, Lpad); DTw(1:Lpad) = zeros(1, Lpad);   
    DTx = wextend('1', 'asymw', DTx, Lpad, 'l');
    
    DTx = DTx(1:length(DTw));
    
end

function [wd, xd] = singlediff(w, x)
    wd = gradient(w)/(x(2) - x(1));
    xd = x;
end

