function [] = Security_Testing_and_Reconciliation_Efficiency_Reporting( number_input_photons,Alice_sifted_key, depolarizing_parameter,eve_attack_level )

fprintf('\n\n\t\t\t\t-----<<Security Testing and Recommendation Session Intiation>>-----\n');
   binary_entropy= @(x)(-x*log2(x)-(1-x)*log2(1-x));
   transition_probaililty_alice_bob=(eve_attack_level/4)+(((2*depolarizing_parameter)/3)*(2-eve_attack_level));
   
   %transition probability between Alice and eve
   transition_probaililty_alice_eve=0.5-(eve_attack_level/4); 
   
   %mutual information between ALice and Bob
   h_qber=binary_entropy(transition_probaililty_alice_bob);
   alice_bob_mutual_information=1-h_qber;
   
   %mutual information between Alice and Eve
   h_half_minus_q_eve=binary_entropy(transition_probaililty_alice_eve);
   alice_eve_mutual_information=1-h_half_minus_q_eve;
  
  %abnormals
   %alice_bob_mutual_information(isnan(alice_bob_mutual_information))= 1; % at transition_alice_bob=0
   
   %test security
   diff=depolarizing_parameter<((3/4)*((1-eve_attack_level)/(2-eve_attack_level)));
   secure_question=(diff); %logical
   
   mutual_information_alice_bob_bits= alice_bob_mutual_information*number_input_photons;
   mutual_information_alice_eve_bits= alice_eve_mutual_information*number_input_photons;
  fprintf('\n\t\t\t\t\t\t-----<<Reporting Mutual Information and security>>-----\n');
   fprintf( 'The mutual information between Alice and Bob is %f bits.\n', mutual_information_alice_bob_bits)
   fprintf( 'The mutual information between Alice and Eve is %f bits.\n', mutual_information_alice_eve_bits)

   
  if secure_question==1
       disp('Hence, the communication is secure. You may proceed to the post-prcessing classical schemes.');
  else
     disp('Hence, the communication is unsecure. You should abort the protocol.');
     answer=input('Do you want to calculate the acceptable range of channel depolarizing parameter at your input attack-level to satify security? [y/n]:: ','s');
         if ~isempty(answer)
            if (answer=='y' || answer=='Y')
                 fprintf('Processing...')
                 
                 depol_threshold=((3/4)*((1-eve_attack_level)/(2-eve_attack_level)));
                   if depol_threshold==0
                       fprintf('Done...No acceptable range is found, protocol abortion at this attack level in any channel is a must.\n');
                   else
                       fprintf('Done...Channel depolarizing parameter should be %f at maximum \n', depol_threshold);

                   end
                  
            end
         end
  end

   
 %% Calculating Theoritical Key length
if(diff)
    fprintf('\n\t\t\t\t\t\t-----<<Reporting Key Rates>>-----\n');
   kth=( h_half_minus_q_eve- h_qber);
   kth_length=  kth*numel(Alice_sifted_key);
   fprintf('The theoritical (maximum) key-rate at your input conditions is %f.\ni.e. The theoritcal key-length is %0.2f out of your %0.1f input bits.\n',  kth, kth_length,number_input_photons);


     %% Calculating reconciliation efficiency for a target secret-key rate
       fprintf('\n\t\t\t\t\t\t-----<<Reporting Required Reconciliation Efficiency for a Given Target Secret-Key Rate>>-----\n');
       answer=input('Do you have a target key rate? [y/n]:: ','s');
      if ~isempty(answer)
             if (answer=='y' || answer=='Y')
                  target_key_rate = input('Please input your target secret-key rate::  ');

                     while(1)
                        if ~isempty(target_key_rate)
                            if(target_key_rate<1 && target_key_rate>0)
                          break;
                            else 
                            target_key_rate=input('Target key-rate should be a decimal in the range of ]0 1[ please enter it::');
                            end
                        else
                            target_key_rate=input('Target key-rate should be a decimal in the range of [0 1] please enter it::');
                        end
                     end

                     if(target_key_rate<kth)
                           reconciliation_eff=(h_qber/(h_half_minus_q_eve-target_key_rate));
                           fprintf('The required efficiency of the reconciliation protocol to achieve your target key-rate is %0.2f at minimum.\ni.e. The maximum allowable bits to be leaked in the post-processing schemes is %0.2f.\n',reconciliation_eff, (1/reconciliation_eff)*(h_qber)*numel(Alice_sifted_key));
                      else
                             answer=input('Your target key-rate is larger than the theoritical key-rate!\nHence, it is not achievable at your input conditions; you might have to lower the depolarizing parameter.\nDo you want to calculate the depolarizing paramter range that could achieve your target key-rate? [y/n]:: ','s');
                                       if ~isempty(answer)
                                          if (answer=='y' || answer=='Y')
                                              fprintf('Processing... ');
                                               syms x ;
                                               lhs= -x*log2(x)-(1-x)*log2(1-x);       
                                               rhs= -target_key_rate+ h_half_minus_q_eve;
                                               eqn= (lhs==rhs);
                                               solx = vpasolve(eqn, x);
                                               depol_threshold=(double(solx)-(eve_attack_level/4))*(3/(2*(2-eve_attack_level)));
                                               fprintf('Done\n');
                                               if (depol_threshold <=0 || imag(depol_threshold)~=0 || depol_threshold>depolarizing_parameter)
                                                  fprintf('Your target key-rate is not achievable even by lowering the depolarizing paramter, it needs to be lower than the theoritical key rate. \n');
                                               else
                                                  fprintf('To achieve your target key-rate, the depolarizing paramter should be less than %f.\n', depol_threshold);
                                               end
                                          end
                                       end
                     end    
            end
      end
end

 fprintf('\n\t\t\t\t-----<<End of this Simulation Session>>-----\n');