%[*]Options
%Selection option 1 is Roulette Wheel Selection
%Selection option 2 is Parents Tournament Selection with Replacement
%Selection option 3 is Parents Tournament Selection without Replacement (default)
selection_option = 3;
%Crossover option 1 is Uniform Crossover
%Crossover option 2 is Uniform Crossover with Mask
%Crossover option 3 is 2-Point Crossover (default)
crossover_option = 3; 
%Mutation option 1 is Mutation by gene Replacement
%Mutation option 2 is Mutation by gene Swap
%Mutation option 3 is Mutation by Addition or Substraction (default)
mutation_option = 3; 

%For 2-point crossover
pos1 = 11;
pos2 = 21;

%Tuning
Nchromosomes = 20;
swapping_threshold = 0.5;
fitness_condition = 70;

Ngen = 1;
hero_ant_trail = zeros(200,2);

%Options Menu, default options already initiated. 
disp("Would you like to customize your settings?");
disp("1. Default settings");
disp("2. Options");
x = input("Your choice: ");
continue_cycle = 0;
if x == 2
    while continue_cycle == 0
        disp(" ");
        disp("[*] Options Menu")
        disp("1. Selection Operator");
        disp("2. Crossover Operator");
        disp("3. Mutation Operator");
        disp("4. Variables");
        disp("5. Continue");
        choice_menu = input("Your choice: ");
        if choice_menu == 1
            disp(" ");
            disp("[*] Selection Operators");
            disp("1. Roulette Wheel Selection");
            disp("2. Parents Tournament Selection with Replacement");
            disp("3. Parents Tournament Selection without Replacement");
            choice = input("Your choice: ");
            %Select selection operator.
            if choice == 1
                selection_option = 1;
                disp(" ");
                disp("[!] You've selected Roulette Wheel Selection.");
            elseif choice == 2
                selection_option = 2;
                disp(" ");
                disp("[!] You've selected Parents Tournament Selection with Replacement.");
            elseif choice == 3
                selection_option = 3;
                disp(" ");
                disp("[!] You've selected Parents Tournament Selection without Replacement.");
            else
                disp(" ");
                disp("[!] Invalid argument, please try again.");
            end
            
        end
        %Select crossover operator
        if choice_menu == 2
            disp(" ");
            disp("[*] Crossover Operators");
            disp("1. Uniform Crossover");
            disp("2. Uniform Crossover with Mask");
            disp("3. 2-Point Crossover");
            choice = input("Your choice: ");
            if choice == 1
                crossover_option = 1;
                disp(" ");
                disp("[!] You've selected Uniform Crossover.");
            elseif choice == 2
                crossover_option = 2;
                disp(" ");
                disp("[!] You've selected Uniform Crossover with Mask.");
            elseif choice == 3
                crossover_option = 3;
                disp(" ");
                disp("[!] You've selected 2-Point Crossover.");
                disp(" ");
                disp("[*]Please select points within range 1 - 30.")
                %Select first point. 
                x = input("First point: ");
                if x <= 0 || x>=30
                    disp("[!] Invalid point, input not registered.");
                else
                    pos1 = x;
                    disp("[!] First point set at " + x + ".");
                end
                %Select second point.
                x = input("Second point: ");
                if x <= 0 || x>=30
                    disp("[!] Invalid point, input not registered.");
                else
                    pos2 = x;
                    disp("[!] Second point set at " + x + ".");
                end
            else
                disp("[!] Invalid argument, please try again.");
            end
            
        end
        %Select mutation operator
        if choice_menu == 3
            disp(" ");
            disp("[*] Mutation Operators");
            disp("1. Mutation by Gene Replacement");
            disp("2. Mutation by Gene Swap");
            disp("3. Mutation by Addition or Substraction");
            choice = input("Your choice: ");
            if choice == 1
                mutation_option = 1; 
                disp(" ");
                disp("[!] You've selected Mutation by Gene Replacement.");
            elseif choice == 2
                mutation_option = 2; 
                disp(" ");
                disp("[!] You've selected Mutation by Gene Swap.");
            elseif choice == 3
                mutation_option = 3; 
                disp(" ");
                disp("[!] You've selected Mutation by Addition or Substraction.");
            else
                disp("[!] Invalid argument, please try again.");
            end  
        end
        %Change variables. 
        if choice_menu == 4
            disp(" ");
            disp("[*] Variable Options");
            disp("1. Change desired fitness value.");
            disp("2. Change chromosome number in generations.");
            choice = input("Your choice: ");
            if choice == 1
                disp(" ");
                fitness_condition = input("Enter desired fitness value: ");
            elseif choice == 2
                disp(" ");
                Nchromosomes = input("Enter desired number of chromosomes for a generation: ");
            end
        end
        %Exit menu
        if choice_menu == 5
            continue_cycle = 1;
        end
    end
end
g_fitness = zeros(Nchromosomes, 1);

%Generate random chromosomes. 
string_controller = generate_random_chromosomes(Nchromosomes);

