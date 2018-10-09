function matlab2pdf(filename,varargin)
%MATLAB2PDF   pdf-generation of Matlab plots.
%   MATLAB2PDF(FILENAME,VARARGIN) generates a 'standalone' LaTeX file using
%   matlab2tikz and compiles this directly to PDF with pdflatex. It cleans 
%   up temporary files after compilation.
%
%   MATLAB2PDF(FILENAME,VARARGIN)
%   FILENAME is the name of the generated LaTeX and pdf file, with file ending,
%   e.g. THING.TEX or THING.TIKZ, and THING.PDF, respecitively. VARARGIN are 
%   (optional) arguments equivalently to MATLAB2TIKZ. 
%
%   MATLAB2PDF(filename,'extraPackage',CHAR or CELLCHAR,...) adds additional 
%   latex packages at the beginning of the output file. (default: [])
%
%   MATLAB2PDF(filename,'keepTikzFile',BOOL,...) keeps the 'standalone'
%   Latex file. (default: false)
% 
%   See also MATLAB2TIKZ

%--------------------------------------------------------------------------
% pare additional inputs
p = inputParser;
p.KeepUnmatched = true;
addParameter(p,'extraPackage', '', @(x) ischar(x) || iscellstr(x));
addParameter(p,'keepTikzFile', false, @islogical);
parse(p,varargin{:});

% strip file ending
ind = find(filename=='.',1,'last');
if isempty(ind)
    basename = filename;
    filename = strcat(basename,'.tikz');
else
    basename = filename(1:ind-1);
end

% modify extraPackage to extraCode containing \usepackage{extraPackage}
extraCode = strcat('\usepackage{',(p.Results.extraPackage),'}');
if isfield(p.Results, 'extraCode')
    extraCode = strcat(extraCode,p.Results.extraCode);
end

% run matlab2tikz
matlab2tikz(filename,...
            'standalone',true,...
            'extraCode',extraCode,...
            p.Unmatched)

% run pdflatex on generated file
system(sprintf('pdflatex %s', filename));

% remove .aux and .log files, and .tikz if applicalbe
if ispc
    system(sprintf('del "%s.aux"',basename));
    system(sprintf('del "%s.log"',basename));
    if ~p.Results.keepTikzFile
        system(sprintf('del "%s.tikz"',basename));
    end
elseif isunix
    system(sprintf('rm %s.aux %s.log',basename,basename));
    if ~p.Results.keepTikzFile
        system(sprintf('rm "%s.tikz"',basename));
    end
end

% open .pdf
eval(sprintf('open %s.pdf',basename));

