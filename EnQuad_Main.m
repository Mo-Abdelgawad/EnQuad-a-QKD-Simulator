%% The order of EnQuad QKD stack is as follows:
%1- Polarizer
%2- Eve’s Intercept and Resend
%3- Channel
%4- Beam Splitter
%5- Polarizing beam splitter
%6- SPAD
%7- Sifting
%8- Security Testing and Recommendations


%% Inputs: 
%1- Number of pulses(photons) to bes sent.It has no limit, it can be 100 or 10,000 or more. Yet, processing time increases directly.
%2- Attack level: min: 0, max:1.
%3- depolarizing_probability: min: 0, max:0.25.
%4- key bits could be generatd as follows: key_bits=round(rand(1,number_of_photons));
%5- Alice basis selection could be generated as using a random binary generator follows: Alice_basis_selection=round(rand(1,number_of_photons));
%   where rectilinear((+) basis) is represented by symbol "0" and Circular ((X) basis) is represented by symbol "1"  
%6- Bob basis selection could be generated in the same manner as Alice's.
 
%% Primary Outputs:   
%1- Reconciliated key: Secret key after reconciliation.
%2- Secret-key bit rate: Ratio of reconciliated key length over sifted key lentgh.
%3- EnQuad simulation time
 
%% Example of the inputs
fprintf('\n---------------------------------------------------------------------------------\n\t\t\t\t-----<<EnQuad Engine Intialization>>-----\n\n');

%fprintf('\n\n\t\t\t\t-----<<QKD in Depolarizing Channel and Individual Intercept-Resend Eve Attacks>>-----\n');
fprintf('\n\t\t\t\t\t\t-----<<Input Conditions>>------\n');


number_of_photons=input('Please input the number of photons to be sent::  ');
while(1)
    if ~isempty(number_of_photons)
        if(number_of_photons>0 && ~mod(number_of_photons,1))
      break;
        else 
         number_of_photons=input('Number of photons must be an integer more than zero:: '); 
        end
    else
       number_of_photons=input('Number of photons must be an integer more than zero:: ');
    end
end

channel_depolarization_probability = input('Please input the depolarizing parameter of your channel::  ');
while(1)
    if ~isempty(channel_depolarization_probability)
        if(channel_depolarization_probability>0 && channel_depolarization_probability<0.25)
      break;
        else 
         channel_depolarization_probability=input('Depolarizing_parameter should be a decimal number in the range of ]0 1/4[:: ');

        end
    else
       channel_depolarization_probability=input('Depolarizing_parameter should be a decimal number in the range of ]0 1/4[:: ');
    end
end

Eve_attack_level=input('Please input Eve attack level of your interest::   ');
while(1)
    if ~isempty(Eve_attack_level)
        if (Eve_attack_level>=0 && Eve_attack_level<=1)
            break;
        else
            Eve_attack_level=input('Eve attack Level should be a decimal number in the range of [0 1]:: ');

        end
    else 
     Eve_attack_level=input('Eve attack Level should be a decimal number in the range of [0 1]:: ');
    end
end

 key_bits=round(rand(1,number_of_photons));
 Alice_basis_selection=round(rand(1,number_of_photons));
 Bob_basis_selection=round(rand(1,number_of_photons));
 
fprintf('\n\t\t\t\t\t\t-----<<Phases>>------\n');
%% 1- Polarizer:
 tic
 Alice_polarized_photons_states = Polarizer( Alice_basis_selection,key_bits,number_of_photons );
 t1=toc;
 disp('Polarizer phase...Done');
 
copy_before_eve=Alice_polarized_photons_states;
%% 2- Eve intercept and resend:

t2=0;
if(Eve_attack_level~=0) 
tic
[Alice_polarized_photons_states,Eve_basis_selection] = Eve_Intercept_and_Resend(Eve_attack_level,number_of_photons,Alice_polarized_photons_states);
[Eve_key]=SPAD(Alice_polarized_photons_states);
t2=toc;
disp('Eve-Intercepet-And-Resend phase...Done');
else
 disp('Eve: None');  
end

%% 3- Channel:
tic
[Alice_polarized_photons_states_after_channel]=Channel(number_of_photons,channel_depolarization_probability,Alice_polarized_photons_states);
t3=toc;
disp('Channel phase...Done');
%% Trial
%channel_capacity  = depolarizing_channel_capacity(number_of_photons, Alice_polarized_photons_states_after_channel,Alice_polarized_photons_states);

%% 4- Beam Splitter:
tic
photon_states_after_beam_splitter = Beam_Splitter( Alice_polarized_photons_states_after_channel,Bob_basis_selection);
t4=toc;
disp('Beam Splitter phase...Done');

%% 5- Polarizing beam splitter
tic
[photons_states_after_polarizing_beam_splitter]= Polarizing_Beam_Splitter(photon_states_after_beam_splitter,number_of_photons);
t5=toc;
disp('Polarizing Beam Splitter...Done');
%% 6- Single photon avalanche diode:
tic
[measured_bits]=SPAD(photons_states_after_polarizing_beam_splitter);
t6=toc;
disp('Single-Photon Avalanche Diode phase...Done');

%% 7- Sifting:
tic
[QBER, positions_of_unmacthed_bases, Alice_sifted_key, Bob_sifted_key ] = Sifting( key_bits, Alice_basis_selection, Bob_basis_selection, measured_bits );
t7=toc;
disp('Sifting phase...Done');
fprintf('Quantum Bit Error Rate is %f.\n',QBER);

%% Elapsed time to sifting
total_elapsed_time=t1+t2+t3+t4+t5+t6+t7;
fprintf('EnQuad simulation time taken to compute the sifted key is %.3f secs.\n',total_elapsed_time);

%% Security testing and required reconcilation efficiency reporting
Security_Testing_and_Reconciliation_Efficiency_Reporting( number_of_photons,Alice_sifted_key,channel_depolarization_probability,Eve_attack_level );

