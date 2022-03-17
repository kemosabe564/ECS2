function [K,F] = designControlGains(Ad, Bd, Cd, Q, R, LKAS_CS)
    
    n = length(Ad);
    Q = 10*(Cd')*Cd;
    R = 100;
    
    %Design using dare
    [X, L, G] = dare(Ad, Bd, Q,R);
    K_controlled = -G;
    
    F{i} = 1 / (Cd * inv(eye(n) - (Ad{i} + Bd{i} * K_controlled)) * Bd);
    K{i} = K_controlled;   
end    
    