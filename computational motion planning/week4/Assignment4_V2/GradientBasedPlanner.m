function route = GradientBasedPlanner (f, start_coords, end_coords, max_its)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate

[gx, gy] = gradient (-f);

%%% All of your code should be between the two lines of stars.
% *******************************************************************
route = [];
x = start_coords(1);
y = start_coords(2);
route(1,:) = [x ,y];
%magnitude of gradient
step = sqrt(gx.^2+gy.^2);
%using step to scale gz and gy
gx = gx./step;
gy = gy./step;

for iter=2:max_its
    x_new = x + gx(round(y),round(x));%update with gradient at same position
    y_new = y + gy(round(y),round(x));
    if x_new<= size(f,1) && x_new>=1 % prevent out of index values in x dir
        x = x_new;
    end
    if y_new<=size(f,2) && y_new>=1 % prevent out of index in y dir
        y = y_new;
    end
     %if distance between goal and current <=2 stop
    if sqrt((x_new-end_coords(1))^2 + (y_new-end_coords(2))^2)<=2
        disp('breaked');
        break;
    end
    route(iter,:) = [x_new y_new];
    route = double(route);
end
% *******************************************************************
end
% function res = nested_directions(a)
% res = [ a(1) a(2)+1;a(1) a(2)-1;a(1)+1 a(2);a(1)-1 a(2)]
% end
