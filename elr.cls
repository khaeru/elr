\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{elr}[2009/12/16 v1.00]
\newif\ifproof
\DeclareOption{proof}{
  \prooftrue
}
%% Remaining options to book class
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{book}
}
\ProcessOptions\relax
\LoadClass[11pt,openany,twoside]{book}
\setcounter{secnumdepth}{0}
\setcounter{tocdepth}{0}

%% Package includes ———————————————————————————————————————————————————————————
%
% calc - infix notation arithmetic in LaTeX
\RequirePackage{calc}
%
% caption - customize captions of floating environments
\RequirePackage[labelformat=empty,font={small,bf}]{caption}
%
% chngpage/changepage - local changes to margins
%   See \fullpagefigure. 'changepage' is the newer packagename, available in
%   TeXLive 2009. TeXLive 2007 has the older package
\RequirePackage[strict]{changepage}
%
% charter - Bitstream charter fonts, and
% lmodern - Latin modern fonts
%   The package fontenc is required to get the proper encoding of these fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{charter}
\RequirePackage{lmodern}
  % default roman (serif) text is Bitstream Charter
  \renewcommand{\rmdefault}{bch}
  % default sans serif text is Latin Modern Sans
  \renewcommand{\sfdefault}{lmss}
  % not sure why this is necessary...
  \renewcommand{\bfdefault}{bx}
%
% hyperref - Hypertext marks in LaTeX
%   All kinds of fancy stuff.
\RequirePackage[%
  pdftex,% because we compile with pdflatex
  colorlinks,% ...instead of drawing a border around them.
  citecolor=black,%
  linkcolor=black,%
  urlcolor=black,%
  ]{hyperref}
%
% geometry - control page dimensions
\RequirePackage[%
  includehead,%
  includefoot,%
%% A5 format (unused)
%  a5paper,
%% lulu.com 'Pocketbook' format (unused)
%  paperwidth=4.25in,%
%  paperheight=6.87in,%
%% lulu.com 'Digest' (half-letter) format
  paperwidth=5.5in,%
  paperheight=8.5in,%
  margin=15mm,%
  bindingoffset=7mm,% larger margin on the binding side
  headsep=3mm,% separation between the header (see 'fancyhdr' below) and text
  ]{geometry}
%
% natbib
%   Must be loaded before bibunits.
\RequirePackage[sort]{natbib}
  \renewcommand{\bibfont}{\small}
  \setlength{\bibsep}{0pt}
%
% bibunits - separate bibliographies for each chapter
\RequirePackage[sectionbib]{bibunits}
  \renewcommand\bibname{{References}}
  \AtBeginDocument{
    % per-article bibliographies
    \bibliographyunit[\chapter]
    \defaultbibliographystyle{plainnat}
  }
%
% fancyhdr - Page layout in LaTeX
%   To get the right headers and footers in different parts of the issue, the
%   fancyhdr commands \fancyhead and \fancyfoot are used in several places. See
%   \elrarticle, \elrauthors and \elrtitle.
\RequirePackage{fancyhdr}
  \pagestyle{fancy}
  % clear headers and footers, they will be defined elsewhere
  \fancyhf{}
  % no line separating the header from the text
  \renewcommand{\headrulewidth}{0pt}
  % title page, colophon, etc. have no page marks at all
%  \AtBeginDocument{\thispagestyle{plain}}
%
%% inputenc - input encoding
%%   Commented for the time being, because it interrupts processing when it
%%   encounters bad .bib files.
%\RequirePackage[utf8x]{inputenc}
%
% titlesec - Redefine section titles
%   Redefine the way \chapter, \section and so on look. Can't use the
%   'pagestyles' class option (TODO: why?)
\RequirePackage{titlesec}
  % no sections are numbered
  \setcounter{secnumdepth}{-1}
  % format and spacing for chapter titles
  \titleformat{\chapter}[display]{\filright\sffamily\fontseries{sbc}\selectfont\Huge}{}{0pt}{}
  \titlespacing*{\chapter}{0pt}{0mm}{0pt}[10mm]
  \titleformat{\section}{\filright\normalfont\Large\bfseries}{}{1em}{}
  % spacing for section titles: default definition with 2.3ex -> 1.3ex
  \titlespacing{\section}{0pt}{3.5ex plus 1ex minus .2ex}{1.3ex plus .2ex}
  % format for subection titles: italics
  \titleformat{\subsection}{\filright\normalfont\large\itshape}{}{1em}{}
