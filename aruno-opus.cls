% Aruno Opus Class
%
% (c) Gambhiro Bhikkhu, 2013
% gambhiro@ratanagiri.org.uk
%
% LPPL LaTeX Pubic Project Licence
%

% ==============
% Identification
% ==============

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{aruno-opus}[2013/03/19 v0.01 A document class for books with a somber content.]

% ========================
% Preliminary Declarations
% ========================

\RequirePackage[british]{babel}

% =======
% Options
% =======

\RequirePackage{pgfopts}
\RequirePackage{calc}

\pgfkeys{
  /OPUS/.cd,
  pagePreset/.default=largepage,
  pagePreset/.store in=\OPUS@pagePreset,
  mainFontFamily/.default=TeX Gyre Pagella,
  mainFontFamily/.store in=\OPUS@mainFontFamily,
  italicFontFamily/.default=TeX Gyre Pagella Italic,
  italicFontFamily/.store in=\OPUS@italicFontFamily,
  boldFontFamily/.default=TeX Gyre Pagella Bold,
  boldFontFamily/.store in=\OPUS@boldFontFamily,
  capsFontFamily/.default=TeX Gyre Pagella,
  capsFontFamily/.store in=\OPUS@capsFontFamily,
}

% Pass all unknown options to memoir
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}
}

\ProcessPgfOptions{/OPUS}
\ProcessOptions\relax

% ======================
% All Other Declarations
% ======================

\LoadClass[11pt,twoside]{memoir}

\RequirePackage{nag}
\RequirePackage{xparse}
\RequirePackage{soul}
\RequirePackage{textcomp}
\RequirePackage[cmyk]{xcolor}

\RequirePackage{graphicx}
\graphicspath{{./src-images/}}
\RequirePackage{eso-pic}
\RequirePackage{ccicons}
\RequirePackage{multicol}
\RequirePackage{ifthen}

\RequirePackage{tikz}

% === Define colors ===

\definecolor{textbody}{gray}{0.15}
\definecolor{footnoterule}{gray}{0.5}

% === Load fonts ===

\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures={TeX}}

% \setmainfont
% [ BoldFont = Crimson Semibold,
%   ItalicFont = TeX Gyre Pagella Italic,
%   ItalicFeatures = { Ligatures = TeX, Scale = 0.9 } ]
% {Crimson Roman}

% If -- dashes don't work for your font, try
% Renderer = Basic
% http://tex.stackexchange.com/questions/20580/how-to-enable-ligatures-for-emdash-endash-in-luatex

\setmainfont[
  SmallCapsFont = Arno Pro,
  SmallCapsFeatures= { Ligatures = TeX, Letters = SmallCaps }
]{Gentium}

\newfontfamily\headFont{Arno Pro}
\newfontfamily\footFont{Gentium}

% === Page geometry and layout ===

% Symbols used:
% P = page proportion (h/w)
% T = textblock proportion (d/m)
% w = paper width
% h = paper height
% m = text width
% d = text height

