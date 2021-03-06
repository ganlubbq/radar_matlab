function A = generate_dictionary(z,t,g,p)

%% Inputs

% z - Sequence of receive element positions, assumed to be a column vector
% t - Sequence of transmitter element positions, assumed to be a column vector set to '0' if not MIMO array
% g - number of grid points to test
% p - number of pulses set to 0 for angle only dimension 

%% Outputs

% A - Dictionary matrix, columns are steering vectors on the angle-Doppler map (or angle dimension only)

A = [];
N = length(z)*length(t);

if p > 0

L = 0.5*(0:p-1)';

for i = 1:length(g)
    b = exp(1i*2*pi*L*g(i));
    for j = 1:length(g)
        at = exp(1i*2*pi*t*g(j));
        ar = exp(1i*2*pi*z*g(j));
        c = kron(at,ar);
      
        A(:,end+1) = kron(b,c)/sqrt(N*p);
    end
end

else
    
    for j = 1:length(g)
        at = exp(1i*2*pi*t*g(j));
        ar = exp(1i*2*pi*z*g(j));
        
        A(:,end+1) = kron(at,ar)/sqrt(N);
    end
        
end


end