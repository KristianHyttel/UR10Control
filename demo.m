%% Description
% This script is to be used together with a UR script, running on the
% UR-controller, called "matlab_rsa_x.x.urp".
%
% Look in "README.txt" for detailed instructions on how to set it up.

%% Setup
clear;
clc;

% Get the robot ip from the teach pendant: File -> About
robot_ip = '172.31.1.115';

sock = tcpip(robot_ip, 30000, 'NetworkRole', 'server');
fclose(sock);
disp('Press Play on robot');
fopen(sock);
disp('Connected!');

%% Move

% Read pose:
fprintf('Reading initial pose...\n');
posC = urReadPosC(sock);
%fprintf('posC = ');disp(posC);
posJ = urReadPosJ(sock);
%fprintf('posJ = ');disp(posJ);
x1 = 231;
y1 = -124;
z1 = 663;
rx1 = -2.44*-1;
ry1 = 0.81*-1;
rz1 = 1.52*-1;

urMoveL(sock,[x1,y1,z1],[rx1,ry1,rz1]);
%%

for i = 1:inf
    fprintf('Moving (%d)...\n',i);
    
    % Change velocity and acceleration:
    urChangeVel(sock, [0.1,0.1]);
    
    % Move to new cartesian position:
    urMoveL(sock,[x1+100,y1+100,z1+100],[rx1,ry1,rz1]);
    
    urMoveL(sock,[x1,y1,z1],[rx1,ry1,rz1]);
end


% Close connection:
% fclose(sock);
