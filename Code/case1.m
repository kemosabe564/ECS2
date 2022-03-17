%%%%%
%%% 5LIJ0 Embedded Control Systems
%%% Assignment 1 Design 1
%%%%%

clc;
clear variables;
close all;
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

LKAS_CS.R = 1000;
LKAS_CS.Q = [0 0 10^20 0];

[LKAS_CS.K, LKAS_CS.F, LKAS_CS.K_T, LKAS_CS.T] = discreteTimeController(LKAS.tau, LKAS.h, LKAS_CS.Q, LKAS_CS.R, LKAS_CS);


%% Simulation


