function new_chromosomes = two_point_crossover(Nchromosomes, selected_parents, pos1, pos2) 
new_chromosomes = zeros(Nchromosomes,30);
 
%Creating offsprings - 2-Point Crossover

i=1;

while i < size(new_chromosomes,1)
        
    c1 = selected_parents(i,:); 
    c2 = selected_parents(i+1,:);    
    chromosomeLength = length(c1);
    
    new_chromosome1 = [c1(1:pos1-1) c2(pos1:pos2 - 1) c1(pos2:chromosomeLength)];
    new_chromosome2 = [c2(1:pos1-1) c1( pos1:pos2-1) c2(pos2:chromosomeLength )];
    
    new_chromosomes(i,:) = new_chromosome1;
    new_chromosomes(i+1,:) = new_chromosome2;  
    
    i = i+2;
end
    
    