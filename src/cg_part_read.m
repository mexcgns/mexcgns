function [out_part_name, ierr] = cg_part_read(in_file_number, in_B, in_F, in_G, in_P)
% Gateway function for C function cg_part_read.
%
% [part_name, ierr] = cg_part_read(file_number, B, F, G, P)
%
% Input arguments (required; type is auto-casted):
%     file_number: 32-bit integer (int32), scalar
%               B: 32-bit integer (int32), scalar
%               F: 32-bit integer (int32), scalar
%               G: 32-bit integer (int32), scalar
%               P: 32-bit integer (int32), scalar
%
% Output arguments (optional):
%       part_name: character string
%            ierr: 32-bit integer (int32), scalar
%
% The original C function is:
% int cg_part_read(int file_number, int B, int F, int G, int P, char * part_name);
%
% For detail, see <a href="https://cgns.github.io/CGNS_docs_current/midlevel/families.html">online documentation</a>.
%
if (nargin < 5)
    error('Incorrect number of input or output arguments.');
end
in_file_number = int32(in_file_number);
in_B = int32(in_B);
in_F = int32(in_F);
in_G = int32(in_G);
in_P = int32(in_P);

% Invoke the actual MEX-function.
[out_part_name, ierr] = cgnslib_mex(int32(67), in_file_number, in_B, in_F, in_G, in_P);
