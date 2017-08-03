function [ integ ] = MyTrap( devar,invar,varargin )
%Computation of the integral using the trapezoidal rule
%integ = m_trap(devar, invar)
%Kyle O'Connor
%March 15, 2016
if isempty(varargin)
    start = 1;
    last = length(invar);
else
    start = find(invar == varargin{1});
    last = find(invar == varargin{2});
end
c = start:last-1;
integ =(devar(c+1) + devar(c)).*((invar(c+1) - invar(c))/2);

end

