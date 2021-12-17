
function string_controller = generate_random_chromosomes(Nchromosomes)
string_controller = zeros(Nchromosomes, 30);

for i=1:Nchromosomes
    %Generate single chromosome
    for z = 1:10
        %Generate state:
        %Ensuring digit #1 in each state is in range 1-4
        %Ensuring digit #2 in each state is in range 0-9
        %Ensuring digit #3 in each state is in range 0-9
        for y = 1:3 
            if y == 1
                gene = randi(4);
            else 
                gene = randi([0 9]);
            end
            temp_state(1,y) = gene;
        end
        if z == 1
            temp_vector = temp_state;
        else  
            temp_vector = [temp_vector temp_state];
        end
    end
    
    %Adding generated chromosome to the string_controller, which holds all
    %available chromosomes. 
    string_controller(i,:) = temp_vector;
end

