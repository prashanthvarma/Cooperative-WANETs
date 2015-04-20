

clear;
rand('state', 1);
numOfNodes = 25;   %   number of nodes
envSize=20;        %   envsizeXenvsize environment
txRange = 5;
global xLocation;   % Array containing the X-coordinations of wireless nodes;
global yLocation;   % Array containing the Y-coordinations of wireless nodes;
xLocation = rand(numOfNodes,1) * envSize;
yLocation = rand(numOfNodes,1) * envSize;   %x,y coords of nodes
reputation_matrix = zeros(numOfNodes);
reputation_table = ones(numOfNodes,numOfNodes);
reputation_direct = ones(numOfNodes);
reputation_liar = ones(numOfNodes,numOfNodes);
connMatrix1 = zeros(numOfNodes,numOfNodes);

% adjacent matrix to represent the topology graph of the
% randomly deployed wireless networks;

distMatrix = zeros(numOfNodes,numOfNodes);
for i=1:numOfNodes
   for j=1:numOfNodes
      distMatrix(i,j)=sqrt((xLocation(i)-xLocation(j))^2 + (yLocation(i)-yLocation(j))^2); %distance between node pairs
   end
end
% distance between two nodes is less than the transmission range, there
% exists a link.

% topology;

figure(1);
plot(xLocation, yLocation, 'o')
title('Randomly Deployed Nodes');

global connMatrix;
connMatrix = ( distMatrix < txRange);  %binary connectivity matrix
reputation_matrix = rand(1,numOfNodes);
locs=[xLocation' ; yLocation'];

figure(2);
gplot(connMatrix, locs','-o')
title('Topology Before Implementing The Reputation Algorithm');

connMatrix1 = connMatrix();



for i=1:numOfNodes     %direct monitoring
    for j=1:numOfNodes
        if connMatrix(i,j) == 1
            reputation_table(i,j) = reputation_matrix(j);
        end
    end
end

reputation_direct = reputation_table();
reputation_table = Indirect_monitoring(reputation_table,numOfNodes,connMatrix); %indirect monitoring fuction call
reputation_liar = liar_monitoring(reputation_direct,numOfNodes,connMatrix); %indirect monitoring with liars


for i=1:numOfNodes    
    for j=1:numOfNodes
        if reputation_table(i,j) < 0.4
            fprintf('%ith node is found to be Selfish :  ', j);
            fprintf('%i X-coordinate , ', xLocation(j));
            fprintf('%i Y-coordinate \n', yLocation(j));
            connMatrix(i,j) = 0;
            connMatrix(j,i) = 0; 
            end
    end 
    fprintf('\n');
end

for i=1:numOfNodes    
    for j=1:numOfNodes
        if reputation_liar(i,j) < 0.4
            fprintf('%ith node is found to be Selfish :  ', j);
            fprintf('%i X-coordinate , ', xLocation(j));
            fprintf('%i Y-coordinate \n', yLocation(j));
            connMatrix1(i,j) = 0;
            connMatrix1(j,i) = 0; 
            end
    end 
    fprintf('\n');
end

figure(3);
gplot(connMatrix, locs','-o')
title('Topology After Implementing The Reputation Algorithm');

figure(4);
gplot(connMatrix1, locs','-o')
title('Topology with liars');