%
% titletoc - Change the way contents lines for \titlecontents are laid out
\RequirePackage{titletoc}
  \titlecontents{chapter}
    [0pt]
    {\addvspace{1.5pc}}
    {}
    {\contentspush{\makebox[2pc][c]{\bfseries\thecontentspage}}\bfseries\raggedright}
    {}
%    {\hspace*{-2.3pc}}
%
% multicol - an environment for multicolumn output
%   Makes the 'multicol' environment available, which is used for \editorgroup
%   (below).
\RequirePackage{multicol}
%
% tikz - drawings
\RequirePackage{tikz}
  \usetikzlibrary{scopes}
%
% watermark - watermarks on every page
%   Used for preparing proofs.
\ifproof
  \RequirePackage{watermark}
  % big "PROOF" watermark filling the whole page
  \watermark{
    \begin{tikzpicture}[baseline=(current bounding box.north)]
      \useasboundingbox (0,0) rectangle (\textwidth,\textheight);
      \pgfsetfillopacity{0.3}
      \node [rotate=45,scale=10] at (current bounding box.center)
        {\bfseries PROOF};
    \end{tikzpicture}
  }
  % proofs are made without a preamble, frontmatter or endmatter, so make sure
  % elrtitle is called.
  \AtEndOfClass{
    \elrtitle{Engineering Leadership Review}{PROOF}
  }
