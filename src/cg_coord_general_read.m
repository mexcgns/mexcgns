function [io_coord_ptr, ierr] = cg_coord_general_read(in_fn, in_B, in_Z, in_coordname, in_s_rmin, in_s_rmax, in_m_type, in_m_numdim, in_m_dimvals, in_m_rmin, in_m_rmax, io_coord_ptr)
% Gateway function for C function cg_coord_general_read.
%
% [coord_ptr, ierr] = cg_coord_general_read(fn, B, Z, coordname, s_rmin, s_rmax, m_type, m_numdim, m_dimvals, m_rmin, m_rmax, coord_ptr)
%
% Input arguments (required; type is auto-casted):
%              fn: 32-bit integer (int32), scalar
%               B: 32-bit integer (int32), scalar
%               Z: 32-bit integer (int32), scalar
%       coordname: character string
%          s_rmin: 64-bit or 32-bit integer (platform dependent), array
%          s_rmax: 64-bit or 32-bit integer (platform dependent), array
%          m_type: 32-bit integer (int32), scalar
%        m_numdim: 32-bit integer (int32), scalar
%       m_dimvals: 64-bit or 32-bit integer (platform dependent), array
%          m_rmin: 64-bit or 32-bit integer (platform dependent), array
%          m_rmax: 64-bit or 32-bit integer (platform dependent), array
%
% In&Out argument (required as output; type is auto-casted):
%       coord_ptr: dynamic type based on m_type  (also required as input)
%
% Output argument (optional):
%            ierr: 32-bit integer (int32), scalar
%
% The original C function is:
% int cg_coord_general_read(int fn, int B, int Z, const char * coordname, const long * s_rmin, const long * s_rmax, CG_DataType_t m_type, int m_numdim, const long * m_dimvals, const long * m_rmin, const long * m_rmax, void * coord_ptr);
%
% For detail, see <a href="https://cgns.github.io/CGNS_docs_current/midlevel/grid.html">online documentation</a>.
%
if ( nargout < 1 || nargin < 12)
    error('Incorrect number of input or output arguments.');
end
in_fn = int32(in_fn);
in_B = int32(in_B);
in_Z = int32(in_Z);
in_coordname = char(in_coordname);
if strfind(computer,'64') %#ok<STRIFCND>
    in_s_rmin = int64(in_s_rmin);
else
    in_s_rmin = int32(in_s_rmin);
end
if strfind(computer,'64') %#ok<STRIFCND>
    in_s_rmax = int64(in_s_rmax);
else
    in_s_rmax = int32(in_s_rmax);
end
in_m_type = int32(in_m_type);
in_m_numdim = int32(in_m_numdim);
if strfind(computer,'64') %#ok<STRIFCND>
    in_m_dimvals = int64(in_m_dimvals);
else
    in_m_dimvals = int32(in_m_dimvals);
end
if strfind(computer,'64') %#ok<STRIFCND>
    in_m_rmin = int64(in_m_rmin);
else
    in_m_rmin = int32(in_m_rmin);
end
if strfind(computer,'64') %#ok<STRIFCND>
    in_m_rmax = int64(in_m_rmax);
else
    in_m_rmax = int32(in_m_rmax);
end

% Perform dynamic type casting
datatype = in_m_type;
switch (datatype)
    case 2 % CG_Integer
        io_coord_ptr = int32(io_coord_ptr);
    case 3 % CG_RealSingle
        io_coord_ptr = single(io_coord_ptr);
    case 4 % CG_RealDouble
        io_coord_ptr = double(io_coord_ptr);
    case 5 % CG_Character
        io_coord_ptr = [int8(io_coord_ptr), int8(zeros(1,1))];
    case 6 % CG_LongInteger
        io_coord_ptr = int64(io_coord_ptr);
    otherwise
        error('Unknown data type %d', in_m_type);
end


% Invoke the actual MEX-function.
ierr = cgnslib_mex(int32(75), in_fn, in_B, in_Z, in_coordname, in_s_rmin, in_s_rmax, in_m_type, in_m_numdim, in_m_dimvals, in_m_rmin, in_m_rmax, io_coord_ptr);
