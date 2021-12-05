%string_controller = [1 1 3 2 7 6 3 1 5 1 8 4 1 7 6 3 4 6 3 1 1 1 5 8 4 4 9 2 9 3];
%Tuning
Ngen = 100;
Nchromosomes = 6;
%Generate 5 random chromosomes
string_controller = zeros(Nchromosomes,30);
for i=1:5
    temp_vector = randi([0 9],1,30);
    string_controller(i,:) = temp_vector;
end

g_fitness = zeros(Nchromosomes,1);
for z=1:Ngen
    %Evaluating fitness
    for i=1:Nchromosomes
        [fitness, trail] = simulate_ant(dlmread("muir_world.txt",' '), string_controller(i,:));
        g_fitness(i,1) = fitness;
    end
    

    %Selecting parents - Tournament Selection
    selected_parents = zeros(Nchromosomes,30);
    parents = zeros(2,30);
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
    
    new_chromosomes = zeros(Nchromosomes,30);
    %Creating offsprings - 2-Point Crossover
        
        c1 = selected_parents(1,:);
        c2 = selected_parents(2,:);
        c3 = selected_parents(3,:);
        c4 = selected_parents(4,:);
        c5 = selected_parents(5,:);
        c6 = selected_parents(6,:);
        
        chromosomeLength = length(c1);

        pos1 = 3;
        pos2 = 15;

        new_chromosome1 = [c1(1:pos1-1) c2(pos1:pos2 - 1) c1(pos2:chromosomeLength)];
        new_chromosome2 = [c2(1:pos1-1) c1( pos1:pos2-1) c2(pos2:chromosomeLength )];
        
        new_chromosome3 = [c3(1:pos1-1) c4(pos1:pos2 - 1) c3(pos2:chromosomeLength)];
        new_chromosome4 = [c4(1:pos1-1) c3( pos1:pos2-1) c4(pos2:chromosomeLength )];
        
        new_chromosome5 = [c5(1:pos1-1) c6(pos1:pos2 - 1) c5(pos2:chromosomeLength)];
        new_chromosome6 = [c6(1:pos1-1) c5( pos1:pos2-1) c6(pos2:chromosomeLength )];

        new_chromosomes(1,:) = new_chromosome1;
        new_chromosomes(2,:) = new_chromosome2;
        new_chromosomes(3,:) = new_chromosome3;
        new_chromosomes(4,:) = new_chromosome4;
        new_chromosomes(5,:) = new_chromosome5;
        new_chromosomes(6,:) = new_chromosome6;

    %Mutating Chromosomes
    for i=1:size(new_chromosomes,1)
        temp_random = randi(30);
        condition = new_chromosomes(i,temp_random) + 1;
        if condition >= 9
            new_chromosomes(i,temp_random) = new_chromosomes(i,temp_random) - 1;
        else
            new_chromosomes(i,temp_random) = new_chromosomes(i,temp_random) + 1;
        end
    end
    
    string_controller = new_chromosomes;
end
% 
% %{[fitness, trail] = simulate_ant(dlmread("muir_world.txt",' '), string_controller);
% Ngen = 1;
% best_fitness = fitness;
% fitness_data = [fitness, Ngen];
% 
% hf = figure(1); set(hf,'Color',[1 1 1]);
% hp = plot(1:Ngen,100*fitness_data/89,'r');
% set(hp,'LineWidth',2);
% 
% axis([0 Ngen 0 100]); grid on;
% xlabel('Generation number');
% ylabel('Ant fitness [%]');
% title('Ant fitness as a function of generation');
% 
% % read the John Moir Trail (world)
% filename_world = 'muir_world.txt';
% world_grid = dlmread(filename_world,' ');
% % display the John Moir Trail (world)
% world_grid = rot90(rot90(rot90(world_grid)));
% xmax = size(world_grid,2);
% ymax = size(world_grid,1);
% hf = figure(2); set(hf,'Color',[1 1 1]);
% for y=1:ymax
%     for x=1:xmax
%         if(world_grid(x,y) == 1)
%             h1 = plot(x,y,'sk');
%             hold on
%         end
%     end
% end
% grid on
% % display the fittest Individual trail
% for k=1:size(trail,1)
%     h2 = plot(trail(k,2),33-trail(k,1),'*m');
%     hold on
% end
% axis([1 32 1 32])
% title_str = sprintf("John Muri Trail - Hero Ant fitness %d%% in %d generation ",uint8(100*best_fitness/89), Ngen);
% title(title_str)
% lh = legend([h1 h2],'Food cell','Ant movement');
% set(lh,'Location','SouthEast');%}