function [reputation_table] = Indirect_monitoring(reputation_table,numOfNodes,connMatrix)

reputation_rows = ones(numOfNodes);

for i=1:numOfNodes     
    reputation_rows = reputation_table(i,:);
    for i=1:numOfNodes     
        for j=1:numOfNodes
    if connMatrix(i,j) == 1
       if abs(reputation_table(j)- reputation_rows(j)) < 0.3
        for i=1:numOfNodes     
        for j=1:numOfNodes
            reputation_table(i,j) = (reputation_rows(j) + reputation_table(i,j))/2;
        end
       end
           
    end
end
    end
end
end
