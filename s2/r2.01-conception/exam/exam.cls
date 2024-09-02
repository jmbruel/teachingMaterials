%% Copyright Arnaud Blouin 2022
%% This file extends the standard class 'article' for 
%% being used within the app correctexam.
\ProvidesClass{exam}
              [2021/06/10 v0.1
 correctexam LaTeX document class]
\RequirePackage{xkeyval}
\LoadClass{article}

\newif\if@headerWithID

\@headerWithIDfalse

\DeclareOptionX{withid}{\@headerWithIDtrue}
\ProcessOptionsX

\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage{listings}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{mathpazo}
\RequirePackage{qcm}
\RequirePackage{ifthen}
\RequirePackage{xstring}
\PassOptionsToPackage{inline}{enumitem}
\RequirePackage{enumitem}
\RequirePackage{amssymb}
\RequirePackage{etoolbox}
\RequirePackage{multido}
\RequirePackage{fltpoint}

\linespread{1.05} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document geometry

% showframe,
\geometry{bottom=0.5cm, top=-1cm, left=1.3cm, right=1.3cm, headheight=5cm, includefoot, includehead}

\pagestyle{fancyplain}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% student ID header

\newcommand{\boxStudentID}{\fcolorbox{gray!20}{white}{\strut~~~~}}
\newcommand{\nbBoxesHeaderLine}{22}
\newcommand{\nameheader}{%
\begin{flushleft}
\large
\textbf{\small NOM :}~~~~~~~\multido{}{\nbBoxesHeaderLine}{~\boxStudentID}\\[0.1cm]
\textbf{\small PRÉNOM :}~\multido{}{\nbBoxesHeaderLine}{~\boxStudentID}%
\if@headerWithID
	\\[0.1cm]
	\textbf{\small INE :}~~~~~~~~~~\multido{}{\nbBoxesHeaderLine}{~\boxStudentID}
\else
\\
\fi
\end{flushleft}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% headers, footers

% Fix for resizing the header to match the whole size of the headers that differ on odd and even pages.
\makeatletter
\patchcmd\@outputpage{\headheight}{\ifodd\count\z@ 5cm\else 2.5cm\fi}{}{}
% Requires to adjust the footer position
\patchcmd\@outputpage{\global\@colht\textheight}{\global\advance\textheight by\ifodd\count\z@ 2.5cm\else -2.5cm\fi\global\@colht\textheight}{}{}
\makeatother

\lhead[\scalebox{5}{$\bullet$}]{\scalebox{5}{$\bullet$}}
\rhead[\scalebox{5}{$\bullet$}]{\scalebox{5}{$\bullet$}}
\chead[]{%
\begin{minipage}[t]{1\textwidth}%
  \vspace*{0.3cm}\nameheader%
\end{minipage}%
}
\lfoot[\scalebox{5}{$\bullet$}]{\scalebox{5}{$\bullet$}}
\rfoot[\scalebox{5}{$\bullet$}]{\scalebox{5}{$\bullet$}}
\cfoot[\large\thepage~~/~~\pageref{LastPage}]{\large\thepage~~/~~\pageref{LastPage}}

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question

\newcounter{Q}
\stepcounter{Q}
\newcommand{\questionExam}[1]{%
  \smallskip%
  \noindent\textbf{Q.\arabic{Q}}\stepcounter{Q}~#1%
  \medskip
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercice
     
\newcounter{QE}
\stepcounter{QE}
\newcommand{\exerciceExam}[2]{%
  \StrLen{#2}[\mystringlen]%
  \ifthenelse{\mystringlen > 0}{\def\@temp{-- #2}}{\def\@temp{}}%
  \section{Exercice \arabic{QE} \@temp{} ($\approx$ #1 points)}%
  \stepcounter{QE}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QCM

\newlist{qcmExam}{enumerate}{2}%\addtocounter{Q}{-1}
\setlist[qcmExam,1]{labelindent=\parindent, label={\textbf{Q.\arabic{Q}\protect\stepcounter{Q}}}, leftmargin=*, before=\addtocounter{Q}{-1}}
%,  before={\bfseries\setlength{\rightmargin}{\leftmargin}}}
\setlist[qcmExam,2]{label={\large $\square$}, before={\normalfont}, leftmargin=0pt}

%\newlist{qcmExam*}{enumerate*}{1}
%\setlist[qcmExam*]{label={\large $\square$}, before={\normalfont}, itemjoin=\hspace{1cm}, before={\hspace*{-\leftmargin}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Answer zone (box)

% The color of the line dots
\newcommand{\answerExamDotColor}{black}

% First argument: color (optional, by default black). The color of the dots. Put white for no dot.
% Second parameter: the line spacing
% Third argument: the number of lines
% Fourth argument: the number of columns
\newcommand{\answerExam}[4][black]{%
% setting the dot color
\renewcommand{\answerExamDotColor}{#1}
% Creating the required number of columns
\multido{}{#4}{%
% Computing the width of each column
\fpDiv{\answercolwidthExam}{1}{#4}
% One minipage for each column
\noindent\begin{minipage}[t]{\answercolwidthExam\textwidth}
% Boxing each column
\noindent\fbox{\parbox{\textwidth}{%
  % Setting the seelcted color
  \color{\answerExamDotColor}%
%  \par\nobreak%
  % Provides a larger gap between the preceding paragraph and the dots
  \noindent\rule{0pt}{1.5\baselineskip}%
  % Producing a dotted line
  \multido{}{#3}{\noindent\makebox[\linewidth]{\rule{0pt}{#2\baselineskip}\dotfill}\endgraf}%
  }}
\end{minipage}
}
  % Gap between dots and next paragraph
  \bigskip
  % Setting back the default dot color
  \renewcommand{\answerExamDotColor}{black}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inline text box

\newcommand{\inlineAnswerBox}[1][10]{%
\fpSub{\spacestoinclude}{#1}{1}%
\fcolorbox{gray}{white}{\strut\multido{}{\spacestoinclude}{~}}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixing widow

\clubpenalty=10000
\widowpenalty=10000
\tolerance=1000

\endinput
