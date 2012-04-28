ENGINEERING LEADERSHIP REVIEW — LATEX TEMPLATES & SCRIPTS
=========================================================

  This repository contains information on the LaTeX templates used to compile
articles and whole issues of ELR.

Requirements
------------

- A LaTeX distribution. This contains the basic programs that process LaTeX
  source files, as well as packages, styles, classes and other add-ons. The
  recommended distribution is Tex Live [1], but others may also work.
- The following LaTeX packages, which will either be installed with the LaTeX
  distribution, or can be installed using a package manager:
  - bibunits
  - calc
  - caption
  - changepage
  - charter
  - fancyhdr
  - fontenc
  - geometry
  - hyperref
  - lmodern
  - multicol
  - natbib
  - tikz
  - titlesec
  - titletoc
  - watermark
- The contents of this repostitory, especially:
  - elr.cls : the file defining the ELR document class.
  - elr-issue, elr-proof : scripts for compiling an issue or article.
  - images : a directory with images required by all issues of ELR.

Other files
-----------
- example : an example issue of ELR, with three articles.
- article-01 : an example article, 3000 words long.
- lipsum-1000 : 1000 words of 'lorem ipsum' placeholder text.

Usage
-----

Run the script elr-issue or elr-proof to generate a PDF. For documentation on
what these scripts do, see the comments in them, or run them without any
arguments.

Structure
---------

elr.cls defines a new LaTeX document class named 'elr', based on the standard
LaTeX 'book' class. In this arrangement, each article in ELR corresponds to a
'chapter' in the book.

  For a full issue, a number of items (front-matter before the articles, and
back-matter after them) are included or generated automatically. For a proof or
preprint, the entire document consists of one article (= LaTeX chapter) with no
front- or back-matter

References
----------
1. http://www.tug.org/texlive

