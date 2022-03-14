function [F, M] = controller(t, state, des_state, params)
%CONTROLLER  Controller for the quadrotor
%
%   params: robot parameters 

%   Using these current and desired states, you have to compute the desired
%   controls

%   state: The current state of the robot with the following fields:
%   state.pos = [x; y; z], state.vel = [x_dot; y_dot; z_dot],
%   state.rot = [phi; theta; psi], state.omega = [p; q; r]
%
%   des_state: The desired states are:
%   des_state.pos = [x; y; z], des_state.vel = [x_dot; y_dot; z_dot],
%   des_state.acc = [x_ddot; y_ddot; z_ddot], des_state.yaw,
%   des_state.yawdot
%

% =================== Your code goes here ===================

% Thrust
F = 0;
%   state: The current state of the robot with the following fields:
%   state.pos = [x; y; z], state.vel = [x_dot; y_dot; z_dot],
%   state.rot = [phi; theta; psi], state.omega = [p; q; r]
% des_state: The desired states are:
%   des_state.pos = [x; y; z], des_state.vel = [x_dot; y_dot; z_dot],
%   des_state.acc = [x_ddot; y_ddot; z_ddot], des_state.yaw,
%   des_state.yawdot
% k_p(1) = 7.5;
% k_d(1) = 3;
% k_p(2) = 7.5;
% k_d(2) = 3;
% k_p(3) = 10;
% k_d(3) = 2;
% k_p(4) = 48;
% k_d(4) = 7;
% k_p(5) = 48;
% k_d(5) = 7;
% k_p(6) = 10;
% k_d(6) = 10;


kd1 = 3; kd2 = 3 ;kd3 = 2;
kp1 = 7; kp2 = 7; kp3 = 10;

% kd1 = 50; kd2 = 0 ;kd3 = 0;
% kp1 = 200; kp2 = 0; kp3 = 0;

kp_rot = [48;50;10]; kd_rot = [6.5;6.5;10]
%desired acceleration setting
r1_dd_des = des_state.acc(1) + kd1*(des_state.vel(1) - state.vel(1)) + kp1*(des_state.pos(1) - state.pos(1));
r2_dd_des = des_state.acc(2) + kd2*(des_state.vel(2) - state.vel(2)) + kp2*(des_state.pos(2) - state.pos(2));
r3_dd_des = des_state.acc(3) + kd3*(des_state.vel(3) - state.vel(3)) + kp3*(des_state.pos(3) - state.pos(3));

phi_des = (r1_dd_des*sin(des_state.yaw) - r2_dd_des*cos(des_state.yaw))/params.gravity;
theta_des =( r1_dd_des*cos(des_state.yaw) + r2_dd_des*sin(des_state.yaw))/params.gravity;
psi_des = des_state.yaw;

F = (params.mass*params.gravity) + params.mass*r3_dd_des;
% Moment
M = zeros(3,1);
M = kp_rot.*([phi_des;theta_des;psi_des]-state.rot) + kd_rot.*([0;0;des_state.yawdot]-state.omega);
M = (params.I)*M;
% =================== Your code ends here ===================

end
