function [ QBER, positions_of_unmacthed_bases,Alice_sifted_key, Bob_sifted_key ] = Sifting( key_bits, Alice_basis_selection, Bob_basis_selection, measured_bits )

%% Computing  sifted keys
% Sifted keys for Bob and Alice are the keys after discarding bits of unmatched bases.
[~, positions_of_unmacthed_bases]=find(Alice_basis_selection~=Bob_basis_selection);
Alice_sifted_key=key_bits(setdiff(1:end,positions_of_unmacthed_bases));
Bob_sifted_key=measured_bits(setdiff(1:end,positions_of_unmacthed_bases));

%% Computing QBER
%Quantum Bit Errot Rate (QBER), defined as the number of error bits in Alice and Bob sifted Keys / the totol length of the sifted key) min: 0, max:1.
QBER=sum(Alice_sifted_key~=Bob_sifted_key)/numel(Alice_sifted_key);


end

