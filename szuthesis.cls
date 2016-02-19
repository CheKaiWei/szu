%%
%% This is file `szuthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% szuthesis.dtx  (with options: `cls')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2005-2009 by Ruini Xue <xueruini@gmail.com>
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3a
%% of this license or (at your option) any later version.
%% The latest version of this license is in:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3a or later is part of all distributions of LaTeX
%% version 2004/10/01 or later.
%% 
%% To produce the documentation run the original source files ending with `.dtx'
%% through LaTeX.
%% 

%%%%基本信息
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{szuthesis}
[2008/02/28 4.5.1 Tsinghua University Thesis Template]

%%%% 理解newif https://groups.google.com/forum/?hl=ja&nomobile=true#!topic/szuthesis/BS4WjqTA4A0
%%%%
\newif\ifszu@UTF
\newif\ifszu@GBK
\DeclareOption{utf}{\szu@UTFtrue\szu@GBKfalse}
\DeclareOption{gbk}{\szu@GBKtrue\szu@UTFfalse}

%%%%定义论文类型是否涉密
\hyphenation{szu-Thesis}
\def\szuthesis{\textsc{szuThesis}}
\def\version{4.5}

\newif\ifszu@bachelor\szu@bachelorfalse
\newif\ifszu@master\szu@masterfalse
\newif\ifszu@doctor\szu@doctorfalse
\newif\ifszu@secret\szu@secretfalse
\DeclareOption{bachelor}{\szu@bachelortrue}
\DeclareOption{master}{\szu@mastertrue}
\DeclareOption{doctor}{\szu@doctortrue}
\DeclareOption{secret}{\szu@secrettrue}


%%%%使用dvips,dvipdfm, pdflatex, 还是xelatex
\newif\ifszu@dvips
\newif\ifszu@dvipdfm
\newif\ifszu@xetex
\newif\ifszu@pdftex

\DeclareOption{dvips}{\szu@dvipstrue}
\DeclareOption{dvipdfm}{\szu@dvipdfmtrue}
\DeclareOption{pdftex}{\szu@pdftextrue}
\DeclareOption{xetex}{\szu@xetextrue}

%%%%如果需要arial字体，请打开[arial]选项
\newif\ifszu@arial
\DeclareOption{arial}{\szu@arialtrue}
%%%%目录中英文是否用arial
\newif\ifszu@arialtoc
\DeclareOption{arialtoc}{\szu@arialtoctrue}
%%%%章节标题中的英文是否用arial
\newif\ifszu@arialtitle
\DeclareOption{arialtitle}{\szu@arialtitletrue}
%%%%将选项传递给book类
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{utf,arialtitle} %%%%\ExecuteOptions 的参数之间用逗号分割，不能有空格。
\ProcessOptions\relax
\LoadClass[12pt,a4paper,openany]{book}

%%%%用户至少提供一个选项：指定论文类型
\ifszu@bachelor\relax\else
  \ifszu@master\relax\else
    \ifszu@doctor\relax\else
      \ClassError{szuthesis}%
                 {You have to specify one of thesis options: bachelor, master or doctor.}{}
    \fi
  \fi
\fi

%%%%检查用户指定的选项和实际编译命令是否冲突
\RequirePackage{ifpdf,ifxetex}

\ifszu@xetex\RequireXeTeX\fi
\def\RequirePDFTeX{%
  \ifpdf
  \else
  %%%% original: szuthesis --> szuthesis
    \ClassError{szuthesis}%
               {pdflatex is required to compile this document!}{}
  \fi}
\ifszu@pdftex\RequirePDFTeX\fi
\def\szu@checkoption#1#2{%
  \@for\reserved@a:=#2\do{%
    \csname ifszu@\reserved@a\endcsname
	%%%% original: szuthesis --> szuthesis
      \ClassError{szuthesis}%
                 {Please remove `\reserved@a' option when you run #1.}{}
    \fi}}

\ifpdf\szu@checkoption{pdflatex}{dvips,dvipdfm,xetex}\szu@pdftextrue\fi % force the option to be true
\ifxetex\szu@checkoption{xelatex}{dvips,dvipdfm,pdftex}\szu@xetextrue\fi

%%%%装载宏包
\RequirePackage{ifthen,calc}
\RequirePackage{amsmath,amssymb}
\RequirePackage{txfonts}
\RequirePackage{graphicx}
\RequirePackage[config]{subfig}
\RequirePackage{indentfirst}
\RequirePackage[neverdecrease]{paralist}

\ifszu@xetex
  \RequirePackage{xunicode,xltxtra}
  \RequirePackage[CJKnumber,CJKtextspaces,CJKmathspaces]{xeCJK}
  \punctstyle{kaiming}
  % todo: minor fix of CJKnumb
  \def\CJK@null{\kern\CJKnullspace\Unicode{48}{7}\kern\CJKnullspace}
  \defaultfontfeatures{Mapping=tex-text} % after fontspec
  \setCJKmainfont[BoldFont={Adobe Heiti Std}, ItalicFont={Adobe Kaiti Std}]{Adobe Song Std}
  \setCJKsansfont{Adobe Heiti Std}
  \setCJKmonofont{Adobe Kaiti Std}
  \setCJKfamilyfont{song}{Adobe Song Std}
  \setCJKfamilyfont{hei}{Adobe Heiti Std}
  \setCJKfamilyfont{fs}{Adobe Fangsong Std}
  \setCJKfamilyfont{kai}{Adobe Kaiti Std}
  \setCJKfamilyfont{li}{Adobe Kaiti Std} % todo: 用隶书字体代替
  \setCJKfamilyfont{you}{Adobe Kaiti Std} % todo: 用幼圆字体代替

  \setmainfont{Times New Roman}
  \setsansfont{Arial}
  \setmonofont{Courier New}
