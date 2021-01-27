\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oist}
\LoadClass[12pt,twoside]{report}

\RequirePackage[a4paper, headheight=0.6cm, inner=3cm ,outer=2.5cm, top=2cm, bottom=2cm]{geometry}  % Changing size of document
\RequirePackage{silence}
\WarningFilter{auxhook}{Cannot patch}
\RequirePackage[table]{xcolor}
\RequirePackage[bf]{caption} % caption: FIG in bold
\RequirePackage[T1]{fontenc}
\RequirePackage{subfiles}
\providecommand{\main}{.}
\RequirePackage[english]{babel} % The document is in English
\RequirePackage[utf8]{inputenc} % UTF8 encoding
\RequirePackage[T1]{fontenc} % Font 

\RequirePackage{graphicx}
\graphicspath{{\main/images/}}

\RequirePackage{eso-pic} % For the background picture on the title page
\RequirePackage{amsthm,amsmath,amssymb,amsfonts,bbm}
\RequirePackage{fancyhdr} % For the headers
\RequirePackage{hyperref} % Adds clickable links at references
\RequirePackage{float}
\RequirePackage{parskip}
\RequirePackage{booktabs}
\RequirePackage{xstring}
\RequirePackage{stringstrings}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{csquotes}
%\RequirePackage{subfigure}
\RequirePackage{subcaption}
\RequirePackage{bm}
\RequirePackage[backend=biber]{biblatex}
\addbibresource{chapters/bibtex.bib}
\RequirePackage{verbatim}

\newcounter{mytaskscounter}
\newcounter{mybrieftaskscounter}
\newcounter{mycelllinescounter}
\newcounter{mybalancingmodescounter}