\fi
%
%% Custom commands & environments —————————————————————————————————————————————
%
% \article - start a new article
%   Accepts three arguments:
%    * A MAIN title, used on the first page and in the table of contents
%    * A SUBtitle, used on the first page and in the table of contents
%    * A SHORT title used in the page header.
\newcommand{\article}[3]{
  \chapter{#1}
  \hspace{5mm}\parbox[l]{\textwidth-20mm}{\itshape \large #2}
  \vskip 10 mm
  \fancyhead[CO]{\hcrulefill~\small\itshape #3~\hcrulefill}
}
%
% 'articles' environment - Container for ELR articles
%   Changes some elements of formatting that are specific to articles, but not
%   to be used in the front- and back-matter.
\newenvironment{articles}[0]{
  % 20mm space above article titles
  \titlespacing*{\chapter}{0pt}{20mm}{0pt}[10mm]
  % Restore page numbering
  \pagestyle{fancy}
  \@openrighttrue
}{
  \@openrightfalse
}
%
% \authors: author information for an article. Takes three arguments:
%  * The author's/authors' name(s) in full, used on the first page.
%  * A SHORT author list used in the page header.
%  * Author credits to be shown in a footnote on the first page.
\newcommand{\authors}[3]{
  \begin{flushleft}
    \bfseries \scshape \Large #1
  \end{flushleft}
  \vskip 10 mm
  \fancyhead[CE]{\hcrulefill~\small\itshape #2~\hcrulefill}
  \addtocontents{toc}{%
    \noindent\hspace*{2.15pc}\protect\parbox{0.8\textwidth}{\itshape #1}%
    \protect\par%
  }
  \let\thefootnote\relax\footnotetext{#3}
}
%
% \ccby - Icons for the Creative Commons Attributon license.
\newcommand{\ccby}[1]{
  \includegraphics[height=#1]{images/cc-large}%
  \includegraphics[height=#1]{images/by-large}
}
%
% 'colophon' environment
%   Bottom left corner of a page; small font.
\newenvironment{colophon}[0]{
  \thispagestyle{empty}
  ~
  \vfill
  \begin{flushleft}
    \addtolength{\parskip}{\baselineskip}
    \scriptsize
}{
  \addtolength{\parskip}{-\baselineskip}
  \end{flushleft}
%  \setcounter{page}{1}
}
%
% \crule - centered rule
\newcommand{\crule}[2]{
  \begin{center}
    \rule{#1\linewidth}{#2}
  \end{center}
}
%
% \elrbib - Per-article bibliography
%   The argument should be the name of the bibliography file (.bib)
%   accompanying the article, WITHOUT the extension. See documentation for the
%   'bibunits' package.
\newcommand{\elrbib}[1]{
  \putbib[#1]
}
%
% \elrend - 'ELR' wordmark
\newcommand{\elrend}{
  \hfill {\footnotesize\bfseries\scshape [ELR}
}
%
% \fullpagefigure - A full-page figure with no margins
%   Use before \elrarticle to fill a blank left page.
\newcommand{\fullpagefigure}[2]{
  % hide page marks
  \pagestyle{empty}
%  % change the page layout. The lengths match the invocation of the
%  % 'geometry' package above.
%  \changepage{30mm}% increase textheight: 2 × marginwidth
%    {37mm}% increase textwidth: 2 × marginwidth + bindingoffset
%    {-15mm}% decrease odd (left) side margin: marginwidth
%    {-22mm}% decrease even (right) side margin: marginwidth + bindingoffset
%    {}% no change to columnsep
%    {-15mm}% decrease top margin: marginwidth
%    {-\baselineskip}% decrease headheight: one line
%    {-3mm}% decrease headsep to 0.
%    {}% no change to footskip
%  % include the figure itself
%  \begin{figure}[ht]
    \begin{tikzpicture}[remember picture,overlay]
      \coordinate (sw) at (current page.south west);
      \clip (sw) rectangle (\paperwidth,\paperheight);
      { [xshift=1in]
        \node [anchor=south west,outer sep=0,inner sep=0pt] at (sw) {\includegraphics[height=\paperheight]{#1}};
      }
    \end{tikzpicture}
    \label{#2}
%  \end{figure}
  % done with this page
  \clearpage
  % restore page marks
  \pagestyle{fancy}
%  % restore page layout. Numbers are the same as above, opposite sign
%  \changepage{-30mm}{-37mm}{15mm}{22mm}{}{15mm}{\baselineskip}{3mm}{}
}
%
% \hcrulefill - Space-filling horizontal rule at text centreline
%   For use in \elrarticle and \elrauthors, above. From
%   http://www.tug.org/pipermail/texhax/2004-August/002644.html
\newcommand*\hcrulefill{%
  \leavevmode\leaders\hrule depth-2pt height 2.4pt\hfill\kern0pt
}
%
% \issue - Issue title
%   Sets the title (first argument) and date (second argument) for an issue.
\newcommand{\issue}[3]{
  \title{#1}\author{}\date{#2 \\ #3}
  \fancyfoot[LE,RO]{\bfseries \thepage}
  \fancyfoot[RE]{\small \textsc{#3}}
  \fancyfoot[LO]{\small \textsc{#1}}
  \fancypagestyle{plain}{
    \fancyfoot{}
    \fancyhead{}
    \fancyfoot[C]{\bfseries \thepage}
  }
}
%
% \editorgroup - Group of Editorial Board members
%   For use in the masthead. The first argument is the title of members in the
%   group; the second argument is their names. Names should be separated with
%   newlines (\\).
\newcommand{\editorgroup}[2]{
  \begin{multicols}{2}
    \begin{flushright}
     \scshape #2
    \end{flushright}
    \columnbreak
    #1
  \end{multicols}
}
%
% \signed - Credits for quotations
%   From http://www.latex-community.org/forum/viewtopic.php?f=5&t=2566
\newcommand{\signed}[1]{%
  \unskip\hspace*{1em plus 1fill}%
  \nolinebreak[3]\hspace*{\fill}\mbox{\upshape --- #1}
}
%
% \summary - Article summary
%   Accepts one argument — some sentences describing the article that are shown
%   after its entry in the table of contents
\newcommand{\summary}[1]{
  \addtocontents{toc}{%
    \vspace{0.5\baselineskip}%
    \noindent\hspace*{2.1pc}\protect\parbox{0.8\textwidth}{\small #1}%
    \protect\par%
  }
}
%
\endinput
