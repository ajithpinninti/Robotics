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

%% All of your code should be between the two lines of stars.
*******************************************************************
route = 0;
route = [start_coords]
gx = normalize(gx);
gy = normalize(gy);
for iter = 2:max_its
    if pdist([route(end,:);end_coords],'minkowski') <=2.0
        break;
    end
    gx_v = zeros(4,2);
    gy_v = zeros(4,2);
    i = route(end,1);
    j = route(end,2);
    adjrows = [i+1 i-1 i i];
    adjcols = [j j j+1 j-1];
    adjpoints = zeros(4,2);
    temp = 0;
    for n=1:4
        try
           if any(all(route ==[adjrows(n),adjcols(n)]))
               continue;
           end
                adjpoints(n,:) = [adjrows(n),adjcols(n)];
                gx_v(n,:) = gx(adjpoints(n,:));
                gy_v(n,:) = gx(adjpoints(n,:));
                temp = temp+1;
        catch E
            continue;
        end
     end            
    [gx_v,coords_x] = sort(sqrt(gx_v.^2+gy_v.^2));
    [gy_v,coords_y] = sort(gy_v);
    route(end+1,:) =  adjpoints(coords_x(end),:);
end
*******************************************************************
end
function res = nested_directions(a)
res = [ a(1) a(2)+1;a(1) a(2)-1;a(1)+1 a(2);a(1)-1 a(2)]
end
