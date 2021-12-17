function new_chromosomes = uniform_crossover(Nchromosomes, selected_parents, swapping_threshold)

new_chromosomes = zeros(Nchromosomes, 30);

i = 1; 
while i < size(new_chromosomes, 1)
    c1 = selected_parents(i,:);
    c2 = selected_parents(i+1,:);
    
    chromosomeLength = length(c1);
    %Generate random swapping probability
    swapping_probability = rand(30, 1)';
    
    for z = 1:chromosomeLength
        %Compare swapping probability to swapping threshold. 
        if swapping_probability(1,z) >= swapping_threshold
            temp_gene = c1(1,z);
            c1(1,z) = c2(1,z);
            c2(1,z) = temp_gene;
        end
    end
   
   new_chromosomes(i,:) = c1;
   new_chromosomes(i+1,:) = c2; 
    
    %Switch to next pair of parents. 
    i = i+2;
end