\def\savetask#1{%
\stepcounter{mytaskscounter}%
\expandafter\def\csname mytaskslist\themytaskscounter\endcsname{#1}}

\def\savebrieftask#1{%
\stepcounter{mybrieftaskscounter}%
\expandafter\def\csname mybrieftaskslist\themybrieftaskscounter\endcsname{#1}}

\def\savecellline#1{%
\stepcounter{mycelllinescounter}%
\expandafter\def\csname mycelllineslist\themycelllinescounter\endcsname{#1}}

\def\savebalancingmodes#1{%
\stepcounter{mybalancingmodescounter}%
\expandafter\def\csname mybalancingmodeslist\themybalancingmodescounter\endcsname{#1}}

\forcsvlist{\savetask}{%
   Active enhancers vs active promoters,
   Active promoters vs inactive promoters,
   Active enhancers vs inactive enhancers,
   Inactive enhancers vs inactive promoters,
   Active enhancers and promoters vs anything else,
}%

\forcsvlist{\savebrieftask}{%
   AE vs AP,
   AP vs IP,
   AE vs IE,
   IE vs IP,
   AE \& AP vs else,
}%

\forcsvlist{\savecellline}{%
   GM12878,
   HelaS3,
   HepG2,
   K562,
}%

\forcsvlist{\savebalancingmodes}{%
   unbalanced,
   balanced,
   full balanced,
}%

\def\getnthtask#1{\csname mytaskslist#1\endcsname}
\def\getnthbrieftask#1{\csname mybrieftaskslist#1\endcsname}
\def\getnthcellline#1{\csname mycelllineslist#1\endcsname}
\def\getnthbalancingmode#1{\csname mybalancingmodeslist#1\endcsname}

\NewDocumentCommand{\decompositions}{mmm}{
    %
    % #1 -> cell line number
    % #2 -> balancing mode number
    % #3 -> task number
    %
    \def\cellline{\getnthcellline{#1}}
    \def\task{\getnthtask{#2}}
    \def\brieftask{\getnthbrieftask{#2}}
    \def\balancingmode{\getnthbalancingmode{#3}}
    \StrSubstitute{\task}{ }{_}[\pathtask]%
    \StrSubstitute{\balancingmode}{ }{_}[\balancingmodepath]%
    
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{decompositions/\cellline/\cellline-\balancingmodepath-\pathtask.png}
        \caption{Task \brieftask{}, cell line \cellline{} and \balancingmode{} mode - Two figures on the left: MCA decomposition for the sequence data (train and test sets); two figures on the right: \(t\)-SNE decomposition for the epigenomic data (train and test sets).}
        \label{fig:decompositions-#1-#2-#3}
    \end{figure}
}

\NewDocumentCommand{\tsne}{m}{
    %
    % #1 -> cell line number
    %
    \def\cellline{\getnthcellline{#1}}
    
    \begin{figure}[H]
        \centering
        \includegraphics[width=0.9\textwidth]{decompositions/\cellline/big-tsne.png}
        \caption{TSNE for \cellline{} epigenomic data}
        \label{fig:big-tsne-#1}
    \end{figure}
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{decompositions/\cellline/tsne.png}
        \caption{Per class TSNE for \cellline{} epigenomic data}
        \label{fig:tsne-#1}
    \end{figure}
}

\NewDocumentCommand{\mca}{m}{
    %
    % #1 -> cell line number
    %
    \def\cellline{\getnthcellline{#1}}
        
    \begin{figure}[H]
        \centering
        \includegraphics[width=0.9\textwidth]{decompositions/\cellline/big-mca.png}
        \caption{MCA for \cellline{} epigenomic data}
        \label{fig:big-mca-#1}
    \end{figure}
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{decompositions/\cellline/mca.png}
        \caption{Per class MCA for \cellline{} sequence data}
        \label{fig:mca-#1}
    \end{figure}
}

\NewDocumentCommand{\history}{mmmm}{
    %
    % #1 -> cell line number
    % #2 -> balancing mode number
    % #3 -> task number
    % #4 -> kind
    %
    \def\cellline{\getnthcellline{#1}}
    \def\task{\getnthtask{#2}}
    \def\brieftask{\getnthbrieftask{#2}}
    \def\balancingmode{\getnthbalancingmode{#3}}
    \StrSubstitute{\task}{ }{_}[\pathtask]%
    \StrSubstitute{#4}{ }{_}[\kind]%
    \StrSubstitute{\balancingmode}{ }{_}[\balancingmodepath]%
    
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{cnn/\kind/\cellline/\cellline-\balancingmodepath-\pathtask.png}
        \caption{Average history of #4 for \brieftask, \cellline, \balancingmode}
        \label{fig:\kind-#1-#2-#3}
    \end{figure}
}

\NewDocumentCommand{\bestmodel}{mmm}{
    %
    % #1 -> cell line number
    % #2 -> balancing mode number
    % #3 -> task number
    %
    \history{#1}{#2}{#3}{best models}
}

\NewDocumentCommand{\gaussianprocess}{mmm}{
    %
    % #1 -> cell line number
    % #2 -> balancing mode number
    % #3 -> task number
    %
    \history{#1}{#2}{#3}{gaussian process}
}

\NewDocumentCommand{\wilcoxon}{mm}{
    %
    % #1 -> Table path
    % #2 -> Caption
    %
    \begin{table}[H]
        \centering
        {\small \input{chapters/tables/wilcoxon/#1.tex}}
        \caption{Wilcoxon signed rank test win-tie-loss at 0.01 significance level to compare #2.}
        \label{tab:wilcoxon-#1}
    \end{table}
}

\NewDocumentCommand{\pearson}{mm}{
    %
    % #1 -> Table path
    % #2 -> Caption
    %
    \begin{table}[H]
        \centering
        \input{chapters/tables/pearson/pearson-#1.tex}
        \caption{Pearson coefficient table for AUPRC, AUROC, total required time and dataset cardinality for #2 in the unbalanced mode.}
        \label{tab:pearson-#1}
    \end{table}
}

\NewDocumentCommand{\histogram}{mmm}{
    %
    % #1 -> Image path
    % #2 -> Caption
    % #3 -> label
    %
    \StrSubstitute{#1}{ }{_}[\path]%
    \StrSubstitute{#2}{cnn}{CNN}[\cnncaption]%
    \StrSubstitute{\cnncaption}{mlp}{MLP}[\mlpcaption]%
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{histograms/\path.png}
        \caption{\mlpcaption}
        \label{fig:#3}
    \end{figure}
    \begin{table}[H]
        \centering
        {\small \input{chapters/tables/\path.tex}}
        \caption{\mlpcaption}
        \label{tab:#3}
    \end{table}
}

\NewDocumentCommand{\comparisonhistogram}{mmmmG{}}{
    %
    % #1 -> Metric
    % #2 -> Models
    % #3 -> Caption
    % #4 -> Label
    % #5 -> Grouping, optional
    %
    \histogram{#1, comparison between #2 models#5}{#3}{#4}
}

\NewDocumentCommand{\groupedcomparisonhistogram}{mmmmm}{
    %
    % #1 -> Metric
    % #2 -> Group
    % #3 -> Models
    % #4 -> Caption
    % #5 -> Label
    %
    \comparisonhistogram{#1}{#3}{#4}{#5}{, grouped by #2}
}


\NewDocumentCommand{\modecomparisonhistogram}{mmmmm}{
    %
    % #1 -> Metric
    % #2 -> Mode
    % #3 -> Models
    % #4 -> Caption
    % #5 -> Label
    %
    \comparisonhistogram{#1 for \getnthbalancingmode{#2} mode}{#3}{#4}{#5}
}

\makeatletter
\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{}{}{}
%\patchcmd{\@makeschapterhead}{\vspace*{100\p@}}{}{}{}
\makeatother

\newcommand{\funcdef}[3]{#1:#2\longrightarrow #3}
\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}
\newcommand{\rnd}[1]{\left(#1\right)}
\newcommand{\sqr}[1]{\left[#1\right]}
\newcommand{\ssqr}[1]{\llbracket#1\rrbracket}
\newcommand{\crl}[1]{\left\{#1\right\}}
