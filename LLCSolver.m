function [ c, knn ] = LLCSolver( dictionary, xi, numneighbors)
k = numneighbors;
knn =  knnsearch(dictionary, features.data,'k',k);
Bi = dictionary(knn(i,:),:); % get the reduced matrix with the k closest entries in B to the descriptor as rows

% these next four lines are inspired by Jia's demo code
B_1x = Bi - one *xi; % a matrix
C = B_1xi * B_1xi'; % the covariance matrix
ci_hat = C \ one;
ci = ci_hat /sum(ci_hat);
%texton_ind.data(i,knn(i,:))=c;

end

