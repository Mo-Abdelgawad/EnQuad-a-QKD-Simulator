function [ photons_states_after_polarizing_beam_splitter ] = Polarizing_Beam_Splitter(photons_states_after_beam_splitter,number_of_photons)

%% Intialization
photons_states_after_polarizing_beam_splitter=zeros(1,number_of_photons);
r=rand(1,number_of_photons);

 for i=1:number_of_photons
    prob=photons_states_after_beam_splitter(:,i);
    photons_states_after_polarizing_beam_splitter(i) = sum(r(i) >= cumsum([0, prob']));
 end

%% Explanation of  -- photons_states_after_polarizing_beam_splitter(i)= sum(r(i) >= cumsum([0, prob']))-- :
% If you have a vector representing probabilties, say [0.3 ; 0 ;0.7 ; 0],
% then the output will likely be the value of the position holding the highest probability. 
% In the case of this example, output is "3" since 0.7 is the highest probability and lies as the 3rd element in the vector.
% In all cases, you will only have two non-zero probabilties and the other two elemnts are zeros. 
% The process is random, i.e the output of the previous example might be "1" corresponding to the pribability of "0.3" position as the 1st element in the vector. But this is less likely to happen.
 




 
end