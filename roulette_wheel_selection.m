function selected_parents = roulette_wheel_selection(Nchromosomes, string_controller, g_fitness)

probability = zeros(Nchromosomes, 1);
cumulative_probability = zeros(Nchromosomes, 1);
selected_parents = zeros(Nchromosomes, 30);
parent = zeros(1,30);
%Calculate probability
for i = 1:Nchromosomes
    probability(i,1) = g_fitness(i,1)/sum(g_fitness);
end
%Calculate cumulative probability
for i = 1:Nchromosomes
    if i == 1
        cumulative_probability(i,1) = probability(i, 1); 
    else
        cumulative_probability(i,1) = probability(i,1) + cumulative_probability(i-1, 1);
    end
end

%Select pairs of parents and store them. 
for i = 1:Nchromosomes
    rand_num = rand(1);
    for z = 1:Nchromosomes
        if cumulative_probability(z,1) >= rand_num
            parent = string_controller(z,:);
            break
        end
    end
    selected_parents(i,:) = parent;
end

