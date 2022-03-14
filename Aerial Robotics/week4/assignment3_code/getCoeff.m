function [coff, A, b] = getCoeff(waypoints)
%waypoints = waypoints';
n = size(waypoints,1)-1; % number of segments P1..n
A = zeros(8*n, 8*n);
b = zeros(1,8*n);

% --------------------------------------------

% YOUR CODE HERE 
% Fill A and b matices with values using loops

%  for first 4 equations:
%constrain 1=> pi(0) = waypoints(0)
for i=1:n
    b(1,i) = waypoints(i);
end

row = 1;

for i=1:n
    A(row,8*(i-1)+1:8*i) = polyT(8,0,0); 
    row = row + 1;
end

% another 4 equations
%constrain 2 => pi(1) = waypoints(1)
for i= 1:n                                                                                  
    A(row,8*(i-1)+1:8*(i)) = polyT(8,0,1 ); %polyT(no.of coef,derivativ,tvalue);
    row = row+1;
end
%b is 
%for i=n+1:2*n
    b(n+1:2*n) = waypoints(2:n+1);

 %constrains =>3 
% p1(k)(0) = 0 k=1,2,3

for k=1:3
    A(row,1:8)  =  polyT(8,k,0);
    row = row+1;
end  

%=> constrain4 
%pn(k)(1) = 0;
for k= 1:3
    A(row,8*(n-1)+1:8*(n)) = polyT(8,k,1 );
    row = row+1;
end


% constrain 4 pi(k)(1) = pi+1(k)(0)
%ex.=> p1(t=1)=p2(t=0) => p1(t=1)-p2(t=0) = 0
for k = 1:6
    for N = 1:n-1
        temp = 0;
        temp = [polyT(8,k,1 ) ,(-1)*(polyT(8,k,0))];
        A(row,8*(N-1)+1:8*(N+1)) = temp;
        row = row+1;
    end
end

coff = inv(A)*b';
end