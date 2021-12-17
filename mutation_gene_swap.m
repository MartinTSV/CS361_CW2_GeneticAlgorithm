%Selects a random gene and swaps it with another random gene, cannot swap
%genes, that because of their position in state have a different range. 
function mutated_chromosomes = mutation_gene_swap(new_chromosomes)

mutated_chromosomes = zeros(size(new_chromosomes, 1), 30);
%Follows the state of a chromosome, used to handle cornercases. 
mutation_state = [1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0];
index = zeros(2, 1);

for i = 1:size(new_chromosomes,1)
    c1 = new_chromosomes(i, :);
    
    index(1,1) = randi(30);
    index(2,1) = randi(30);
    
    %If both genes are in state position 1, swap them. 
    if mutation_state(1, index(1,1)) == 1 && mutation_state(1, index(2,1)) == 1
        temp_gene = c1(1,index(1,1));
        c1(1,index(1,1)) = c1(1,index(2,1));
        c1(1,index(2,1)) = temp_gene;
    %If only one of the genes is in state position 1, while loop until you
    %find another one in the same position, from a different state. 
    elseif mutation_state(1, index(1,1)) == 0 && mutation_state(1, index(2,1)) == 1
            while mutation_state(1,index(1,1)) ~= 1
                index(1,1) = randi(30);
            end
            temp_gene = c1(1,index(1,1));
            c1(1,index(1,1)) = c1(1,index(2,1));
            c1(1,index(2,1)) = temp_gene;
    %If only one of the genes is in state position 1, while loop until you
    %find another one in the same position, from a different state. 
    elseif mutation_state(1, index(1,1)) == 1 && mutation_state(1, index(2,1)) == 0
            while mutation_state(1,index(2,1)) ~= 1
                index(2,1) = randi(30);
            end
            temp_gene = c1(1,index(1,1));
            c1(1,index(1,1)) = c1(1,index(2,1));
            c1(1,index(2,1)) = temp_gene;
    %Else, if both genes have range 0 - 9, swap them.         
    else
        temp_gene = c1(1,index(1,1));
        c1(1,index(1,1)) = c1(1,index(2,1));
        c1(1,index(2,1)) = temp_gene;
    end
    mutated_chromosomes(i,:) = c1;
end