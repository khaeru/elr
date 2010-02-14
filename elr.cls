\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{elr}[2009/12/16 v1.00]
\LoadClass[11pt,twoside]{book}
\setcounter{secnumdepth}{0}
\setcounter{tocdepth}{0}
%
% calc
\RequirePackage{calc}
%
%
\RequirePackage{charter}
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
  headsep=0mm,
% a5 format
  a5paper,
  margin=15mm,%
  bindingoffset=5mm,%
%% lulu.com pocketbook format
%  paperwidth=4.25in,%
%  paperheight=6.87in,%
%  margin=0.5in,%
%  bottom=0.75in,%
%% half-letter format
%  paperwidth=5.5in,%
%  paperheight=8.5in,%
  ]{geometry}
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
%
% titlesec: section titles.
% can't use the 'pagestyles' class option, or else 
\RequirePackage{titlesec}
  \titleformat{\chapter}[display]{}{}{0pt}{\bfseries\Large}
  \titlespacing*{\chapter}{0pt}{10mm}{0pt}[20mm]
  % default definition with Large -> large, 2.3ex -> 1.3ex
%  \titleformat{\section}{\normalfont\large\bfseries}{\thesection}{1em}{}
  \titlespacing{\section}{0pt}{3.5ex plus 1ex minus .2ex}{1.3ex plus .2ex}
  % default definition with large -> normalsize, without \bfseries
%  \titleformat{\subsection}{\normalfont\fontsize{10pt}{11pt}\selectfont\itshape}{\thesubsection}{1em}{}
  \titleformat{\subsection}{\normalfont\large\itshape}{\thesubsection}{1em}{}
%
% chapterbib
\RequirePackage[sectionbib]{chapterbib}
\renewcommand\bibname{{References}}
%
% tikz
\RequirePackage{tikz}
%
% watermark
\RequirePackage{watermark}
\DeclareOption{proof}{
  \watermark{PROOF}
  \AtEndOfClass{
    \elrtitle{Engineering Leadership Review}{PROOF}
  }
}
%
%% Remaining options to book class
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{book}
}
%
%% Custom commands
\newcommand{\elrarticle}[3]{
  \chapter{#1}
  \parbox[l]{\textwidth-20mm}{\itshape \large #2}
  \vskip 10 mm
  \begin{flushleft}
  \bfseries \scshape #3
  \end{flushleft}
  \vskip 10 mm
}
%
\newcommand{\elrbib}[1]{
  \bibliographystyle{naturemag}
  \bibliography{#1}
}
%
\newenvironment{abstract}[0]{\fontsize{8pt}{9pt}\selectfont}{}
%
\newcommand{\elrend}{{\footnotesize\bfseries\scshape ELR}}
%
\newcommand{\elrtitle}[2]{
  \title{#1}\author{}
  \fancyfoot[LE]{\oldstylenums{\bfseries \thepage} \qquad \textsc{#1}}
  \fancyfoot[RO]{\textsc{#2} \qquad \oldstylenums{\bfseries \thepage}}
  \fancypagestyle{plain}{
    \fancyfoot[LE]{\oldstylenums{\bfseries \thepage} \qquad \textsc{#1}}
    \fancyfoot[RO]{\textsc{#2} \qquad \oldstylenums{\bfseries \thepage}}
  }
}
%
\endinput
