function [K, F, K_T, T] = discreteTimeController(tau, h, Q, R, LKAS_CS)
    % DISCRETETIMECONTROLLER: to design a discrete-time controller with support
    % for controllability decomposition
    %   Arguments:
    %       tau, h: sensor-to-actuator delay and sampling period
    %		Q, R: (default value = 1) The control tuning parameters  
    %   Returns:
    %       phi_aug, Gamma_aug, C_aug: augmented state-space matrices.
    %		K, F: feedback and feedforward gains
    %		controllable: A boolean flag. 1 - system is controllable, 0 - system is not controllable         
    %   Dependencies (CODES STUDENTS NEED TO WRITE): 
    %		augmentSystem(): to augment the continous-time system
    %		designControlGainsLQR(): computes and returns the feedback K and feedforward gains F.
    %   Usage:
    %		DISCRETETIMECONTROLLER(tau,h)
    %       DISCRETETIMECONTROLLER(tau,h,Q,R)

    %   Author: Sajid Mohamed (s.mohamed@tue.nl)
    %   Organization: Eindhoven University of Technology
    %% Default argument values
    if nargin < 2
        h=tau;
    end
    if nargin < 3
        Q=1; %when using in control design Q=eye(length(A))
    end
    if nargin < 4
        R=1;
    end
%     %% Augment the continuous-time system
%     %% BEGIN: WRITE CODE TO AUGMENT YOUR SYSTEM DEPENDING ON THE CONTROLLER YOU WANT TO USE.
%     [Phi_aug, Gamma_aug, C_aug] = augmentSystem(tau,h); %an example function structure
%     %% END: WRITE CODE TO AUGMENT YOUR SYSTEM DEPENDING ON THE CONTROLLER YOU WANT TO USE.
    %% check for controllability
    controllability = ctrb(LKAS_CS.Phi_aug, LKAS_CS.Gamma_aug);
    det(controllability);
    
    if det(controllability) == 0
        disp('System is Uncontrollable; needs decomposition.');
        [phi_ctr, Gamma_ctr, C_ctr, T, k] = ctrbf(LKAS_CS.Phi_aug, LKAS_CS.Gamma_aug, LKAS_CS.C_aug);
        phi_controlled = phi_ctr(2:end, 2:end);
        Gamma_controlled = Gamma_ctr(2:end);
        C_controlled = C_ctr(2:end);
        %% Design control gains
        % An example for LQR is given below.
        [K_T, F] = designControlGainsLQR(phi_controlled, Gamma_controlled, C_controlled, Q, R); %an example function structure
        
        %% Augmenting uncontrollable states

        K_T = [0 K_T];

        K = K_T*T;
    else
        disp('System is Controllable.');
        [K, F] = designControlGainsLQR(LKAS_CS.Phi_aug, LKAS_CS.Gamma_aug, LKAS_CS.C_aug, Q, R);
    end
end
