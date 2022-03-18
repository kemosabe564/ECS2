%%%%%
%%% 5LIJ0 Embedded Control Systems
%%% Assignment 1 Design 1
%%%%%

clc;
clear variables;
% close all;
clear all;
format short;


%% configuration & time analysis
% setup
% frame rate 100 frames per second, fh/s
LKAS.fh = 1/100;
LKAS.n_ROI = 8;
LKAS.n_pipeline = 1;
LKAS.n_parallelization = 1;

% time analysis 
LKAS = config(LKAS);
fprintf('System time analysis: tau=%.3f, h=%.3f\n',LKAS.tau, LKAS.h);


%% controller design
[LKAS_CS.A, LKAS_CS.B, LKAS_CS.C, LKAS_CS.D, LKAS_CS.nx] = systemModel();

% agumentation
LKAS_CS = augmentSystem(LKAS.tau, LKAS.h, LKAS.n_pipeline, LKAS_CS);

LKAS_CS.R = 10;
temp = [0 0 0 1 0];
LKAS_CS.Q = 1*(temp') * temp;

[LKAS_CS.K, LKAS_CS.F, LKAS_CS.K_T, LKAS_CS.T] = discreteTimeController(LKAS.tau, LKAS.h, LKAS_CS.Q, LKAS_CS.R, LKAS_CS);


%% Simulation

Reference = 0.02;
CONTROLLER_TYPE = 1;
PATTERN = {1};
SIMULATION_TIME = 30; %in seconds
pipelining = 0;

if pipelining == 0
    simulateDIC(CONTROLLER_TYPE, LKAS.h, LKAS.tau, LKAS_CS.Phi_aug, LKAS_CS.Gamma_aug, LKAS_CS.C_aug, LKAS_CS.K, LKAS_CS.F, PATTERN, SIMULATION_TIME, Reference, LKAS.fh);
else
    simulatePipelinedDIC(h,tauSystemScenarios,phi,Gamma,C_aug,K,F,SIMULATION_TIME,Reference,CONTROLLER_TYPE);
end