\else
  \RequirePackage{CJKutf8}
  \RequirePackage{CJKnumb}
  \ifszu@GBK % CJKpnct 在 UTF 下工作的不好。
    \IfFileExists{CJKpunct.sty}%
                 {\RequirePackage{CJKpunct}}%
                 {\ClassWarning{szuthesis}{no CJKpunct.sty availiable!}}
  \fi
  \RequirePackage{CJKspace}
  \ifszu@arial
    \IfFileExists{arial.sty}%
                 {\RequirePackage{arial}}%
                 {\ClassWarning{szuthesis}{no arial.sty availiable!}}
  \fi
\fi

\ifszu@dvips\else
  \ifszu@xetex\else
    \RequirePackage{ccmap}
  \fi
\fi

\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage[numbers,super,sort&compress]{natbib}
\RequirePackage{hyperref}


\ifxetex
  \hypersetup{%
    CJKbookmarks=true}
\else
  \hypersetup{%
    unicode=true,
    CJKbookmarks=false}
\fi

\hypersetup{%
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=1,
  breaklinks=true,
  colorlinks=false,
  plainpages=false,
  pdfpagelabels,
  pdfborder=0 0 0}
  
\ifszu@dvips
  \RequirePackage{breakurl}
\fi

\urlstyle{same}

\RequirePackage{hypernat}

%%%%Three matters
\renewcommand\frontmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{szu@empty}}
\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}
  \ifszu@bachelor\pagestyle{szu@plain}\else\pagestyle{szu@headings}\fi}
\renewcommand\backmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue}
  
%%%%重定义字体命令
\newcommand{\song}{\CJKfamily{song}}    % 宋体
\def\songti{\song}
\newcommand{\fs}{\CJKfamily{fs}}        % 仿宋体
\def\fangsong{\fs}
\newcommand{\kai}{\CJKfamily{kai}}      % 楷体
\def\kaishu{\kai}
\newcommand{\hei}{\CJKfamily{hei}}      % 黑体
\def\heiti{\hei}
\newcommand{\li}{\CJKfamily{li}}        % 隶书
\def\lishu{\li}
\newcommand{\you}{\CJKfamily{you}}      % 幼圆
\def\youyuan{\you}

\newlength\szu@linespace
\newcommand{\szu@choosefont}[2]{%
   \setlength{\szu@linespace}{#2*\real{#1}}%
   \fontsize{#2}{\szu@linespace}\selectfont}
\def\szu@define@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][\baselinestretch]{%
    \szu@choosefont{##1}{#2}}}
%%%%重定义字号命令	
\szu@define@fontsize{chuhao}{42bp}
\szu@define@fontsize{xiaochu}{36bp}
\szu@define@fontsize{yihao}{26bp}
\szu@define@fontsize{xiaoyi}{24bp}
\szu@define@fontsize{erhao}{22bp}
\szu@define@fontsize{xiaoer}{18bp}
\szu@define@fontsize{sanhao}{16bp}
\szu@define@fontsize{xiaosan}{15bp}
\szu@define@fontsize{sihao}{14bp}
\szu@define@fontsize{banxiaosi}{13bp}
\szu@define@fontsize{xiaosi}{12bp}
\szu@define@fontsize{dawu}{11bp}
\szu@define@fontsize{wuhao}{10.5bp}
\szu@define@fontsize{xiaowu}{9bp}
\szu@define@fontsize{liuhao}{7.5bp}
\szu@define@fontsize{xiaoliu}{6.5bp}
\szu@define@fontsize{qihao}{5.5bp}
\szu@define@fontsize{bahao}{5bp}

%%%%正文小四号（12pt）字，行距为固定值20磅。
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}
  \abovedisplayskip=10bp \@plus 2bp \@minus 2bp
  \abovedisplayshortskip=10bp \@plus 2bp \@minus 2bp
  \belowdisplayskip=\abovedisplayskip
  \belowdisplayshortskip=\abovedisplayshortskip}
%%%%页面设置
\AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}
\AtBeginDvi{\special{!%
      \@percentchar\@percentchar BeginPaperSize: a4
      ^^Ja4^^J\@percentchar\@percentchar EndPaperSize}}
\setlength{\textwidth}{\paperwidth}
\setlength{\textheight}{\paperheight}
\setlength\marginparwidth{0cm}
\setlength\marginparsep{0cm}
\addtolength{\textwidth}{-6.4cm}
\setlength{\oddsidemargin}{3.2cm-1in}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\headheight}{20pt}
\setlength{\topskip}{0pt}
\setlength{\skip\footins}{15pt}
\setlength{\topmargin}{2.8cm-1in}

\ifszu@bachelor
  \setlength{\footskip}{1.3cm}
  \setlength{\headsep}{0.6cm}
  \addtolength{\textheight}{-7.8cm}
\else
  \setlength{\footskip}{1.5cm}
  \setlength{\headsep}{0.5cm}
  \addtolength{\textheight}{-8.6cm}
\fi
%%%%页眉页脚
%%%%新的一章最好从奇数页开始（openright），
%%%%所以必须保证它前面那页如果没有内容也必须没有页眉页脚。（code stolen from fancyhdr）
\let\szu@cleardoublepage\cleardoublepage
\newcommand{\szu@clearemptydoublepage}{%
  \clearpage{\pagestyle{empty}\szu@cleardoublepage}}
\let\cleardoublepage\szu@clearemptydoublepage
%%%%    定义三种页眉页脚格式：
%%%%    szu@empty: 页眉页脚都没有
%%%%    szu@plain: 只显示页脚的页码
%%%% szu@headings: 页眉页脚同时显示
\def\ps@szu@empty{%
  \let\@oddhead\@empty%
  \let\@evenhead\@empty%
  \let\@oddfoot\@empty%
  \let\@evenfoot\@empty}
\def\ps@szu@plain{%
  \let\@oddhead\@empty%
  \let\@evenhead\@empty%
  \def\@oddfoot{\hfil\wuhao\thepage\hfil}%
  \let\@evenfoot=\@oddfoot}
