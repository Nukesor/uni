% First identify the class:

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions{}

\LoadClass[
    fontsize=12pt,
    headings=small,
    parskip=half,           % Ersetzt manuelles setzten von parskip/parindent.
    bibliography=totoc,
    numbers=noenddot,       % Entfernt den letzten Punkt der Kapitelnummern.
    open=any,               % Kapitel kann auf jeder Seite beginnen.
%   final                   % Entfernt alle todonotes und den Entwurfstempel.
]{scrreprt}

% Make the captions in your floats of the form:
% Figure 1 -> Fig. 1
\renewcommand{\figurename}{Fig.}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}

% force footnotes to the bottom
\usepackage[bottom]{footmisc}

\usepackage{color}
\usepackage{tcolorbox}
\definecolor{customgray}{RGB}{190,190,190}
\newtcbox{\inlinecode}{
    nobeforeafter,
    colframe=customgray,
    colback=customgray!10!white,
    boxrule=0.5pt,
    arc=4pt,
    boxsep=0pt,
    left=6pt,
    right=6pt,
    top=2pt,
    bottom=2pt,
    tcbox
    raise
    base
}

% Redefining the chapter heading styles
% Numbered chapter heading style:
\renewcommand{\@makechapterhead}[1]{%
  {\singlespacing
    \parindent \z@ \raggedright \normalfont
    \vspace{4pt} % add some vertical space
    \ifnum \c@secnumdepth >\m@ne
        \huge \scshape \@chapapp\space \thechapter % Chapter followed by number
        \par \nobreak
    \fi
    \interlinepenalty\@M
    \huge \scshape \bf #1\par % chapter title
    \vspace{4pt} % add some vertical space
    \nobreak
    \vskip 20\p@
  }}


% Unnumbered chapter heading style:
\renewcommand{\@makeschapterhead}[1]{%
  {\singlespacing
    \parindent \z@ \raggedright
    \normalfont
    \vspace{4pt} %add some vertical space
    \interlinepenalty\@M
    \huge \scshape \bf #1\par % chapter title
    \vspace{4pt} % add some vertical space
    \nobreak
    \vskip 40\p@
  }}

\newenvironment{itemlist}[1]{%
  \begin{trivlist}
  \topsep=0pt
  \parskip=0pt
  \item {\fontseries{b}{#1}}
  \begin{itemize}
  \setlength\itemsep{-0.2em}
}{%
  \end{itemize}
  \end{trivlist}
  \vspace{0.3em}
}

\endinput
