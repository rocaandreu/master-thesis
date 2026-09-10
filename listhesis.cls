%%
%% This is file `listhesis.cls', modified to add a second title-page logo
%% and a "home university" advisor/institution pair (for joint/double-degree
%% theses), based on the original by Michael Vonbiun <michael.vonbun@tum.de>.
%%
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{listhesis}
    [2017/07/21 v1.0 lis thesis]
\DeclareOption{dvipsnames}{\PassOptionsToPackage{\CurrentOption}{xcolor}}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}%
\ProcessOptions\relax
\LoadClass[a4paper,12pt,twoside,
bibliography=totoc,
listof=totoc,
listof=entryprefix,
toc=sectionentrywithdots,
abstract=true]{scrreprt}%
\RequirePackage[utf8]{inputenc}%
\RequirePackage[ngerman,english]{babel}%
\RequirePackage[left=2.5cm,right=3.5cm,top=2.5cm,bottom=2.5cm,includeheadfoot]{geometry}%
\RequirePackage{xkeyval}%
\RequirePackage{etoolbox}%
\RequirePackage{tikz}%
\RequirePackage{xcolor}%
\RequirePackage{graphicx}%
\RequirePackage[hidelinks,bookmarksnumbered]{hyperref}%
\definecolor{tumblue}{cmyk}{1,0.43,0,0}%
\pagestyle{headings}%
\setkomafont{pageheadfoot}{\sffamily\normalcolor\small}
\AtBeginDocument{%
  \iflis@thesis@en
    \selectlanguage{english}%
  \else
    \selectlanguage{ngerman}%
    \fi
  \hypersetup{%
      bookmarks    = true,         % show bookmarks bar?
      pdftoolbar   = true,         % show Acrobat’s toolbar?
      pdfmenubar   = true,         % show Acrobat’s menu?
      pdffitwindow = false,        % window fit to page when opened
      pdfstartview = {FitH},       % fits the width of the page to the window
      pdftitle     = {\@title},    % title
      pdfauthor    = {\@author},   % author
      pdfsubject   = {\lis@thesis@type@val}, % subject of the document
      pdfcreator   = {\@author},   % creator of the document
      pdfnewwindow = true,         % links in new window
  }
}%
\define@boolkey[lis]{thesis}{en}[true]{}%
\define@boolkey[lis]{thesis}{de}[true]{%
  \iflis@thesis@de
    \lis@thesis@enfalse%
  \else
    \lis@thesis@entrue%
  \fi}%
\define@choicekey*[lis]{thesis}{language}[\val\nr]{english,german}[english]{%
  \ifcase\nr\relax
    \lis@thesis@entrue%
  \or
    \lis@thesis@enfalse%
  \fi}%
\setkeys[lis]{thesis}{en}%
\def\lis@thesis@type@master{\iflis@thesis@en Master~thesis\else Masterarbeit\fi}%
\def\lis@thesis@type@bachelor{\iflis@thesis@en Bachelor~thesis\else Bachelorarbeit\fi}%
\def\lis@thesis@type@research{\iflis@thesis@en Research~practice\else Forschungspraxis\fi}%
\def\lis@thesis@type@internship{\iflis@thesis@en Internship\else Praktikum\fi}%
\def\lis@thesis@type@diplom{\iflis@thesis@en Diplom~thesis \else Diplomarbeit\fi}%
\define@key[lis]{thesis}{type}[master]{%
  \def\lis@thesis@type@val{\csname lis@thesis@type@#1\endcsname}%
}%
\setkeys[lis]{thesis}{type}%
\newcommand{\setup}[2][]{\ClassWarningNoLine{listhesis}{Entering setup}\setkeys[lis]{thesis}{#2}}%
\define@cmdkey[lis]{thesis}{supervisor}{}%
\define@cmdkey[lis]{thesis}{advisor}{}%
\define@boolkey[lis]{thesis}{isexternal}{}%
\define@cmdkey[lis]{thesis}{company}{\lis@thesis@isexternaltrue}%
\define@cmdkey[lis]{thesis}{externalAdvisor}{\lis@thesis@isexternaltrue}%
% --- Home-university advisor/institution (for joint / double-degree theses).
%     Listed at the same level as the (TUM-side) supervisor, not as a
%     subordinate "external" line.
\define@boolkey[lis]{thesis}{ishomeuniv}{}%
\define@cmdkey[lis]{thesis}{homeAdvisor}{\lis@thesis@ishomeunivtrue}%
\define@cmdkey[lis]{thesis}{homeInstitution}{\lis@thesis@ishomeunivtrue}%
\define@cmdkey[lis]{thesis}{homeLogo}{\lis@thesis@ishomeunivtrue}%
\define@cmdkey[lis]{thesis}{AIUsage}{}%
\def\cmdlis@thesis@supervisor{Supervising Professor}%
\def\cmdlis@thesis@advisor{Advising PhD. Student}%
\def\cmdlis@thesis@externalAdvisor{Your Company Advisor}%
\def\cmdlis@thesis@company{Company the thesis was done}%
\def\cmdlis@thesis@homeAdvisor{}%
\def\cmdlis@thesis@homeInstitution{}%
\def\cmdlis@thesis@homeLogo{}%
\def\cmdlis@thesis@AIUsage{}%
\newcommand{\lis@thesis@AIUsage@item}[1]{\item #1}%
\newcommand{\lis@thesis@AIUsage@list}{%
  \begingroup
  \edef\lis@thesis@AIUsage@do{\noexpand\forcsvlist{\noexpand\lis@thesis@AIUsage@item}{\cmdlis@thesis@AIUsage}}%
  \lis@thesis@AIUsage@do
  \endgroup}%
\def\lis@thesis@authorText{\iflis@thesis@en\relax Author\else Autor\fi:}%
\def\lis@thesis@supervisorText{\iflis@thesis@en Supervisor\else Pr\"ufer\fi:}%
\def\lis@thesis@advisorText{\iflis@thesis@en Advisor\else Betreuer\fi:}%
\def\lis@thesis@companyText{\iflis@thesis@en Carried~out~at\else Durchgef\"uhrt~bei\fi:}%
\def\lis@thesis@externalAdvisorText{\iflis@thesis@en External~advisor\else Externer~Betreuer\fi:}%
\def\lis@thesis@homeAdvisorText{\iflis@thesis@en Supervisor~at~Home~Institution~\else Betreuer~(Heimatuniversit\"at)\fi:}%
\def\lis@thesis@homeInstitutionText{\iflis@thesis@en Home~Institution\else Heimatuniversit\"at\fi:}%
\def\lis@thesis@submissionDateText{\iflis@thesis@en Submission~date\else Datum~der~Abgabe\fi:}%
\define@cmdkey[lis]{thesis}{author}{\author{\cmdlis@thesis@author}}%
\define@cmdkey[lis]{thesis}{title}{\title{\cmdlis@thesis@title}}%
\define@cmdkey[lis]{thesis}{city}[\lis@thesis@default@city]{}%
\define@cmdkey[lis]{thesis}{date}[\@date]{}%
\setkeys[lis]{thesis}{city,date}%
\def\lis@thesis@default@city{\iflis@thesis@en Munich\else M\"unchen\fi}%
\def\lis@thesis@chair{\iflis@thesis@en
    Chair~of~Integrated~Systems%
  \else
    Lehrstuhl~f\"ur~Integrierte~Systeme%
  \fi}%
\def\lis@thesis@department{\iflis@thesis@en
    School~of~Computation,~Information~and~Technology%
  \else
    School~of~Computation,~Information~and~Technology%
  \fi}%
\def\lis@thesis@tum{\iflis@thesis@en
    Technical~University~of~Munich%
  \else
    Technische~Universit\"at~M\"unchen%
  \fi}%
\renewcommand{\maketitle}[2]{%
\begin{titlepage}
  \thispagestyle{empty}
  \def\lis@thesis@title@leftMargin{25mm}%
  \def\lis@thesis@title@rightMargin{25mm}%
  \def\lis@thesis@title@topMargin{25mm}%
  \renewcommand{\sfdefault}{phv}%
  \sffamily
\begin{tikzpicture}[remember picture, overlay]
  \path (current page.north east) ++(-\lis@thesis@title@rightMargin -0.5*740/390*10mm, -\lis@thesis@title@topMargin)
    node {\includegraphics[height=10mm]{img/TUM_Logo_blau_rgb_p.png}};
  % --- Second (home-university) logo, stacked below the TUM logo.
  \ifx\cmdlis@thesis@homeLogo\empty\else
    \path (current page.north east) ++(-\lis@thesis@title@rightMargin -0.5*400/134*10mm, -\lis@thesis@title@topMargin -18mm)
      node {\includegraphics[height=10mm]{\cmdlis@thesis@homeLogo}};
  \fi
  \path (current page.north west) ++(\lis@thesis@title@leftMargin, -\lis@thesis@title@topMargin)
    node[right,yshift=0.5mm, xshift=-1.5mm,color=tumblue] {%
      \parbox{100mm}{%
        \scriptsize
        \lis@thesis@chair\\
        \lis@thesis@department\\
        \lis@thesis@tum}};
  \path (current page.north) ++(0,-113mm)
    node {%
      \parbox{160mm}{%
        {\Large\bfseries\@title}\\[5ex]
        {\bfseries\lis@thesis@type@val}}};
  \path (current page.north west) ++(\lis@thesis@title@leftMargin,-113mm-70mm)
    node[right] {%
      \begin{tabular}{@{}l@{\hspace{6mm}}l@{}}
        \lis@thesis@authorText & \@author \\[2ex]
        \iflis@thesis@isexternal
          \lis@thesis@companyText & \cmdlis@thesis@company \\
          \lis@thesis@externalAdvisorText & \cmdlis@thesis@externalAdvisor \\
        \fi
        \lis@thesis@advisorText & \cmdlis@thesis@advisor \\
        \iflis@thesis@ishomeuniv
          \lis@thesis@supervisorText & \cmdlis@thesis@supervisor \\
          \lis@thesis@homeAdvisorText & \cmdlis@thesis@homeAdvisor \\
          \lis@thesis@homeInstitutionText & \cmdlis@thesis@homeInstitution \\[2ex]
        \else
          \lis@thesis@supervisorText & \cmdlis@thesis@supervisor \\[2ex]
        \fi
        \lis@thesis@submissionDateText & \cmdlis@thesis@date \\
      \end{tabular}%
    };
  \end{tikzpicture}
\renewcommand{\sfdefault}{pcr}%
\end{titlepage}}%
\newcommand{\confirmation}{%
\cleardoublepage
\thispagestyle{empty}
{\normalcolor
{\noindent\bfseries\sffamily\large\iflis@thesis@en Confirmation\else Erkl\"arung\fi}\\[5ex]
\iflis@thesis@en
  Herewith I, \@author, confirm that I independently prepared this work. No further references
  or auxiliary means except those declared in this document have been used.%
  \ifx\cmdlis@thesis@AIUsage\empty\else
    ~I have used generative AI tools for the following purposes:
    \begin{itemize}
    \lis@thesis@AIUsage@list
    \end{itemize}
  \fi
\else
  Hiermit erkl\"are ich, \@author, dass ich die vorliegende Arbeit
  selbstst\"andig und ohne Benutzung anderer als der angegebenen
  Hilfsmittel angefertigt habe.  Alle aus fremden (einschlie\ss{}lich
  elektronischer) Quellen direkt oder indirekt \"ubernommenen Gedanken
  habe ich in dieser Ausarbeitung als solche kenntlich gemacht.%
  \ifx\cmdlis@thesis@AIUsage\empty\else
    ~Ich habe generative KI-Tools f\"ur die folgenden Zwecke verwendet:
    \begin{itemize}
    \lis@thesis@AIUsage@list
    \end{itemize}
  \fi
\fi\leavevmode\\[5ex]
\cmdlis@thesis@city, \cmdlis@thesis@date\\[5ex]
\parbox{100mm}{\dotfill}\\
\@author}}
\renewcommand{\abstract}[2][]{%
  \iflis@thesis@en
    \def\lis@thesis@abstract@en{#2}%
    \def\lis@thesis@abstract@de{#1}%
  \else
    \def\lis@thesis@abstract@en{#1}%
    \def\lis@thesis@abstract@de{#2}%
  \fi}%
\newcommand{\makeabstract}{%
  \newpage\cleardoublepage
  \addchap*{Abstract}%
  \iflis@thesis@en
    \lis@thesis@abstract@en%
  \else
    \lis@thesis@abstract@de%
    \vskip 12ex%
    \ifx\lis@thesis@abstract@en\empty
      \ClassError{listhesis}{German thesis needs an English
        abstract. Use optional argument of abstract command}{}
    \else \noindent\lis@thesis@abstract@en\fi
    \fi}%
\endinput
%%
%% End of file `listhesis.cls'.
