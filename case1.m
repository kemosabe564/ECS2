%%%%%
%%% 5LIJ0 Embedded Control Systems
%%% Assignment 1 Design 1
%%%%%

close all
clear all 
clc

%% system setup
% frame rate, fh/s
LKAS.fh = 1/100;
LKAS.n_ROI = 8;
LKAS.n_pipeline = 1;
LKAS.n_parallelization = 1;

%% time analysis
% execution time for each task
Time.t_A = 0.5;
Time.t_C = 0.016;
Time.t_isp1 = 10.3;
Time.t_isp2 = 8.65;
Time.t_isp3 = 5;
Time.t_RoID = 0.3;
Time.t_RoIP = 1.4;
Time.t_RoIM = 0.16;

LKAS.tau = (Time.t_isp1 + LKAS.n_ROI * Time.t_isp2 / LKAS.n_parallelization+ Time.t_isp3 + ...
            Time.t_RoID + LKAS.n_ROI * Time.t_RoIP / LKAS.n_parallelization+ Time.t_RoIM)* ...
            1e-3;
LKAS.time = Time;
clear Time

LKAS.h = LKAS.fh * ceil(LKAS.tau / LKAS.fh / LKAS.n_pipeline);

%% controller design
[LKAS_CS.A, LKAS_CS.B, LKAS_CS.C, LKAS_CS.D] = systemModel();

% LKAS_CS.R = 1000;
% LKAS_CS.Q = [0 0 10^20 0];
% [phi_aug,Gamma_aug,C_aug,K,F,K_T,T] = discreteTimeController(LKAS.tau, LKAS.h, LKAS_CS.Q, LKAS_CS.R);
% 
