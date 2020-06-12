function [io_coord, ierr] = cg_coord_read(in_fn, in_B, in_Z, in_coordname, in_type, in_rmin, in_rmax, io_coord)
% Gateway function for C function cg_coord_read.
%
% [coord, ierr] = cg_coord_read(fn, B, Z, coordname, type, rmin, rmax, coord)
%
% Input arguments (required; type is auto-casted):
%              fn: 32-bit integer (int32), scalar
%               B: 32-bit integer (int32), scalar
%               Z: 32-bit integer (int32), scalar
%       coordname: character string
%            type: 32-bit integer (int32), scalar
%            rmin: 64-bit or 32-bit integer (platform dependent), array
%            rmax: 64-bit or 32-bit integer (platform dependent), array
%
% In&Out argument (required as output; type is auto-casted):
%           coord: dynamic type based on type  (also required as input)
%
% Output argument (optional):
%            ierr: 32-bit integer (int32), scalar
%
% The original C function is:
% int cg_coord_read(int fn, int B, int Z, const char * coordname, CG_DataType_t type, const long * rmin, const long * rmax, void * coord);
%
% For detail, see <a href="https://cgns.github.io/CGNS_docs_current/midlevel/grid.html">online documentation</a>.
%
if ( nargout < 1 || nargin < 8)
    error('Incorrect number of input or output arguments.');
end
in_fn = int32(in_fn);
in_B = int32(in_B);
in_Z = int32(in_Z);
in_coordname = char(in_coordname);
in_type = int32(in_type);
if strfind(computer,'64') %#ok<STRIFCND>
    in_rmin = int64(in_rmin);
else
    in_rmin = int32(in_rmin);
end
if strfind(computer,'64') %#ok<STRIFCND>
    in_rmax = int64(in_rmax);
else
    in_rmax = int32(in_rmax);
end

% Perform dynamic type casting
datatype = in_type;
switch (datatype)
    case 2 % CG_Integer
        io_coord = int32(io_coord);
    case 3 % CG_RealSingle
        io_coord = single(io_coord);
    case 4 % CG_RealDouble
        io_coord = double(io_coord);
    case 5 % CG_Character
        io_coord = [int8(io_coord), int8(zeros(1,1))];
    case 6 % CG_LongInteger
        io_coord = int64(io_coord);
    otherwise
        error('Unknown data type %d', in_type);
end


% Invoke the actual MEX-function.
ierr = cgnslib_mex(int32(74), in_fn, in_B, in_Z, in_coordname, in_type, in_rmin, in_rmax, io_coord);
