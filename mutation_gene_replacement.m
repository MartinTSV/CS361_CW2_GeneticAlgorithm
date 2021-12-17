    %Replacing 1 random gene with random gene.
    %@param mutation_state is used to
    %find whether the gene is digit 1 in the state and apply
    %the proper mutation if 1 it means that the gene's value
    %can only be in range 1-4.
    
    function mutated_chromosomes = mutation_gene_replacement(new_chromosomes)
    
    mutation_state = [1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0];
    for i=1:size(new_chromosomes,1)
        temp_random = randi(30);
        if mutation_state(temp_random) == 1
            new_chromosomes(i,temp_random) = randi(4);
        else
            new_chromosomes(i,temp_random) = randi([0 9]);
        end
        mutated_chromosomes = new_chromosomes;
    end