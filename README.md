# matlab2pdf
pdf-generation of MATLAB(R) plots using matlab2tikz with 'standalone' option

# Usage
  MATLAB2PDF(FILENAME,VARARGIN) generates a 'standalone' LaTeX file using
  matlab2tikz and compiles this directly to PDF with pdflatex. It cleans 
  up temporary files after compilation.

  MATLAB2PDF(FILENAME,VARARGIN)
  FILENAME is the name of the generated LaTeX and pdf file, with file ending,
  e.g. THING.TEX or THING.TIKZ, and THING.PDF, respecitively. VARARGIN are 
  (optional) arguments equivalently to MATLAB2TIKZ. 

  MATLAB2PDF(filename,'extraPackage',CHAR or CELLCHAR,...) adds additional 
  latex packages at the beginning of the output file. (default: [])

  MATLAB2PDF(filename,'keepTikzFile',BOOL,...) keeps the 'standalone'
  Latex file. (default: false)

  See also MATLAB2TIKZ

https://github.com/matlab2tikz/matlab2tikz.git
