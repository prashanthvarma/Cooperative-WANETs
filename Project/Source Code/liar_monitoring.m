function [reputation_direct] = liar_monitoring(reputation_direct,numOfNodes,connMatrix)

reputation_rows = ones(numOfNodes);

for i=1:numOfNodes     
    reputation_rows = reputation_direct(i,:);
    for i=1:numOfNodes     
        for j=1:numOfNodes
            reputation_direct(i,j) = (reputation_rows(j) + reputation_direct(i,j))/2;
        end
       end
           
    end
end

