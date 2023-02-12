clear;
clc;

% Generate 20 random nodes with x,y coordinates
nodes = 20;
coords = rand(nodes,2);

% Initialize the solution as a random permutation of the nodes
sol = randperm(nodes);

% Set the parameters for ILS
max_iter = 100000;
temp = 100;

% Start the ILS loop
for i = 1:max_iter
    
    % Generate a new solution by swapping two random nodes
    new_sol = sol;
    node1 = randi(nodes);
    node2 = randi(nodes);
    new_sol([node1 node2]) = new_sol([node2 node1]);
    
    % Calculate the total distance of the new solution
    dist = 0;
    for j = 2:nodes
        dist = dist + norm(coords(new_sol(j-1),:) - coords(new_sol(j),:));
    end
    dist = dist + norm(coords(new_sol(nodes),:) - coords(new_sol(1),:));
    
    % Calculate the total distance of the current solution
    curr_dist = 0;
    for j = 2:nodes
        curr_dist = curr_dist + norm(coords(sol(j-1),:) - coords(sol(j),:));
    end
    curr_dist = curr_dist + norm(coords(sol(nodes),:) - coords(sol(1),:));
    
    % Accept the new solution with a probability based on its total distance
    delta = dist - curr_dist;
    if delta < 0 || rand() < exp(-delta/temp)
        sol = new_sol;
    end
    
    % Decrease the temperature after each iteration
    temp = temp * 0.995;
end

% Plot the final solution
plot(coords(sol,1), coords(sol,2), '-o');
xlabel('x');
ylabel('y');
title('TSP Solution with ILS and 2-opt');
