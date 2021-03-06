function [ desired_state ] = traj_generator(t, state, waypoints)
% TRAJ_GENERATOR: Generate the trajectory passing through all
% positions listed in the waypoints list
%
% NOTE: This function would be called with variable number of input arguments.
% During initialization, it will be called with arguments
% trajectory_generator([], [], waypoints) and later, while testing, it will be
% called with only t and state as arguments, so your code should be able to
% handle that. This can be done by checking the number of arguments to the
% function using the "nargin" variable, check the MATLAB documentation for more
% information.
%
% t,state: time and current state (same variable as "state" in controller)
% that you may use for computing desired_state
%
% waypoints: The 3xP matrix listing all the points you much visited in order
% along the generated trajectory
%
% desired_state: Contains all the information that is passed to the
% controller for generating inputs for the quadrotor
%
% It is suggested to use "persistent" variables to store the waypoints during
% the initialization call of trajectory_generator.


%% Example code:
% Note that this is an example of naive trajectory generator that simply moves
% the quadrotor along a stright line between each pair of consecutive waypoints
% using a constant velocity of 0.5 m/s. Note that this is only a sample, and you
% should write your own trajectory generator for the submission.

% persistent waypoints0 traj_time d0
% if nargin > 2
%     d = waypoints(:,2:end) - waypoints(:,1:end-1);
%     d0 = 2 * sqrt(d(1,:).^2 + d(2,:).^2 + d(3,:).^2);
%     traj_time = [0, cumsum(d0)];
%     waypoints0 = waypoints;
% else
%     if(t > traj_time(end))
%         t = traj_time(end);
%     end
%     t_index = find(traj_time >= t,1);
% 
%     if(t_index > 1)
%         t = t - traj_time(t_index-1);
%     end
%     if(t == 0)
%         desired_state.pos = waypoints0(:,1);
%     else
%         scale = t/d0(t_index-1);
%         desired_state.pos = (1 - scale) * waypoints0(:,t_index-1) + scale * waypoints0(:,t_index);
%     end
%     desired_state.vel = zeros(3,1);
%     desired_state.acc = zeros(3,1);
%     desired_state.yaw = 0;
%     desired_state.yawdot = 0;
% end
% %


%% Fill in your code here
persistent waypoints0 traj_time d0 xcoeff ycoeff zcoeff
if nargin > 2
    d = waypoints(:,2:end) - waypoints(:,1:end-1);
    d0 = 2 * sqrt(d(1,:).^2 + d(2,:).^2 + d(3,:).^2);
    traj_time = [0, cumsum(d0)];
    waypoints0 = waypoints;
    xcoeff = getCoeff(waypoints(1,:)');
    ycoeff = getCoeff(waypoints(2,:)');
    zcoeff = getCoeff(waypoints(3,:)');
else
    if(t > traj_time(end))
        t = traj_time(end) - 0.001;
    end
    t_index = find(traj_time > t,1)-1;
    t_index = max(t_index,1);
    if(t == 0)
        desired_state.pos = waypoints0(:,1);
        desired_state.vel = zeros(3,1);
        desired_state.acc = zeros(3,1);
    else
        scale = (t-traj_time(t_index))/d0(t_index);
        index = 8*(t_index-1)+1:8*(t_index);
        coeff = [xcoeff(index,:)' ;ycoeff(index,:)' ; zcoeff(index,:)'];
        %all scaling substited value t = scale scale_val = [1 t t^2
        %t^3..t^7]
        scale_val = polyT(8,0,scale)';
        desired_state.pos = coeff*scale_val;
        %for velocity and acceleration value
        scale_vel = polyT(8,1,scale)';
        scale_acc = polyT(8,2,scale)';
        
        desired_state.vel = (coeff*scale_vel).* (1/d0(t_index));
        desired_state.acc = (coeff*scale_acc).*(1/d0(t_index)^2);
    end
   
    desired_state.yaw = 0;
    desired_state.yawdot = 0;
end


% desired_state.pos = zeros(3,1);
% desired_state.vel = zeros(3,1);
% desired_state.acc = zeros(3,1);
% desired_state.yaw = 0;
end

