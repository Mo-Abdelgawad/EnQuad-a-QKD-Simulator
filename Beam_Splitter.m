function [ photons_states_after_beam_splitter ] =Beam_Splitter(photons_states_after_channel,Alice_basis_selection)

%photons_states_after_channel  is photons states after channel 
%c  is Alice_random_basis_selection
%photons_states_after_beam_splitter  is the photon state after beam splitter. Beam Splitters act as  random selector for measuring bases.

 photons_states_after_beam_splitter=photons_states_after_channel;
 [~,rect]=find(Alice_basis_selection==0); %rectlinear bases positions
 [~,circ]=find(Alice_basis_selection==1); %circ bases positions
 
 photons_states_after_beam_splitter(3:4,rect)=0; % if rectlinear base is selected for measurement, then the outcomes of Circular base will never happen, i.e. probability=0. (Circular bases outcomes are those in elements #3 and #4 in the state vector of the photon).
 
 photons_states_after_beam_splitter(1:2,circ)=0; %if Circular base is selected for measurement, then the outcomes of rectlinear base will never happen, i.e. probability=0. (Rectlinear bases outcomes are those in element #3 and #4 in the state vector of the photon).
 

end

