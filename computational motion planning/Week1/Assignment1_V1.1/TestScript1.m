%
% TestScript for Assignment 1
%

%% Define a small map
map = false(10);

% Add an obstacle
map (1:5, 6) = true;
%map (2:10, 6) = true;

start_coords = [6, 2];
dest_coords  = [9, 9];
% % map(1:5,5:8) = true;
% % start_coords = [6,2];
% % dest_coords = [1 ,1];
%%
close all;
% [route, numExpanded] = DijkstraGrid (map, start_coords, dest_coords);
% Uncomment following line to run Astar
[route, numExpanded] = DijkstraGrid (map, start_coords, dest_coords);

%HINT: With default start and destination coordinates defined above, numExpanded for Dijkstras should be 76, numExpanded for Astar should be 23.
