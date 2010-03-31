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
\LoadClass[11pt,twoside]{book}
\setcounter{secnumdepth}{0}
\setcounter{tocdepth}{0}
%
% calc
\RequirePackage{calc}
%
% charter: fonts.
\RequirePackage[T1]{fontenc}
\RequirePackage{charter}
\RequirePackage{lmodern}
\renewcommand{\rmdefault}{bch}
\renewcommand{\sfdefault}{lmss}
% not sure why this is necessary...
\renewcommand{\bfdefault}{bx}
%
% hyperref:
\RequirePackage[%
  colorlinks,%
  linkcolor=black,%
  urlcolor=black,%
  ]{hyperref}
%
% basic required contents
%\renewcommand\normalsize{\fontsize{9pt}{11pt}\selectfont}
%
% geometry: page size and margins
\RequirePackage[%
  includehead,%
  includefoot,%
% a5 format
%  a5paper,
%  margin=15mm,%
%  bindingoffset=5mm,%
%% lulu.com pocketbook format
%  paperwidth=4.25in,%
%  paperheight=6.87in,%
%  margin=0.5in,%
%  bottom=0.75in,%
%% half-letter format
  paperwidth=5.5in,%
  paperheight=8.5in,%
  margin=15mm,%
  bindingoffset=7mm,%
  headsep=3mm,%
  ]{geometry}
%
% chngpage/changepage: to alter margins; see \fullpagefigure
\RequirePackage[strict]{chngpage}
%
% fancyhdr: page marks
\RequirePackage{fancyhdr}
  % move the page numbers on the 'plain' page style used for chapter first pages
  \fancypagestyle{plain}{
    \fancyhf{}
  }
  \pagestyle{fancy}
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \AtBeginDocument{\pagestyle{empty}}
%
% titlesec: section titles.
% can't use the 'pagestyles' class option, or else 
\RequirePackage{titlesec}
  \setcounter{secnumdepth}{-1}
  \titleformat{\chapter}[display]{}{}{0pt}{\sffamily\fontseries{sbc}\selectfont\huge}
  \titlespacing*{\chapter}{0pt}{0mm}{0pt}[10mm]
  % default definition with Large -> large, 2.3ex -> 1.3ex
%  \titleformat{\section}{\normalfont\large\bfseries}{\thesection}{1em}{}
  \titlespacing{\section}{0pt}{3.5ex plus 1ex minus .2ex}{1.3ex plus .2ex}
  % default definition with large -> normalsize, without \bfseries
%  \titleformat{\subsection}{\normalfont\fontsize{10pt}{11pt}\selectfont\itshape}{\thesubsection}{1em}{}
  \titleformat{\subsection}{\normalfont\large\itshape}{\thesubsection}{1em}{}
\RequirePackage{titletoc}
  \titlecontents{chapter}
              [0pt]
              {\addvspace{1.5pc}}
              {}
              {\hspace*{-2pc}\makebox[2pc][c]{\bfseries\thecontentspage} \bfseries}
              {\hspace*{-2pc}}
              [\addvspace{.5pc}]
%
% bibunits: per-chapter (article) bibliographies
% rubber: module bibtex
% rubber: rules rules.ini
% rubber: make bu1.bbl
\RequirePackage[sectionbib]{bibunits}
  \renewcommand\bibname{{References}}
  \AtBeginDocument{
    % per-article bibliographies
    \bibliographyunit[\chapter]
    % citations like Nature magazine
    \defaultbibliographystyle{naturemag}
  }
%
% multicol
\RequirePackage{multicol}
%
% tikz
\RequirePackage{tikz}
%
% watermark
\ifproof
  \RequirePackage{watermark}
  \watermark{
    \begin{tikzpicture}[baseline=(current bounding box.north)]
      \useasboundingbox (0,0) rectangle (\textwidth,\textheight);
      \pgfsetfillopacity{0.3}
      \draw (current bounding box.center) node[rotate=45,scale=10] {\bfseries PROOF};
    \end{tikzpicture}
  }
  \AtEndOfClass{
    \elrtitle{Engineering Leadership Review}{PROOF}
  }
