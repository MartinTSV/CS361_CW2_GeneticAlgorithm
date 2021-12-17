%Randomly adds or substracts based on random_operation.
%If random_operation > 0.5, algorithim will proceed with addtion, however
%if it reaches a cornercase where a gene is the first digit from a state and the
%addition would set it's value to 5, which is illegal, addition is changed
%to substraction.

function mutated_chromosomes = mutation_gene_addorsubs(new_chromosomes)

Nchromosomes = size(new_chromosomes, 1);
mutated_chromosomes = zeros(Nchromosomes, 30);


mutation_state = [1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0];
for i = 1:Nchromosomes
    c1 = new_chromosomes(i, :);
    
    rand_index = randi(30);
    %If random operation > 0.5 add, else substract. 
    random_operation = rand(1);
    if mutation_state(1, rand_index) == 1
        if random_operation > 0.5
            %If c1 + 1 is greater than 4, substract instead, else add. 
            if c1(1,rand_index) + 1 > 4
                c1(1,rand_index) = c1(1,rand_index) - 1;
            else
                c1(1,rand_index) = c1(1,rand_index) + 1; 
            end
        else
            %If c1 - 1 is less than 1, add, else substract. 
            if c1(1,rand_index) - 1 < 1
                c1(1,rand_index) = c1(1,rand_index) + 1;
            else
                c1(1,rand_index) = c1(1,rand_index) - 1; 
            end
        end
    else
        if random_operation > 0.5
            %If c1 + 1 is greater than 9, substract instead, else add.
            if c1(1,rand_index) + 1 > 9
                c1(1,rand_index) = c1(1,rand_index) - 1;
            else
                c1(1,rand_index) = c1(1,rand_index) + 1;
            end
        else
            %If c1 - 1 is less than 0, add, else substract.
            if c1(1,rand_index) - 1 < 0
                c1(1,rand_index) = c1(1,rand_index) + 1;
            else
                c1(1,rand_index) = c1(1,rand_index) - 1;
            end
        end    
    end
    
    mutated_chromosomes(i, :) = c1; 
end

