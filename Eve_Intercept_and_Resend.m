function [ polarization_states_after_Eve_attack_if_present,Eve_bases_selection ] = Eve_Intercept_and_Resend( Eve_attack_level,number_of_photons,Alice_polarized_photons_states )

    %%
    % Integer number of photons that shall be attacked:
    attack_occ=ceil(Eve_attack_level*number_of_photons);  
    % In general, you can generate N random numbers in the interval (a,b) with the formula r = a + (b-a).*rand(N,1):
    random_pulses_number_attacked= randperm(number_of_photons,attack_occ);%pulse number # kza are attacked
    % Random basis selection for the eve:
    Eve_bases_selection= round(rand(1,attack_occ));
    % Random photons that Eve has measured. 
    selected_indices=Alice_polarized_photons_states(random_pulses_number_attacked);

    %% Computing the output stated of the photons that Eve  has  attacked:   
     new_states=zeros(1,attack_occ);

     for i=1:attack_occ

        if  Eve_bases_selection(1,i)==0 && (selected_indices(1,i)==1 || selected_indices(1,i)==2)
                measured_state=selected_indices(1,i); %no change

        elseif  Eve_bases_selection(1,i)==1 && (selected_indices(1,i)==3 || selected_indices(1,i)==4 )
                measured_state=selected_indices(1,i); %no change

        elseif  Eve_bases_selection(1,i)==0 && (selected_indices(1,i)==3 || selected_indices(1,i)==4)
                measured_state=(1 + (2-1).*round(rand(1,1))); %50% chance horizontal or vertical


        elseif  Eve_bases_selection(1,i)==1 && (selected_indices(1,i)==1 || selected_indices(1,i)==2 )
                measured_state=(3 + (4-3).*round(rand(1,1))); %50% chance right- or left-circular

        end
          new_states(1,i)=measured_state;

     end


    %% Putting the untempered and tempered photons states together. 
    Alice_polarized_photons_states(random_pulses_number_attacked)= new_states;
    polarization_states_after_Eve_attack_if_present= Alice_polarized_photons_states; 


end



