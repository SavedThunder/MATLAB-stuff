function [ integ ] = MySim( dep,indep,varargin )
%UNTITLED2 Summary of this function goes here
%   Simpson's Rule for integration
if isempty(varargin)
    Imin = 1;
    Imax = length(indep);
else
    Imin = find(indep == varargin{1});
    Imax = find(indep == varargin{2});
end
dt = diff(indep);
sim(Imin) = dep(Imin);
sim(Imax) = dep(Imax);
count = 1;
for c = Imin+1: Imax-1;
    count = count + 1;
    if(rem(count,2) == 0)
        sim(c) = 4 * dep(c);
    else
        sim(c) = 2*dep(c);
    end
end
integ = sum(sim)*(dt(1)/3);

end

