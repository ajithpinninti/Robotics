function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
% [x,y] = polyxpoly(P1(1,:),P1(2,:),P2(1,:),P2(2,:),'unique')
flag = false;
for i=1:3
%     for j = 1:3
        d1 = inside(P2(i,1),P1(i,2),P2(1,1),P2(1,2),P2(2,1),P2(2,2));
        d2 = inside(P1(i,1),P1(i,2),P2(2,1),P2(2,2),P2(3,1),P2(3,2));
        d3 = inside(P1(i,1),P1(i,2),P2(3,1),P2(3,2),P2(1,1),P2(1,2));
        if(d1<=0 && d2<=0 && d3>=0)
            flag = true;
        end
end

for i=1:3
%     for j = 1:3
        d1 = inside(P2(i,1),P2(i,2),P1(1,1),P1(1,2),P1(2,1),P1(2,2));
        d2 = inside(P2(i,1),P2(i,2),P1(2,1),P1(2,2),P1(3,1),P1(3,2));
        d3 = inside(P1(i,1),P1(i,2),P1(3,1),P1(3,2),P1(1,1),P1(1,2));
        if(d1<=0 && d2<=0 && d3<=0)
            flag = true;
        end
end
        
% *******************************************************************
end
function d = inside(x,y,x1,y1,x2,y2)
 d = (x-x1)*(y2-y1)-(y-y1)*(x2-x1);
end
