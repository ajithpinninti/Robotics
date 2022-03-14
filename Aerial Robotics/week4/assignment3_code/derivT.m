function [T] = derivT(n,d,t)
N = ones(n,1);
Der = 0:n-1;
for j=1:d
    for i=1:n
        N(i) = N(i)*Der(i);
        if Der(i)>0
            Der(i) = Der(i)-1;
        end
    end
end

for i=1:n
    N(i) = N(i)*(t^Der(i));
end
[T] = N';
end