\def\ps@szu@headings{%
  \def\@oddhead{\vbox to\headheight{%
      \hb@xt@\textwidth{\hfill\wuhao\song\leftmark\ifszu@bachelor\relax\else\hfill\fi}%
      \vskip2pt\hbox{\vrule width\textwidth height0.4pt depth0pt}}}
  \def\@evenhead{\vbox to\headheight{%
      \hb@xt@\textwidth{\wuhao\song%
      \ifszu@bachelor\szu@schoolename\szu@bachelor@subtitle%
       \else\hfill\leftmark\fi\hfill}%
      \vskip2pt\hbox{\vrule width\textwidth height0.4pt depth0pt}}}
  \def\@oddfoot{\hfil\wuhao\thepage\hfil}
  \let\@evenfoot=\@oddfoot}
%%%%书签
\renewcommand{\chaptermark}[1]{\@mkboth{\@chapapp\  ~~#1}{}}

%%%%段落
\newlength\CJK@twochars
\ifxetex
  \def\CJK@spaceChar{\Unicode{48}{7}}
\else
  \ifszu@UTF
    \def\CJK@spaceChar{\CJKchar{"080}{"080}}
  \fi
  \ifszu@GBK
    \def\CJK@spaceChar{\CJKchar{"0A1}{"0A1}}
  \fi
\fi
\def\CJKindent{%
  \settowidth\CJK@twochars{\CJK@spaceChar\CJK@spaceChar}%
  \parindent\CJK@twochars}
%%%%段落之间的竖直距离
\setlength{\parskip}{0pt \@plus2pt \@minus0pt}
%%%%调整默认列表环境间的距离，以符合中文习惯。
\def\szu@item@space{%
  \let\itemize\compactitem
  \let\enditemize\endcompactitem
  \let\enumerate\compactenum
  \let\endenumerate\endcompactenum
  \let\description\compactdesc
  \let\enddescription\endcompactdesc}
%%%%从perpage.sty中抽取的代码，使footnote按页编号。不再用臃肿的footmisc.
\newcommand*\MakePerPage[2][\@ne]{%
  \expandafter\def\csname c@pchk@#2\endcsname{\c@pchk@{#2}{#1}}%
  \newcounter{pcabs@#2}%
  \@addtoreset{pchk@#2}{#2}}
\def\new@pagectr#1{\@newl@bel{pchk@#1}}
\def\c@pchk@#1#2{\z@=\z@
  \begingroup
  \expandafter\let\expandafter\next\csname pchk@#1@\arabic{pcabs@#1}\endcsname
  \addtocounter{pcabs@#1}\@ne
  \expandafter\ifx\csname pchk@#1@\arabic{pcabs@#1}\endcsname\next
  \else \setcounter{#1}{#2}\fi
  \protected@edef\next{%
    \string\new@pagectr{#1}{\arabic{pcabs@#1}}{\noexpand\thepage}}%
  \protected@write\@auxout{}{\next}%
  \endgroup\global\z@}
\MakePerPage{footnote}
%%%%生成带圈的脚注数字。最多处理到99，当然这个也很容易扩展。
\def\szu@textcircled#1{%
  \ifnum \value{#1} <10 \textcircled{\xiaoliu\arabic{#1}}
  \else\ifnum \value{#1} <100 \textcircled{\qihao\arabic{#1}}\fi
  \fi}
\renewcommand{\thefootnote}{\szu@textcircled{footnote}}
\renewcommand{\thempfootnote}{\szu@textcircled{mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\szu@footnotesize\footnotesize
\renewcommand\footnotesize{\szu@footnotesize\xiaowu[1.5]}
\def\@makefnmark{\textsuperscript{\hbox{\normalfont\@thefnmark}}}
\long\def\@makefntext#1{
    \bgroup
      \setbox\@tempboxa\hbox{%
        \hb@xt@ 2em{\@thefnmark\hss}}
      \leftmargin\wd\@tempboxa
      \rightmargin\z@
      \linewidth \columnwidth
      \advance \linewidth -\leftmargin
      \parshape \@ne \leftmargin \linewidth
      \footnotesize
      \@setpar{{\@@par}}%
      \leavevmode
      \llap{\box\@tempboxa}%
      #1
    \par\egroup}
%%%%数学相关：允许太长的公式断行、分页等
\allowdisplaybreaks[4]
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}
\def\make@df@tag{\@ifstar\szu@make@df@tag@@\make@df@tag@@@}
\def\szu@make@df@tag@@#1{\gdef\df@tag{\szu@maketag{#1}\def\@currentlabel{#1}}}
\renewcommand{\eqref}[1]{\textup{(\ref{#1})}}
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}
\def\szu@maketag#1{\maketag@@@{(\ignorespaces #1\unskip\@@italiccorr)}}
\def\tagform@#1{\maketag@@@{(\ignorespaces #1\unskip\@@italiccorr)\equcaption{#1}}}
\gdef\@endtrivlist#1{%  % from \endtrivlist
  \if@inlabel \indent\fi
  \if@newlist \@noitemerr\fi
  \ifhmode
    \ifdim\lastskip >\z@ #1\unskip \par  %<<<<<<<<<<<<<<<<<<<<<<
      \else #1\unskip \par \fi
  \fi
  \if@noparlist \else
    \ifdim\lastskip >\z@
       \@tempskipa\lastskip \vskip -\lastskip
      \advance\@tempskipa\parskip \advance\@tempskipa -\@outerparskip
      \vskip\@tempskipa
    \fi
    \@endparenv
  \fi #1}
\theorembodyfont{\song\rmfamily}
\theoremheaderfont{\hei\rmfamily}
%%%%浮动对象以及表格
%%%%设置浮动对象和文字之间的距离
\setlength{\floatsep}{12bp \@plus4pt \@minus1pt}
\setlength{\intextsep}{12bp \@plus4pt \@minus2pt}
\setlength{\textfloatsep}{12bp \@plus4pt \@minus2pt}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
%%%%下面这组命令使浮动对象的缺省值稍微宽松一点，从而防止幅度对象占据过多的文本页面，
%%%%也可以防止在很大空白的浮动页上放置很小的图形。
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
%%%%定制浮动图形和表格标题样式
%%%%图标标题字体为11pt, 这里写作大五号
%%%%去掉图表号后面的冒号。图序与图文文字之间空一格汉字符宽度。
%%%%图：caption在下，段前空6磅，段后空12磅
%%%%表：caption在上，段前空12磅，段后空6磅
\let\old@tabular\@tabular
\def\szu@tabular{\dawu[1.5]\old@tabular}
\DeclareCaptionLabelFormat{szu}{{\dawu[1.5]\song #1~\rmfamily #2}}
\DeclareCaptionLabelSeparator{szu}{\hspace{1em}}
\DeclareCaptionFont{szu}{\dawu[1.5]}
\captionsetup{labelformat=szu,labelsep=szu,font=szu}
\captionsetup[table]{position=top,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[subfloat]{labelformat=simple,font=szu,captionskip=6bp,nearskip=6bp,farskip=0bp,topadjust=0bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
%%%%采用longtable来处理跨页的表格。同样需要设置其默认字体为五号
\let\szu@LT@array\LT@array
\def\LT@array{\dawu[1.5]\szu@LT@array} % set default font size
%%%%简单的表格使用三线表推荐用\hlinewd.如果表格比较复杂还是用booktabs的命令好一些。
\def\hlinewd#1{%
  \noalign{\ifnum0=`}\fi\hrule \@height #1 \futurelet
    \reserved@a\@xhline}
	
%%%%章节标题。如果章节题目中的英文要使用arial,那么就加上\sffamily
\ifszu@arialtitle
  \def\szu@title@font{\sffamily}
\fi
%%%%章序号与章名之间空一个汉字符黑体三号字，居中书写，单倍行距，段前空24磅，段后空18磅。
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi\phantomsection%
                    \ifszu@bachelor\thispagestyle{szu@plain}%
                    \else\thispagestyle{szu@headings}\fi%
                    \global\@topnum\z@%
                    \@afterindenttrue%
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
   \if@mainmatter
     \refstepcounter{chapter}%
     \addcontentsline{toc}{chapter}{\protect\numberline{\@chapapp}#1}%TODO: shit
   \else
     \addcontentsline{toc}{chapter}{#1}%
   \fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \@makechapterhead{#2}}
\def\@makechapterhead#1{%
  \vspace*{20bp}%
  {\parindent \z@ \centering
    \hei\csname szu@title@font\endcsname\ifszu@bachelor\xiaosan\else\sanhao[1]\fi
    \ifnum \c@secnumdepth >\m@ne
      \@chapapp\hskip1em
    \fi
    #1\par\nobreak
    \vskip 24bp}}
\def\@schapter#1{%
  \@makeschapterhead{#1}
  \@afterheading}
\def\@makeschapterhead#1{%
  \vspace*{20bp}%
  {\parindent \z@ \centering
   \hei\csname szu@title@font\endcsname\sanhao[1]
   \ifszu@bachelor\xiaosan\else
     \def\@tempa{#1}
     \def\@tempb{\eabstractname}
     \ifx\@tempa\@tempb\bfseries\fi
   \fi
   \interlinepenalty\@M
   #1\par\nobreak
   \vskip 24bp}}
\newcounter{szu@bookmark}
%%%%\thu@chapter* 用来处理清华大学对于本科生、硕士生与博生生的不同要求。
\def\szu@chapter*{%
  \@ifnextchar [ % ]
    {\szu@@chapter}
    {\szu@@chapter@}}
\def\szu@@chapter@#1{\szu@@chapter[#1]{#1}}
\def\szu@@chapter[#1]#2{%
  \@ifnextchar [ % ]
    {\szu@@@chapter[#1]{#2}}
    {\szu@@@chapter[#1]{#2}[]}}
\def\szu@@@chapter[#1]#2[#3]{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \phantomsection
  \def\@tmpa{#1}
  \def\@tmpb{#3}
  \ifx\@tmpa\@empty
    \addtocounter{szu@bookmark}\@ne
    \pdfbookmark[0]{#2}{szuchapter.\theszu@bookmark}
  \else
    \addcontentsline{toc}{chapter}{#1}
  \fi
  \chapter*{#2}
  \ifx\@tmpb\@empty
    \@mkboth{#2}{#2}
  \else
    \@mkboth{#3}{#3}
  \fi}
%%%%一级节标题，例如：2.1 实验装置与实验方法节标题序号与标题名之间空一个汉字符（下同）。
%%%%采用黑体四号（14pt）字居左书写，行距为固定值20磅，段前空24磅，段后空6磅。
\renewcommand\section{\@startsection {section}{1}{\z@}%
                     {\ifszu@bachelor -20bp\else -24bp\fi\@plus -1ex \@minus -.2ex}%
                     {6bp \@plus .2ex}%
                     {\hei\csname szu@title@font\endcsname\sihao[1.429]}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                        {\ifszu@bachelor -12bp\else -16bp\fi\@plus -1ex \@minus -.2ex}%
                        {6bp \@plus .2ex}%
                        {\hei\csname szu@title@font\endcsname\ifszu@bachelor\xiaosi[1.667]\else\banxiaosi[1.538]\fi}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                           {\ifszu@bachelor -12bp\else -16bp\fi\@plus -1ex \@minus -.2ex}%
                           {6bp \@plus .2ex}%
                           {\hei\csname szu@title@font\endcsname\xiaosi[1.667]}}
\setcounter{secnumdepth}{3}
\ifszu@doctor
  \setcounter{tocdepth}{2}
\else
  \setcounter{tocdepth}{3}
\fi
%%%%目录生成命令
\renewcommand\tableofcontents{%
  \szu@chapter*[]{\contentsname}
  \ifszu@bachelor\xiaosi[1.8]\else\xiaosi[1.5]\fi\@starttoc{toc}\normalsize}
\ifszu@arialtoc
  \def\szu@toc@font{\sffamily}
\fi
\def\@pnumwidth{2em} % 这个参数没用了
\def\@tocrmarg{2em}
\def\@dotsep{1} % 目录点间的距离
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
    \interlinepenalty\@M
    \leavevmode
    \@tempdima #3\relax
    \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
    {\csname szu@toc@font\endcsname #4}\nobreak
    \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
    \nobreak{\normalfont \normalcolor #5}%
    \par}%
  \fi}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 4bp \@plus\p@
    \setlength\@tempdima{4em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      {\hei\ifszu@bachelor\sffamily\else\csname szu@toc@font\endcsname\fi #1} % numberline is called here, and it uses \@tempdima
      \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak{\normalfont\normalcolor #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@section{\@dottedtocline{1}{\ifszu@bachelor 1.0em\else 1.2em\fi}{2.1em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{\ifszu@bachelor 1.6em\else 2em\fi}{3em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{\ifszu@bachelor 2.4em\else 3.5em\fi}{3.8em}}
%%%%封面和封底
%%%%方便的定义封面的一些替换命令
\def\szu@define@term#1{
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname szu@#1\endcsname{##1}}
  \csname #1\endcsname{}}
%%%%封面、摘要、版权、致谢格式定义
\szu@define@term{secretlevel}
\szu@define@term{secretyear}
\szu@define@term{ctitle}
\szu@define@term{cdegree}
\newcommand\cdepartment[2][]{\def\szu@cdepartment@short{#1}\def\szu@cdepartment{#2}}
\def\caffil{\cdepartment} % todo: for compatibility
\def\szu@cdepartment@short{}
\def\szu@cdepartment{}
\szu@define@term{cmajor}
%%%%封面添加学号信息, define term
\szu@define@term{studentID}
\szu@define@term{professionaltitle}

\def\csubject{\cmajor} % todo: for compatibility
\szu@define@term{cauthor}
\szu@define@term{csupervisor}
\szu@define@term{cassosupervisor}
\szu@define@term{ccosupervisor}
\szu@define@term{cdate}
\szu@define@term{etitle}
\szu@define@term{edegree}
\szu@define@term{edepartment}
\def\eaffil{\edepartment} % todo: for compability
\szu@define@term{emajor}
\def\esubject{\emajor} % todo: for compability
\szu@define@term{eauthor}
\szu@define@term{esupervisor}
\szu@define@term{eassosupervisor}
\szu@define@term{ecosupervisor}
\szu@define@term{edate}
\long\@xp\def\@xp\collect@@body\@xp#\@xp1\@xp\end\@xp#\@xp2\@xp{%
  \collect@@body{#1}\end{#2}}
\long\@xp\def\@xp\push@begins\@xp#\@xp1\@xp\begin\@xp#\@xp2\@xp{%
  \push@begins{#1}\begin{#2}}
\long\@xp\def\@xp\addto@envbody\@xp#\@xp1\@xp{%
  \addto@envbody{#1}}
\newcommand{\szu@@cabstract}[1]{\long\gdef\szu@cabstract{#1}}
\newenvironment{cabstract}{\collect@body\szu@@cabstract}{}
\newcommand{\szu@@eabstract}[1]{\long\gdef\szu@eabstract{#1}}
\newenvironment{eabstract}{\collect@body\szu@@eabstract}{}
\def\szu@parse@keywords#1{
  \expandafter\gdef\csname szu@#1\endcsname{} % todo: need or not?
  \expandafter\gdef\csname #1\endcsname##1{
    \@for\reserved@a:=##1\do{
      \expandafter\ifx\csname szu@#1\endcsname\@empty\else
        \expandafter\g@addto@macro\csname szu@#1\endcsname{\ignorespaces\csname szu@#1@separator\endcsname}
      \fi
      \expandafter\expandafter\expandafter\g@addto@macro%
        \expandafter\csname szu@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
\szu@parse@keywords{ckeywords}
\szu@parse@keywords{ekeywords}
%%%%论文封面第一页！
%%%%原清华大学样式：
%%%%题名使用一号黑体字，一行写不下时可分两行写，并采用1.25倍行距。
%%%%申请学位的学科门类：小二号宋体字。
%%%%中文封面页边距：上-6.0厘米，下-5.5厘米，左-4.0厘米，右-4.0厘米，装订线0厘米。
\newlength{\szu@title@width}
\def\szu@put@title#1{\makebox{\hb@xt@ \szu@title@width{#1}}}
\newcommand{\szu@first@titlepage}{
  \begin{center}
    \vspace*{-1.3cm}
    \parbox[b][2.4cm][t]{\textwidth}{%
      \ifszu@secret\hfill{\sihao\szu@secret@title}\else\rule{1cm}{0cm}\fi}
    \ifszu@bachelor
      \vskip0.2cm
	  %%%%学校名
      {\ziju{10bp}\xiaochu\kai\textbf\szu@schoolename}
      \par\vskip0.9cm
      {\ziju{8bp}\xiaoyi\hei\szu@bachelor@subtitle}
      \vskip2.5cm
	  %%%%原清华大学题目
      %%%%\noindent\hei\xiaoer\szu@bachelor@title@pre\szu@title@sep
      %%%%\parbox[t]{12cm}{%
      %%%%  \setbox0=\hbox{{\yihao[1.55]\szu@ctitle}}
      %%%%  \begin{picture}(0,0)(0,0)
      %%%%    \setlength\unitlength{1cm}
      %%%%    \linethickness{1.3pt}
      %%%%    \put(0,-0.25){\line(1,0){12}}
      %%%%    \ifdim\wd0>12cm
      %%%%      \put(0,-1.68){\line(1,0){12}}
      %%%%    \fi
      %%%%  \end{picture}%
      %%%% \ignorespaces\yihao[1.55]\szu@ctitle} %TODO: CJKulem.sty
      %%%%\vskip1.55cm
    \else
      \parbox[t][9cm][t]{\paperwidth-8cm}{
      \renewcommand{\baselinestretch}{1.5}
      \begin{center}
      \yihao[1.2]{\hei\sffamily\szu@ctitle}\par
      \ifszu@master
        \erhao[1.1] \textbf{\sffamily\szu@etitle}\par\vskip 5bp
      \else % for doctor
        \par\vskip 20bp
      \fi
      \xiaoer[1] \textrm{{\ziju{2bp}\szu@apply}}
      \end{center}}
    \fi
	%%%%封面中间信息
	%%%%作者及导师信息部分使用三号仿宋字
    \ifszu@bachelor
      \vskip1cm
      \parbox[t][7.0cm][t]{\textwidth}{{\sanhao[1.8]
        \hspace*{1.65cm}\fs
          \setlength{\szu@title@width}{4em}
          \setlength{\extrarowheight}{6pt}
          \ifxetex % todo: ugly codes
            \begin{tabular}{p{\szu@title@width}@{}l@{\extracolsep{8pt}}l}
          \else
            \begin{tabular}{p{\szu@title@width}l@{}l}
          \fi
			  \szu@put@title{\szu@bachelor@title@pre}       & \szu@title@sep & \szu@ctitle\\  %%%%深圳大学论文题目
			  \szu@put@title{\szu@bachelor@authortitle}     & \szu@title@sep & \szu@cauthor \\
			  \szu@put@title{\szu@bachelor@majortitle}      & \szu@title@sep & \szu@cmajor\\
              \szu@put@title{\szu@bachelor@departmenttitle} & \szu@title@sep & \szu@cdepartment\\
              \szu@put@title{\szu@bachelor@studentID}       & \szu@title@sep & \szu@studentID \\
              \szu@put@title{\szu@csupervisortitle}         & \szu@title@sep & \szu@csupervisor\\
			  \szu@put@title{\szu@bachelor@professionaltitle}       & \szu@title@sep & \szu@professionaltitle \\
              \ifx\szu@cassosupervisor\@empty\else
                \szu@put@title{\szu@cassosupertitle}        & \szu@title@sep & \szu@cassosupervisor\\
              \fi
            \end{tabular}
        }}
    \else
      \parbox[t][7.8cm][t]{\textwidth}{{\sanhao[1.5]
        \begin{center}\fs
          \setlength{\szu@title@width}{6em}
          \setlength{\extrarowheight}{4pt}
          \ifxetex % todo: ugly codes
            \begin{tabular}{p{\szu@title@width}@{}c@{\extracolsep{8pt}}l}
          \else
            \begin{tabular}{p{\szu@title@width}c@{\extracolsep{4pt}}l}
          \fi
              \szu@put@title{\szu@cdepartmenttitle}  & \szu@title@sep & {\ziju{3bp}\szu@cdepartment}\\
              \szu@put@title{\szu@cmajortitle}       & \szu@title@sep & {\ziju{3bp}\szu@cmajor}\\
              \szu@put@title{\szu@cauthortitle}      & \szu@title@sep & {\ziju{11bp}\szu@cauthor}\\
              \szu@put@title{\szu@csupervisortitle}  & \szu@title@sep & {\ziju{11bp}\szu@csupervisor}\\
              \ifx\szu@cassosupervisor\@empty\else
                \szu@put@title{\szu@cassosupertitle} & \szu@title@sep & {\ziju{11bp}\szu@cassosupervisor}\\
              \fi
              \ifx\szu@ccosupervisor\@empty\else
                \szu@put@title{\szu@ccosupertitle}   & \szu@title@sep & {\ziju{11bp}\szu@ccosupervisor}\\
              \fi
            \end{tabular}
        \end{center}}}
      \fi
	  %%%%封面日期
	  %%%%论文成文打印的日期，用三号宋体汉字，不用阿拉伯数字。
     \begin{center}
		\vskip5cm
       {\ifszu@bachelor\hskip-0.9cm\xiaosi\else\sanhao\fi \song \szu@cdate}
     \end{center}
    \end{center}} % end of titlepage
	%%%%博士论文英文封面部分
\newcommand{\szu@doctor@engcover}{%
  \begin{center}
    \vspace*{0.2cm}
    \parbox[t][5.2cm][t]{\paperwidth-7.2cm}{
      \renewcommand{\baselinestretch}{1.5}
      \begin{center}
        \erhao[1.1]\bfseries\sffamily\szu@etitle
      \end{center}}
    \parbox[t][5.8cm][t]{\paperwidth-7.2cm}{
      \renewcommand{\baselinestretch}{1.3}
      \begin{center}
        \sanhao Dissertation Submitted to\\
        {\bfseries Tsinghua University}\\
        in partial fulfillment of the requirement\\
        for the degree of\\
        {\bfseries\sffamily\szu@edegree}
      \end{center}}
    \parbox[t][3.6cm][b]{\paperwidth-7.2cm}{
      \renewcommand{\baselinestretch}{1.3}
      \begin{center}
        \sanhao\sffamily by\\[3bp]
        \bfseries\szu@eauthor\\(~\szu@emajor~)
      \end{center}}
    \par\vspace{0.9cm}
    \parbox[t][2.1cm][t]{\paperwidth-7.2cm}{
      \renewcommand{\baselinestretch}{1.2}\xiaosan\centering
      \begin{tabular}{rl}
        Dissertation Supervisor : & \szu@esupervisor\\
        \ifx\szu@eassosupervisor\@empty
          \else Associate Supervisor : & \szu@eassosupervisor\\\fi
        \ifx\szu@ecosupervisor\@empty
          \else Cooperate Supervisor : & \szu@ecosupervisor\\\fi
      \end{tabular}}
    \parbox[t][2cm][b]{\paperwidth-7.2cm}{
    \begin{center}
      \sanhao\bfseries\sffamily\szu@edate
    \end{center}}
  \end{center}}
\newcommand\szu@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
%%%%诚信声明，授权
%%%%封面中论文授权部分
\newcommand{\szu@authorization@mk}{%
  \ifszu@bachelor\vspace*{-0.6cm}\else\vspace*{-0.1cm}\fi % shit code!
  \begin{center}\erhao\hei\szu@authtitle\end{center}
  \ifszu@bachelor\vskip\baselineskip\else\vskip18pt\sihao[2.03]\fi\par
  \szu@authorization\par
  \textbf{\szu@authorizationaddon}\par
  \ifszu@bachelor\vskip1.0cm\else\vskip1.9cm\fi
  %%%%诚信声明签名
  \ifszu@bachelor
    \ifszu@bachelor\indent\else\noindent\fi
	\szu@authorsig\szu@underline\relax%
    %%%%\szu@teachersig\szu@underline\relax
	\szu@frontdate\szu@underline\relax
  \else
    \begingroup
      \parindent0pt\xiaosi
      \hspace*{1.5cm}\szu@authorsig\szu@underline[7em]\relax\hfill%
                     \szu@teachersig\szu@underline[7em]\relax\hspace*{1cm}\\[3pt]
      \hspace*{1.5cm}\szu@frontdate\szu@underline[7em]\relax\hfill%
                     \szu@frontdate\szu@underline[7em]\relax\hspace*{1cm}
    \endgroup
  \fi}
  
\newcommand{\makecover}{
  \phantomsection
  \pdfbookmark[-1]{\szu@ctitle}{ctitle}
  \normalsize%
  \begin{titlepage}
  %%%%论文封面第一页
    \szu@first@titlepage
	%%%%博士论文需要增加英文封面
    \ifszu@doctor
      \cleardoublepage\szu@doctor@engcover
    \fi
	%%%%授权说明
    \cleardoublepage\szu@authorization@mk
  \end{titlepage}
  %%%%中英文摘要
  \normalsize
  \szu@makeabstract
  \let\@tabular\szu@tabular}
 %%%%中文摘要部分的标题为摘要，用黑体三号字。
\newcommand{\szu@makeabstract}{%
  \cleardoublepage % always openright for Abstract
  \szu@chapter*[]{\cabstractname} % no tocline
  \ifszu@bachelor
    \pagestyle{szu@plain}
  \else
    \pagestyle{szu@headings}
  \fi
  \pagenumbering{Roman}
  %%%%摘要内容用小四号字书写，两端对齐，汉字用宋体，外文用Times New Roman,
  %%%%标点符号一律用中文输入状态下的标点符号。
  \szu@cabstract
  %%%%每个关键之间空两个汉字符宽度，且为悬挂缩进
  \vskip12bp
  \setbox0=\hbox{{\hei\szu@ckeywords@title}}
  \ifszu@bachelor\indent\else\noindent\hangindent\wd0\hangafter1\fi
    \box0\szu@ckeywords
  %%%%原清华大学样式：
  %%%%英文摘要部分的标题为Abstract，用Arial体三号字。
  %%%%研究生的英文摘要要求非常怪异：虽然正文前的封面部分为右开，但是英文摘要要跟中文摘要连续。
  \szu@chapter*[]{\eabstractname} % no tocline
  \szu@eabstract
  \vskip12bp
  \setbox0=\hbox{\textbf{Key words:\enskip}}
  \ifszu@bachelor\indent\else\noindent\hangindent\wd0\hangafter1\fi
    \box0\szu@ekeywords}
%%%%主要符号表
\newenvironment{denotation}[1][2.5cm]{
  \szu@chapter*[]{\szu@denotation@name} % no tocline
  \noindent\begin{list}{}%
    {\vskip-30bp\xiaosi[1.6]
     \renewcommand\makelabel[1]{##1\hfil}
     \setlength{\labelwidth}{#1} % 标签盒子宽度
     \setlength{\labelsep}{0.5cm} % 标签与列表文本距离
     \setlength{\itemindent}{0cm} % 标签缩进量
     \setlength{\leftmargin}{\labelwidth+\labelsep} % 左边界
     \setlength{\rightmargin}{0cm}
     \setlength{\parsep}{0cm} % 段落间距
     \setlength{\itemsep}{0cm} % 标签间距
    \setlength{\listparindent}{0cm} % 段落缩进量
    \setlength{\topsep}{0pt} % 标签与上文的间距
   }}{\end{list}}
%%%%定义致谢与声明环境
\newenvironment{ack}{%
  \ifszu@bachelor
    \szu@chapter*{\szu@ackname}
  \else
    % \cleardoublepage
    \szu@chapter*[\szu@acklongname]{\szu@ackname}[\szu@acklongname]
  \fi}
  {%
   \ifszu@bachelor\relax\else %TAG 1
     \par\vfill%
     \noindent
     {\setlength{\unitlength}{0.1\textwidth}
      \begin{picture}(10, 0.1)
        \multiput(0,0)(1, 0){10}{\rule{0.8\unitlength}{1.2pt}}
        \multiput(0,0.08)(1, 0){10}{\rule{0.8\unitlength}{1.2pt}}
      \end{picture}}
   \fi % END TAG 1
   %%%%声明部分
   \ifszu@bachelor
     \szu@chapter*{\szu@declarename}
   \else
     \parbox[t][4cm][c]{\textwidth}{{\sanhao\hei\centerline{\szu@declarename}}}
   \fi
   \par{\xiaosi\parindent2em\szu@declaretext}\vskip2cm
     {\xiaosi\hfill\szu@signature\szu@underline[2.5cm]\relax%
      \szu@backdate\szu@underline[2.5cm]\relax}%
  }
%%%%索引部分
\def\szu@starttoc#1{% #1: float type, prepend type name in \listof*** entry.
  \let\oldnumberline\numberline
  \def\numberline##1{\oldnumberline{\csname #1name\endcsname\hskip.4em ##1}}
  \@starttoc{\csname ext@#1\endcsname}
  \let\numberline\oldnumberline}
\def\szu@listof#1{% #1: float type
  \@ifstar
    {\szu@chapter*[]{\csname list#1name\endcsname}\szu@starttoc{#1}}
    {\szu@chapter*{\csname list#1name\endcsname}\szu@starttoc{#1}}}
\renewcommand\listoffigures{\szu@listof{figure}}
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{4em}}
\renewcommand\listoftables{\szu@listof{table}}
\let\l@table\l@figure
%%%%本命令只是为了生成公式列表，所以这个caption是假的。如果要编号最好用equation环境，......
\def\ext@equation{loe}
\def\equcaption#1{%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
%%%%latex默认没有公式索引，此处定义自己的\listtofequations
\newcommand\listofequations{\szu@listof{equation}}
\let\l@equation\l@figure
\bibpunct{[}{]}{,}{s}{}{,}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa%
  \unskip\kern\p@\textsuperscript{\NAT@@open #1\NAT@@close}%
  \if*#3*\else\ (#3)\fi\else #1\fi\endgroup}
%%%%参考文献
\DeclareRobustCommand\onlinecite{\@onlinecite}
\def\@onlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
\def\szudot{\ifszu@bachelor\else\unskip.\fi}
\def\szumasterbib{\ifszu@doctor [M]\else [Master Thesis]\fi}
\def\szuphdbib{\ifszu@doctor [D]\else [Doctor Thesis]\fi}
%%%%修改默认的thebibliography环境，增加一些调整代码。
\renewenvironment{thebibliography}[1]{%
   \szu@chapter*{\bibname}%
   \wuhao[1.5]
   \list{\@biblabel{\@arabic\c@enumiv}}%
        {\renewcommand{\makelabel}[1]{##1\hfill}
         \settowidth\labelwidth{1.1cm}
         \setlength{\labelsep}{0.4em}
         \setlength{\itemindent}{0pt}
         \setlength{\leftmargin}{\labelwidth+\labelsep}
         \addtolength{\itemsep}{-0.7em}
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy\frenchspacing
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \interlinepenalty4000%
    \sfcode`\.\@m}
   {\def\@noitemerr
     {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist\frenchspacing}
%%%%附录
\let\szu@appendix\appendix
\renewenvironment{appendix}{%
  \szu@appendix
  \gdef\@chapapp{\appendixname~\thechapter}
  %\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}
  }{}
%%%%个人简历
\newenvironment{resume}{%
  % \cleardoublepage
  \szu@chapter*{\szu@resume@title}}{}
%%%%\resumeitem 个人简历里面会出现的已发表文章，在投文章等
\newcommand{\resumeitem}[1]{\vspace{2.5em}{\sihao\hei\centerline{#1}}\par}
\newcommand{\shuji}[1][\szu@ctitle]{
  \newpage\thispagestyle{empty}\ziju{0.4em}\fs\xiaosan
  \hfill\rotatebox{-90}{\hb@xt@ \textheight{#1\hfill\szu@cauthor}}}
\iffalse
\newcommand{\bs}{\symbol{'134}}%Print backslash
\newcommand{\cih}[1]{%
  \index{commands!#1@\texttt{\bs#1}}%
  \index{#1@\texttt{\hspace*{-1.2ex}\bs #1}}}
\newcommand{\ci}[1]{\cih{#1}\texttt{\bs#1}}
\newcommand{\pai}[1]{%
  \index{packages!#1@\textsf{#1}}%
  \index{#1@\textsf{#1}}%
  \textsf{#1}}
\newcommand{\ei}[1]{%
  \index{environments!\texttt{#1}}%
  \index{#1@\texttt{#1}}%
  \texttt{#1}}
\newcommand{\wi}[1]{\index{#1}#1}
\fi
\newcommand*{\ziju}[1]{\renewcommand{\CJKglue}{\hskip #1}}
\newcommand{\pozhehao}{\kern0.3ex\rule[0.8ex]{2em}{0.1ex}\kern0.3ex}
%%%%在导言区支持中文
\def\szu@active@cjk{
  % Activate all >128 characters.
  \count@=128
  \@whilenum\count@<254 \do{%
    \advance\count@ by 1
    \lccode`\~=\count@
    \catcode\count@=\active
    \lowercase{\def~{\kern1ex}}}}
\AtEndOfClass{\ifxetex\else\szu@active@cjk\fi\input{szuthesis.cfg}}
\def\szu@fixselectfont{%
  \ifx\@EverySelectfont@EveryHook\@undefined\else% everysel package is loaded
    \DeclareRobustCommand{\selectfont}{%
       \ifx\f@linespread\baselinestretch \else
          \set@fontsize\baselinestretch\f@size\f@baselineskip \fi
       \xdef\font@name{%
          \csname\curr@fontshape/\f@size\endcsname}%
       \pickup@font
       \font@name
       % CJK addition:
       \CJK@bold@false
       \csname \curr@fontshape\endcsname
       % everysel addition:
       \@EverySelectfont@EveryHook
       \@EverySelectfont@AtNextHook
       \gdef\@EverySelectfont@AtNextHook{}%
       % end additions
       \size@update
       \enc@update}
  \fi}
%%%%设置一些pdf文档信息，依赖于hyperref宏包。
\def\szu@setup@pdfinfo{%
  \hypersetup{%
    pdftitle={\szu@ctitle},
    pdfauthor={\szu@cauthor},
    pdfsubject={\szu@cdegree},
    pdfkeywords={\szu@ckeywords},
    pdfcreator={\szu@cauthor},
    pdfproducer={\szuthesis}}}
%%%%把CJK环境放到合适的位置，以免导致其他宏包的命令位于CJK环境中而出现问题，同时自动开启CJK。
\ifxetex
  \AtBeginDocument{\CJKindent}
\else
  \def\szu@beginCJK{%
    \szu@fixselectfont%
    \begin{CJK*}{UTF8}{song}\CJKindent}
  \def\szu@endCJK{\clearpage\end{CJK*}}
  \let\szu@begindocumenthook\@begindocumenthook
  \let\szu@enddocumenthook\@enddocumenthook
  \def\AtBeginDocument{\g@addto@macro\szu@begindocumenthook}
  \def\AtEndDocument{\g@addto@macro\szu@enddocumenthook}
  \def\@begindocumenthook{\szu@begindocumenthook\szu@beginCJK}
  \def\@enddocumenthook{\szu@endCJK\szu@enddocumenthook}
\fi
\AtEndOfClass{\sloppy\szu@item@space}
\endinput
%%
%% End of file `szuthesis.cls'.

%%%% szuthesis based on thuthesis