\fi
%
%% Custom commands & environments
%
% \ccby: icons for the Creative Commons Attributon license.
\newcommand{\ccby}[1]{
  \includegraphics[height=#1]{images/cc-large}%
  \includegraphics[height=#1]{images/by-large}
}
%
% 'colophon' environment
\newenvironment{colophon}[0]{
  ~
  \vfill
  \begin{flushleft}
    \addtolength{\parskip}{\baselineskip}
    \scriptsize
}{
  \addtolength{\parskip}{-\baselineskip}
  \end{flushleft}
}
%
% \elrarticle: start a new article. Takes three arguments:
%  * A MAIN title, used on the first page and in the table of contents
%  * A SUBtitle, used on the first page and in the table of contents
%  * A SHORT title used in the page header.
\newcommand{\elrarticle}[3]{
  \chapter{#1}
  \hspace{5mm}\parbox[l]{\textwidth-20mm}{\itshape \large #2}
  \vskip 10 mm
  \fancyhead[CO]{\hcrulefill\small\itshape #3\hcrulefill}
}
%
% \elrsummary: article summary. A couple of sentences describing the article
% that are shown after its entry in the table of contents
\newcommand{\elrsummary}[1]{
  \addtocontents{toc}{\protect\parbox{0.8\textwidth}{\small #1}\protect\par}
}
%
% \elrauthors: author information for an article. Takes three arguments:
%  * The author's/authors' name(s) in full, used on the first page.
%  * A SHORT author list used in the page header.
%  * Author credits to be shown in a footnore on the first page.
\newcommand{\elrauthors}[3]{
  \begin{flushleft}
  \bfseries \scshape #1
  \end{flushleft}
  \vskip 10 mm
  \fancyhead[CE]{\hcrulefill\small\itshape #2\hcrulefill}
  \let\thefootnote\relax\footnotetext{#3}
}
%
% \elrbib: per-article bibliography. The argument should be the name of
% the bibliography file (.bib) accompanying the article, WITHOUT the extension.
\newcommand{\elrbib}[1]{
  \putbib[#1]
}
%
% \elrend: sets a small "ELR" wordmark at the end of an article.
\newcommand{\elrend}{{\footnotesize\bfseries\scshape ELR}}
%
% articles environment
\newenvironment{articles}[0]{
  % 20mm space above article titles
  \titlespacing*{\chapter}{0pt}{20mm}{0pt}[10mm]
  % Restore page numbering
  \pagestyle{fancy}
}{}
%
% \elrtitle:
\newcommand{\elrtitle}[2]{
  \title{#1}\author{}\date{#2}
  \fancyfoot[LE,RO]{\bfseries \thepage}
  \fancyfoot[RE]{\small \textsc{#2}}
  \fancyfoot[LO]{\small \textsc{#1}}
  \fancypagestyle{plain}{
    \fancyfoot{}
    \fancyhead{}
    \fancyfoot[C]{\bfseries \thepage}
  }
}
%
% \fullpagefigure: a full-page figure (no margins). Use before \elrarticle to
%   fill a blank left page.
\newcommand{\fullpagefigure}[1]{
  % hide page marks
  \pagestyle{empty}
  % change the page layout. The lengths match the invocation of the
  % 'geometry' package above.
  \changepage{30mm}% increase textheight: 2 × marginwidth
    {37mm}% increase textwidth: 2 × marginwidth + bindingoffset
    {-15mm}% decrease odd (left) side margin: marginwidth
    {-22mm}% decrease even (right) side margin: marginwidth + bindingoffset
    {}% no change to columnsep
    {-15mm}% decrease top margin: marginwidth
    {-\baselineskip}% decrease headheight: one line
    {-3mm}% decrease headsep to 0.
    {}% no change to footskip
  % include the figure itself
  \begin{figure}[h]
    \includegraphics[height=\paperheight]{#1}
  \end{figure}
  % done with this page
  \clearpage
  % restore page marks
  \pagestyle{fancy}
  % restore page layout. Numbers are the same as above, opposite sign
  \changepage{-30mm}{-37mm}{15mm}{22mm}{}{15mm}{\baselineskip}{3mm}{}
}
%
% from http://www.tug.org/pipermail/texhax/2004-August/002644.html
\newcommand*\hcrulefill{%
  \leavevmode\leaders\hrule depth-2pt height 2.4pt\hfill\kern0pt
}
%
% \editorgroup: TODO
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
\endinput
