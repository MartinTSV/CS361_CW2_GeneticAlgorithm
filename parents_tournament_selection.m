function selected_parents = parents_tournament_selection(Nchromosomes, string_controller, g_fitness)

selected_parents = zeros(Nchromosomes,30);
parents = zeros(2,30);
%Used to store the indes of the random parent pulled by algorithm. 
index = zeros(2,1);
for y=1:Nchromosomes
    for i=1:2
        temp_index = randi(Nchromosomes);
        %Won't select the same parent 2 times. 
        while(any(index(:) == temp_index)) 
            temp_index = randi(Nchromosomes);
        end
        parents(i,:) = string_controller(temp_index,:);
        index(i,1) = temp_index;
    end  
        if g_fitness(index(1)) > g_fitness(index(2))
            selected_parents(y,:) = parents(1,:);
        else
            selected_parents(y,:) = parents(2,:);
        end
end