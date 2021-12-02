string_controller = [1 1 3 2 7 6 3 1 5 1 8 0 1 7 6 3 4 6 1 1 0 1 5 8 4 4 9 2 9 3];


[fitness, trail] = simulate_ant(dlmread("muir_world.txt",' '), string_controller);
Ngen = 1;
best_fitness = fitness;
fitness_data = [fitness, Ngen];

hf = figure(1); set(hf,'Color',[1 1 1]);
hp = plot(1:Ngen,100*fitness_data/89,'r');
set(hp,'LineWidth',2);

axis([0 Ngen 0 100]); grid on;
xlabel('Generation number');
ylabel('Ant fitness [%]');
title('Ant fitness as a function of generation');

% read the John Moir Trail (world)
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
for k=1:size(trail,1)
    h2 = plot(trail(k,2),33-trail(k,1),'*m');
    hold on
end
axis([1 32 1 32])
title_str = sprintf("John Muri Trail - Hero Ant fitness %d%% in %d generation ",uint8(100*best_fitness/89), Ngen);
title(title_str)
lh = legend([h1 h2],'Food cell','Ant movement');
set(lh,'Location','SouthEast');