generation_max_fitness = 0;
while max(g_fitness) <= fitness_condition
    %Get current generation's fitness.
    for i=1:Nchromosomes
        [fitness, trail] = simulate_ant(dlmread("muir_world.txt",' '), string_controller(i,:));
        %Stores fitness values in current generation.
        g_fitness(i,1) = fitness;
        if fitness > max(generation_max_fitness)
            hero_ant_trail = trail;
        end 
    end
  
    %Stores best fitness in each generation.
    generation_max_fitness(1,Ngen) = max(g_fitness);
    
    %Parents Selection
    if selection_option == 1
        selected_parents = roulette_wheel_selection(Nchromosomes, string_controller, g_fitness);
        if Ngen == 1
            disp("------------");
            disp("[*] Parents Selection: RWS");
        end
    elseif selection_option == 2
        selected_parents = parents_tournament_selection_replacement(Nchromosomes, string_controller, g_fitness);
        if Ngen == 1
            disp("------------");
            disp("[*] Parents Selection: TS with Replacement");
        end
    elseif selection_option == 3
        selected_parents = parents_tournament_selection(Nchromosomes, string_controller, g_fitness);
        if Ngen == 1
            disp("------------");
            disp("[*] Parents Selection: TS without Replacement");
        end
    end
    
    %Crossover - offsprings creation. 
    if crossover_option == 1
        new_chromosomes = uniform_crossover(Nchromosomes, selected_parents, swapping_threshold);
        if Ngen == 1
            disp("------------");
            disp("[*] Crossover: Uniform Crossover");
        end
    elseif crossover_option == 2
        new_chromosomes = uniform_crossover_mask(Nchromosomes, selected_parents);
        if Ngen == 1
            disp("------------");
            disp("[*] Crossover: Uniform Crossover with Mask");
        end
    elseif crossover_option == 3
        new_chromosomes = two_point_crossover(Nchromosomes, selected_parents, pos1, pos2);
        if Ngen == 1
            disp("------------");
            disp("[*] Crossover: 2-Point Crossover at " + pos1 + " and " + pos2 + "");
        end
    end
    
    %Mutating Chromosomes
    if mutation_option == 1
        mutated_chromosomes = mutation_gene_replacement(new_chromosomes);
        if Ngen == 1
            disp("------------");
            disp("[*] Mutation: Gene Replacement");
        end
    elseif mutation_option == 2
        mutated_chromosomes = mutation_gene_swap(new_chromosomes);
        if Ngen == 1
            disp("------------");
            disp("[*] Mutation: Gene Swap");
        end
    elseif mutation_option == 3
        mutated_chromosomes = mutation_gene_addorsubs(new_chromosomes);
        if Ngen == 1
            disp("------------");
            disp("[*] Mutation: Addition or Substraction");
        end
    end
    if Ngen == 1
         %Also display variables.
         disp("------------");
         disp("[*] Desired fitness: " + 100*fitness_condition/89 + "%");
         disp("[*] n chromosomes in g: " + Nchromosomes);
    end
    %Show plot.
    hf = figure(1); set(hf,'Color',[1 1 1]);
    hp = plot(1:Ngen,100*generation_max_fitness/89,'r');
    set(hp,'LineWidth',2);
    axis([0 Ngen 0 100]); grid on;
    xlabel('Generation number');
    ylabel('Ant fitness [%]');
    title('Ant fitness as a function of generation');
    
    %Replacement strategy - Elitism. 
    for i = 1:2
        %Get maximum value.
        gen_max_value = max(g_fitness);
        %Find the index in g_fitness, in order to locate chromosome in
        %string_controller.
        index_max_value = find(g_fitness == gen_max_value);
        index_max_value = index_max_value(1,1); %In case there are multiple values. 
        %Swap a random chromosome from the new generation.
        mutated_chromosomes(randi(Nchromosomes-2),:) = string_controller(index_max_value,:);
        %Delete replaced chromosome, so the next best one can be found on
        %the following iteration. 
        string_controller(index_max_value,:) = [];
        g_fitness(index_max_value) = [];
    end
    
    string_controller = mutated_chromosomes;
    Ngen = Ngen + 1; 
end

%Show hero ant trail and fitness score. 
%read the John Moir Trail (world)
filename_world = 'muir_world.txt';
world_grid = dlmread(filename_world,' ');
% display the John Moir Trail (world)
world_grid = rot90(rot90(rot90(world_grid)));
xmax = size(world_grid,2);
ymax = size(world_grid,1);
hf = figure(2); set(hf,'Color',[1 1 1]);

for y=1:ymax
     for x=1:xmax
        if(world_grid(x,y) == 1)
            h1 = plot(x,y,'sk');
            hold on
        end
     end
end
grid on
% display the fittest Individual trail
for k=1:size(hero_ant_trail,1)
    h2 = plot(hero_ant_trail(k,2),33-hero_ant_trail(k,1),'*m');
    hold on
end
axis([1 32 1 32])
title_str = sprintf('John Muri Trail - Hero Ant fitness %d%% in %d generation ',uint8(100*max(g_fitness)/89), Ngen);
title(title_str)
lh = legend([h1 h2],'Food cell','Ant movement');
set(lh,'Location','SouthEast');