\ifthenelse{\equal{\OPUS@pagePreset}{largepage}}{

  % Large page size
  %
  % 6in x 9in page
  % P = 1.5 (fifth)
  % T = 1.539 (Pentagon, between fifth and minor 6th)

  % For 10.5pt / 15pt font size, Gentium font, 20pt parindent, no
  % parskip. The textblock is a somber proportion (Pentagon 1:1.539),
  % ~70 characters wide. The slightly open linespacing aviods wall of
  % text effect. The inner margins keep the text out from the spine,
  % so a large book doesn't have to be strained to read the words
  % toward the center. Running header on top with title and chapter
  % marks, centered. Page number centered in footer, about three
  % linespace from text, bottom margin taller than top margin. This
  % gives the textblock a slightly elevated atmosphere, but with a
  % low-resonance proportion (between fifth and minor 6th musical
  % scale) for long prose (Dhamma talks), instead of a high-resonance
  % narrower column that would suit lighter text.

  % === normalsize ===

  \renewcommand{\normalsize}{%
    \@setfontsize\normalsize{10.5}{15}
    \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
    \abovedisplayshortskip \z@ \@plus3\p@
    \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
    \belowdisplayskip \abovedisplayskip
    \color{textbody}
    \let\@listi\@listI}
  \normalsize

  % === indentations ===

  \setlength{\vgap}{1.5em}
  \setlength{\vindent}{\vgap}
  \setlength{\vleftmargin}{2em}

  % TODO: try deeper parindent?
  \setlength{\parindent}{20pt}
  %\setlength{\parindent}{17pt}

  \setstocksize{9in}{6in}
  \settrimmedsize{\stockheight}{\stockwidth}{*}
  \settrims{0pt}{0pt}
  % no parskip, so exactly 33 lines
  %   = 490.5pt
  %   = 172.39mm
  %   = 32\baselineskip + \topskip
  % 1/1.539 = 0.649 (Pentagon) ratio to height, 112mm
  \settypeblocksize{32\baselineskip + \topskip}{*}{0.649}% 1/1.539, Tall Pentagon
  % alt: Short Pentagon, 1.376
  \setlrmargins{*}{*}{1.333}% fourth 3:4, 23.15mm | 17.3mm
  \setulmargins{*}{*}{1.778}% minor 7th 9:16, 20.23mm | 35.97mm
  \setheaderspaces{*}{4mm}{*}% ~ 1/Golden section, closer to text
  \setlength{\footskip}{3\baselineskip}
  \checkandfixthelayout

}{

  % Small page size

  %% 5.25in x 8in page
  %% P = 1.523 (~Pentagon (1.539), b/w fifth (1.5) and minor 6th (1.6))
  %% T = 1.618 (Golden Section, ~minor 6th (1.6))
  %\geometry{
  %paperwidth=5.25in,
  %paperheight=8in,
  %top=0.8in,
  %inner=0.8in,
  %textheight=6in,
  %textwidth=3.75in,
  %%showframe,
  %}
  %\setstocksize{8in}{5.25in}

}

%% ========
%% Hyperref
%% ========

\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  unicode=true,
  linkcolor=textbody,
  citecolor=textbody,
  filecolor=textbody,
  urlcolor=textbody
}
\RequirePackage[
  open,
  openlevel=2
]{bookmark}

% memoir's more allowing penalties
\midsloppy

%% Make hyphenation less frequent
%% WARNING: there will be more underfull lines, and some very streched
%% lines. Check the log file for underfull warnings.

\lefthyphenmin=3
\righthyphenmin=3

\hyphenpenalty=600
\exhyphenpenalty=50
\doublehyphendemerits=900
\brokenpenalty=990

% === soul settings ===

% === New, custom commands and environments ===

% === Renewing package macros ===

\renewcommand\footnoterule{%
  \vspace*{\baselineskip}%
  \kern-3\p@
  {\color{footnoterule}\hrule height 0.1pt width \columnwidth}
  \kern2.6\p@}

% === Page styles ===

\nouppercaseheads

\makepagestyle{normalpage}
\makeevenhead{normalpage}{}{\textit{\rightmark}}{}
\makeevenfoot{normalpage}{}{\thepage}{}
\makeoddhead{normalpage}{}{\textit{\leftmark}}{}
\makeoddfoot{normalpage}{}{\thepage}{}

\pagestyle{normalpage}


% === TOC settings ===

% === Part and Book styles ===

% === Chapter styles ===

\setsecnumdepth{chapter}

% === Section styles ===

\setbeforesecskip{-3.5ex \@plus -1ex \@minus -.2ex}
\setaftersecskip{2.3ex \@plus .2ex}

% === Packages to be loaded LAST ===

\RequirePackage[perpage,multiple,stable]{footmisc}

\RequirePackage[final,babel=true]{microtype}

%% =================
%% PDF/X-3:2002 info
%% =================

% \pdfobjcompresslevel=0%
% \pdfminorversion=3%
% \pdfinfo{
%   /Title (Dhammapada)
%   /Author (Forizs Laszlo)
%   /Subject (buddhizmus)
%   /Keywords (buddhizmus)
%   /GTS_PDFXVersion (PDF/X-3:2002)
% }%
% \pdfpageattr{
% /MediaBox [0 0 369.00000 594.00000]
% /BleedBox [0.00000 0.00000 369.00000 594.00000]
% /CropBox [0 0 369.00000 594.00000]
% /TrimBox [0.00000 0.00000 369.00000 594.00000]
% }
% \pdfcatalog{
%   /PageMode /UseNone
%   /OutputIntents [ <<
%     /Info (none)
%     /Type /OutputIntent
%     /S /GTS_PDFX
%     /OutputConditionIdentifier (Blurb.com)
%     /RegistryName (http://www.color.org/)
%   >> ]
% }%

%% ==============

