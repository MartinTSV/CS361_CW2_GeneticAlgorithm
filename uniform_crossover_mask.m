function new_chromosomes = uniform_crossover_mask(Nchromosomes, selected_parents)

new_chromosomes = zeros(Nchromosomes, 30);
offsprings = zeros(2,30);

i = 1; 
while i < size(new_chromosomes, 1)
    c1 = selected_parents(i,:);
    c2 = selected_parents(i+1,:);
    
    chromosomeLength = length(c1);
    %Create 2 offsprings.
    for y = 1:2
        %Generate a random mask. 
        mask = randi([0 1], 1, 30);
        for z = 1:chromosomeLength
            if mask(1,z) == 1
                offsprings(y,z) = c1(1,z);
            else
                offsprings(y,z) = c2(1,z);
            end
        end
    end
   
   new_chromosomes(i,:) = offsprings(1,:);
   new_chromosomes(i+1,:) = offsprings(2,:); 
    
    %Switch to next pair of parents. 
    i = i+2;
end