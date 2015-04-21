function [ ci, knn ] = LLCSolver( dictionary, xi, numneighbors)
k = numneighbors;

one=ones(numneighbors, 1);
knn =  knnsearch(dictionary, xi,'k',k);

Bi = dictionary(knn,:); % get the reduced matrix with the k closest entries in B to the descriptor as rows

% these next four lines are inspired by Jia's demo code
B_1x = Bi - one *xi; % a matrix
C = B_1x * B_1x'; % the covariance matrix
ci_hat = C \ one;
ci = ci_hat /sum(ci_hat);
%texton_ind.data(i,knn(i,:))=c;

end

