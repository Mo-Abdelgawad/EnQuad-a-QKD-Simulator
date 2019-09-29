function [ measured_bits ] =SPAD(photons_states_after_polarizing_beam_splitter)

%% Initilization
measured_bits=zeros(size(photons_states_after_polarizing_beam_splitter));
%% Computing measured bits
measured_bits(photons_states_after_polarizing_beam_splitter==1)=0; 
measured_bits(photons_states_after_polarizing_beam_splitter==2)=1;
measured_bits(photons_states_after_polarizing_beam_splitter==3)=0;
measured_bits(photons_states_after_polarizing_beam_splitter==4)=1;



