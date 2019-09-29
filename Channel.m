function [ photons_states_after_channel ] = Channel(numbers_of_photons,channel_depolarization_probability,photons_states_before_channel )

%% Intialization
photons_states_after_channel=zeros(4,numbers_of_photons);

%% Computing states after channel
% For horizontal state:
photons_states_after_channel(:,(photons_states_before_channel==1))=repmat([1-(2/3)*channel_depolarization_probability; (2/3)*channel_depolarization_probability;  0.5; 0.5],[1,sum(photons_states_before_channel==1)]);
% For vertical state:
photons_states_after_channel(:,(photons_states_before_channel==2))=repmat([(2/3)*channel_depolarization_probability;  1-(2/3)*channel_depolarization_probability; 0.5; 0.5],[1,sum(photons_states_before_channel==2)]);
% For circular-right state:
photons_states_after_channel(:,(photons_states_before_channel==3))=repmat([0.5; 0.5; 1-(2/3)*channel_depolarization_probability;  (2/3)*channel_depolarization_probability],[1,sum(photons_states_before_channel==3)]);
% For circular-left state:
photons_states_after_channel(:,(photons_states_before_channel==4))=repmat([0.5; 0.5; (2/3)*channel_depolarization_probability;  1-(2/3)*channel_depolarization_probability],[1,sum(photons_states_before_channel==4)]);
