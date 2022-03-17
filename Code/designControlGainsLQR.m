function [K,F] = designControlGains(Ad, Bd, Cd, Q, R, LKAS_CS)
    
    n=length(Ad);
    Q = 10*(Cd')*Cd;
    R =10;
    
    %Design using dare
    [X, L, G] = dare(Ad, Bd, Q,R);
    K_controlled = -G;
    
    F = 1 / (Cd * inv(eye(n) - (Ad + Bd * K_controlled)) * Bd);
    K = K_controlled;   
end    
    