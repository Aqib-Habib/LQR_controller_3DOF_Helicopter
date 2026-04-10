% exercise1.m
% This script solves the following optimization problem using YALMIP and sedumi:
%   minimize: - (x1 + x2)
%   subject to:
%       0 <= x1 <= 1,
%       0 <= x2 <= 2,
%       2*x1 + x2 <= 2

clear; clc;
yalmip('clear');

% Define decision variables
x = sdpvar(2,1);

% Define constraints
Constraints = [0 <= x(1) <= 1, 0 <= x(2) <= 2, 2*x(1) + x(2) <= 2];

% Define objective function
Objective = -(x(1) + x(2));

% Set solver options for sedumi
options = sdpsettings('solver','sedumi','verbose',1);

% Solve the optimization problem
sol = optimize(Constraints, Objective, options);

% Check and display results
if sol.problem == 0
    optimal_x = value(x);
    optimal_value = value(Objective);
    fprintf('Optimal solution: x1 = %f, x2 = %f\n', optimal_x(1), optimal_x(2));
    fprintf('Optimal objective value: %f\n', optimal_value);
else
    disp('Solver encountered an issue:');
    sol.info
end
