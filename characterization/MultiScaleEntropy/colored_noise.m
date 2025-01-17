function [y] = colored_noise(Sf,dur,b)

% [y] = colored_noise(Sf,dur,b)
%
% Sf  - sampling frequency
% dur - duration
% b   - exponent of the 1/f^b power law function
%       b = 0 (white), 1 (pink), 2 (brown), -1 (blue), -2 (violet)
%
% y - noise time domain signal
%     (y is normalized such that mean(y)==0 and std(y)==1)
%
% Description: The script calculates a colored noise.
%
% ---------
%
%    Copyright (C) 2015
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
% -----------------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2015-08-27

% get number of samples
N = round(Sf * dur);
if mod(N,2)
    M = N + 1;
else
    M = N;
end

% get fourier spectrum and the corresponding frequency axis
F  = fft(rand([M 1]));
xf = (0:M/2-1)*(Sf/M);

% power law function
p = 1./xf(2:end).^b;

% get scaled magnitudes and phase
R = sqrt((abs(F(2:length(xf))).^2).*p');
P = angle(F(2:length(xf)));
	
% get symmetrical spectrum
F(2:length(xf))     = R .* (cos(P) + 1i.*sin(P));
F(length(xf)+2:end) = real(F(length(xf):-1:2)) - 1i*imag(F(length(xf):-1:2));

% IFFT
y = ifft(F);

% get correct number of samples
y = real(y(1:N));

% ensure unity standard deviation and zero mean value
y    = y - mean(y);
yrms = sqrt(mean(y.^2));
y    = y / yrms;

