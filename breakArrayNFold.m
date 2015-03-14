function [ partone parttwo ] = breakArrayNFold( n, N, i )
% N fold array breaking for validation

delta = floor(n/N);

if i<mod(n,N)+1
    parttwo = (i-1)*(delta+1)+1:(i-1)*(delta+1)+delta+1;
    partone = setdiff(1:n,parttwo);
else
    parttwo = delta*(i-1)+mod(n,N)+1:delta*(i-1)+mod(n,N)+delta;
    partone = setdiff(1:n,parttwo);
end


end

