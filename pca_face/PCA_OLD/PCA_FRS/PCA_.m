function [W,X,L] = PCA_(data,m,c,econ)
%PCA_: calculate the principle components (PCs), the latent low-dimensional data,
%and the eigenvalues
%Usage:
%       [W,X,L]=PCA_(data) %return the whole basis vectors and the data is cenetered
%       [W,X,L]=PCA_(data,0,c) %return c PC, data is cenetered  
%       [W,X,L]=PCA_(data,meanOfData,c) %return c PC, use the mean to
%       center the data
%       [W,X,L]=PCA_(data,meanOfData,c,1) %use the economy size of SVD (thin
%       SVD) to compute the PCA
%       [W,X,L]=PCA_(data,meanOfData,c,0) %use the full version of SVD 
%Input:
%       - data: the [DxN] matrix of N D-dimension data points 
%       - c: number of returned principle components (default return all PCs)
%       - m: mean of the data Dx1 vector (default = 0)
%       - econ: 1 for using economy size of SVD to compute the PCs
%       (default=1)
%Output:
%       - W: [DxC] principle components
%       - X: [CxN] the latent coordinate vectors (N (Cx1) latent vectors "column
%       vectors")
%       - L: (min(D,N)x1) vector the eigen values (S^2)
%checks
if nargin < 1
    error('Too few input arguments.')
elseif nargin < 2
    m=zeros(size(data,1),1);
    c=0;
    econ=1;
elseif nargin < 3
    c=0;
    econ=1;
elseif nargin < 4
    econ=1;
end
    
%centering the data
n=size(data,2); %get the number of data points
centered_data=data -repmat(m,[1,n]); %subtract mean
Y=centered_data/sqrt(n); %divide by the sqrt(number of points)
%calculate the singular value decomposition
if econ==1
    [U,S,V] = svd(Y,'econ');
else
    [U,S,V] = svd(Y);
end
if c==0
    W=U;
else
    W=U(:,1:c);
end
%calculate eigen values (Lamda)
L=zeros(size(W,2),1);
L(1:min(size(S,1),size(S,2)))=diag(S.*S);
%calculate the latent coordinate vectors 
X=W'*(centered_data);