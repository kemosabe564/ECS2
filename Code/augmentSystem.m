function LKAS_CS = augmentSystem(tau, h, n_pipeline, LKAS_CS)
    
    i = 1;
    if (n_pipeline == 1)
    % sequential style
        for i=1:length(tau)
            sysc = ss(LKAS_CS.A, LKAS_CS.B, LKAS_CS.C, LKAS_CS.D, 'InputDelay', tau);
            sysd = c2d(sysc, h);

            % absorbDelay is the key function to augment        
            sysd_aug = absorbDelay(sysd);

%             Phi_aug{i} = sysd_aug.a;
%             Gamma_aug{i} = sysd_aug.b;
%             C_aug{i} = sysd_aug.c;
            Phi_aug = sysd_aug.a;
            Gamma_aug = sysd_aug.b;
            C_aug = sysd_aug.c;
        end
    else
    % pipelined style
        for i=1:length(tau)
            
        end 
    end
    
    % unify format
%     cell2mat(Phi_aug);
%     cell2mat(Gamma_aug);
%     cell2mat(C_aug);
    LKAS_CS.Phi_aug = Phi_aug;
    LKAS_CS.Gamma_aug = Gamma_aug;
    LKAS_CS.C_aug = C_aug;
end
