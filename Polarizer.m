
function [ Alicce_polarized_photon_states ] = Polarizer( Alice_basis_selection,Key_bits,number_of_photons )
%% Paramters generations
% 1- key bits could be generatd as follows: key_bits=round(rand(1,number_of_photons));
% 2- Alice basis selection could be generated as follows: Alice_basis_selection=round(rand(1,number_of_photons));
%    where %rectilinear((+) basis) is represented by symbol "0" and Circular ((X) basis) is represented by symbol "1"  
% 3- Alice_basis_selection could be generated in the same manner: Alice_basis_selection=round(rand(1,number_of_photons));

%% Intialization:
Alicce_polarized_photon_states=zeros(1,number_of_photons);

%% Computing the polarized states
% In BB84 we have 4 states, let's encode them as follows:
% Horizontal: state=1,
% Vertical: state=2,
% Right_circular: state=3
% Left_circular: state=4.

for i=1:number_of_photons;
    
    if Alice_basis_selection(1,i)==0 && Key_bits(1,i)==0
             state=1; %horizontally_polarized% angle=0: bit0
    elseif Alice_basis_selection(1,i)==0 && Key_bits(1,i)==1
            state=2; %vertically_polarized1 angle=90: bit1
    elseif Alice_basis_selection(1,i)==1 && Key_bits(1,i)==0  
            state=3; %right-circular  %angle=45: bit0
    elseif Alice_basis_selection(1,i)==1 && Key_bits(1,i)==1 
            state=4; %left_circular  %angle =-45: bit 1
    
    end
     Alicce_polarized_photon_states(1,i)=state;
end

end