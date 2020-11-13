\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{itkmitlcoop}[2018/11/09]

\LoadClass[12pt, a4paper, oneside]{book}

% !TEX TS-program = xelatex
% !TEX encoding = UTF-8

\RequirePackage[top=1in, bottom=1in, left=1.5in, right=1in]{geometry}
\RequirePackage{fontspec}
\RequirePackage{xunicode}
\RequirePackage{xltxtra}
\RequirePackage{titlesec}
\RequirePackage{eucal}
\RequirePackage{eufrak}
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}
\RequirePackage{titletoc}
\RequirePackage{ifthen}
\RequirePackage{lineno}
\RequirePackage{afterpage}
\RequirePackage{subfigure}
\RequirePackage{etoolbox}

% ##### new command for Roman number
\newcommand{\rNum}[1]{\lowercase\expandafter{\romannumeral #1\relax}}

\XeTeXlinebreaklocale "th_TH" %สำหรับตัดคำ
\XeTeXlinebreakskip = 0pt plus 1pt
\setmainfont[Scale=1.3]{Angsana New}
\linespread{1.3}

% ##### Set Chapter and Section Style
\titleformat{\chapter}[display]
{\normalfont\Large\bfseries\centering}
{\chaptertitlename\ \thechapter}{0pt}{\LARGE}
\titlespacing*{\chapter}{0pt}{-2\baselineskip}{2em}

\titleformat{\section}
{\normalfont\large\bfseries}{\thesection}{0.5em}{}

\titleformat{\subsection}
{\normalfont\bfseries}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{1em}{0.25em}

% ##### Re-define word
\renewcommand{\bibname}{บรรณานุกรม}
\renewcommand{\contentsname}{สารบัญ}
\renewcommand{\chaptername}{บทที่}
\renewcommand{\figurename}{รูปที่}
\renewcommand{\tablename}{ตารางที่}
\renewcommand{\listfigurename}{สารบัญภาพ}
\renewcommand{\listtablename}{สารบัญตาราง}

% ##### Set a pagination style to be on top right of page
\pagestyle{fancy}
\fancyhf{} 
\renewcommand{\headrulewidth}{0pt}


% ##### Override the plain style to make the first chapter page same with other pages
\fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \lhead{}\rhead{}\chead{}
    \lfoot{}\cfoot{}\rfoot{}
}

% ##### Override subfigure to use Thai alpha instead of English
\def\thaialph#1{\expandafter\thalph\csname c@#1\endcsname}
\def\thalph#1{%
    \ifcase#1\or ก\or ข\or ค\or ง\or จ\or ฉ\or ช\or ซ\or
    ฌ\or ญ\or ฎ\or ฏ\or ฐ\or ฑ\or ฒ\or ณ\or ด\or ต\or ถ\or ท\or ธ\or น\or
    บ\or ป\or ผ\or ฝ\or พ\or ฟ\or ภ\or ม\or ย\or ร\or ฤ\or ล\or ฦ\or ว\or
    ศ\or ษ\or ส\or ห\or ฬ\or อ\else ฮ\else\xpg@ill@value{#1}{thalph}\fi}
\renewcommand\thesubfigure{(\thaialph{subfigure})}

% ##### TOC Overrided 
% อ้างอิงจาก http://kt-linux.blogspot.com/2011/01/latex.html
%ตั้งค่าความลึกของหน้าสารบัญใหม่เป็น 1 (คือลงลึกแค่ชั้นเดียว) และตั้งค่าคำสั่ง \tableofcontents ใหม่
\setcounter{tocdepth}{1}
\renewcommand\tableofcontents{
    \begin{center}
        {\LARGE \textbf{สารบัญ} }
    \end{center} \vskip2em
    \begin{flushright}
        \textbf{หน้า}
    \end{flushright}
    % Hold current page value
    % for TOC heading
    \newcounter{tocitem}
    \setcounter{tocitem}{0}
    \modulolinenumbers[50]
    \linenumbers[1]
    \@starttoc{toc}
    \setcounter{tocitem}{0}
    \clearpage
    \cleardoublepage
}

%สร้างคำสั่งใหม่สำหรับตรวจสอบว่าบรรทัดปัจจุบัน หรือ จำนวนหัวข้อที่แสดงในสารบัญเกินค่าทึ่กำหนดหรือยัง หากเกินแล้วให้ตัดขึ้นหน้าใหม่ รีเซตตัวนับ tocitem รีเซตตัวนับบรรทัดใหม่ และเขียนหัวของหน้าสารบัญใหม่ (เช่น สารบัญ (ต่อ) ในกรณีนี้)
\newcommand{\tocheadcont}[3]{
    \ifthenelse{#1>31 \OR #2>31}{
        %Should be a newpage here.
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{tocitem}{0}
        \begin{center}
            {\LARGE \textbf{#3 (ต่อ)} }
        \end{center}  \vskip2em
        \begin{flushright}
            \textbf{หน้า}
        \end{flushright}
    }{}
}

% tocitem format for chapter
\titlecontents{chapter}[0mm]
{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{\contentsname}}
{\chaptername\hspace{1ex}\thecontentslabel\hspace{2mm}}
{}{\hfill \contentspage}

% tocitem format for section
\titlecontents{section}[0mm]
{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{\contentsname}}
{\hspace{6ex}\thecontentslabel\hspace{2mm}}{\hspace{6ex}\thecontentslabel\hspace{2mm}}
{\hfill \contentspage}

% ##### LOT Overrided 
\newcommand{\lotheadcont}[3]{
    \ifthenelse{#1>29 \OR #2>29}{
        %Should be a newpage here.
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{lotitem}{1}
        \begin{center}
            {\LARGE \textbf{#3 (ต่อ)} }
        \end{center}  \vskip2em
        \begin{flushright}
            \textbf{หน้า}
        \end{flushright}
    }{}
}

\renewcommand\listoftables{%
    \begin{center}
        {\LARGE \textbf{\listtablename} }
    \end{center} \vskip2em
    \begin{flushright}
        \textbf{หน้า}
    \end{flushright}
    \resetlinenumber[1]
    \newcounter{lotitem}
    \@starttoc{lot}%
    \clearpage
    \cleardoublepage
}

\titlecontents{table}[0mm]{\stepcounter{lotitem}\lotheadcont{\thelinenumber}{\thelotitem}{\listftablename}}{\contentspush{\tablename\hspace{1ex}\thecontentslabel\hspace{2mm}}}{}{\hfill \contentspage}

% ##### LOF Overrided 
\newcommand{\lofheadcont}[3]{
    \ifthenelse{#1>29 \OR #2>29}{
        %Should be a newpage here.
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{lofitem}{1}
        \begin{center}
            {\LARGE \textbf{#3 (ต่อ)} }
        \end{center}  \vskip2em
        \begin{flushright}
            \textbf{หน้า}
        \end{flushright}
    }{}
}

\renewcommand\listoffigures{%
    \begin{center}
        {\LARGE \textbf{\listfigurename} }
    \end{center} \vskip2em
    \begin{flushright}
        \textbf{หน้า}
    \end{flushright}
    \resetlinenumber[1]
    \newcounter{lofitem}
    \@starttoc{lof}
    \pagewiselinenumbers
    \clearpage
    \cleardoublepage
}

% Indent the next line of the entry by the width of the label with \contentspush
\titlecontents{figure}[0mm]{\stepcounter{lofitem}\lofheadcont{\thelinenumber}{\thelofitem}{\listfigurename}}{\contentspush{\figurename\hspace{1ex}\thecontentslabel\hspace{2mm}}}{}{\hfill\contentspage}

%  Newcommand each required page
\newcommand{\makecover}{
    % ปกนอก
    \thispagestyle{empty}
    
    \begin{center}
        \Large{\textbf{รายงานการปฏิบัติงานสหกิจศึกษา}} \\
        \LARGE{\textbf{เรื่อง}} \\
        \LARGE{\textbf{\ThesisTiTle}} \\
        \LARGE{\textbf{\ThesisTiTleENG}} \vskip3cm
        \Large{\textbf{ปฎิบัติงาน ณ \Company}} \vskip1cm
        \Large{\textbf{โดย}} \vskip1cm
        \Large{\textbf{\AuName}}  \\
        \Large{\textbf{รหัสประจำตัว \SId}} \null \vfill
        \large{\textbf{รายงานนี้เป็นส่วนหนึ่งของการศึกษารายวิชา สหกิจศึกษา \\
                สาขาวิชาเทคโนโลยีสารสนเทศ คณะเทคโนโลยีสารสนเทศ \\
                ภาคเรียนที่~\Sem \  ปีการศึกษา~\AcaY\\ 
                สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง }}
    \end{center}
}

\newcommand{\makeinnercover}{
    % ปกใน
    \newpage
    \thispagestyle{empty}
    \begin{center}
        \Large{\textbf{รายงานการปฏิบัติงานสหกิจศึกษา}} \\
        \LARGE{\textbf{\ThesisTiTle}} \\
        \LARGE{\textbf{\ThesisTiTleENG}} \vskip4cm
        \Large{\textbf{ปฎิบัติงาน ณ \Company}} \vskip1cm
        \Large{\textbf{โดย}} \vskip1cm
        \Large{\textbf{\AuName}}  \\
        \Large{\textbf{รหัสประจำตัว \SId}} \null \vfill
        \large{\textbf{ปฏิบัติงาน ณ \Company \\
                \Address \\ 
                Web site : \Website}}
    \end{center}
}

\newcommand{\makeengcover}{
    % ปกอังกฤษ
    \newpage
    \thispagestyle{empty}
    \begin{center}
        \LARGE{\textbf{\ThesisTiTleENG}} \vskip7cm
        \Large{\textbf{\AuNameENG}}  \null \vfill
        \large{\textbf{A REPORT SUBMITTED IN PARTIAL FULFILLMENT OF \\
                THE REQUIREMENT FOR COOPERATIVE EDUCATION PROGRAM \\
                THE DEGREE OF BACHELOR OF SCIENCE PROGRAM IN \\
                INFORMATION TECHNOLOGY \\
                FACULTY OF INFORMATION TECNOLOGY \\
                KING MONGKUT’S INSTITUTE OF TECHNOLOGY LADKRABANG \\
                \Sem / \AcaYAD}}
    \end{center}
}

\newcommand{\makecopyrightcover}{
    \newpage
    \thispagestyle{empty}
    \null\vfill
    \begin{large}
        \noindent\textbf{COPYRIGHT \AcaYAD \\
            FACULTY OF INFORMATION TECHNOLOGY \\
            KING MONGKUT’S INSTITUTE OF ECHNOLOGY LADKRABANG}
    \end{large}
}

\newcommand{\makeletter}{
    %-- หนังสือส่งรายงานการปฏิบัติงานสหกิจศึกษา -------------------------------------------
    \newpage
    \thispagestyle{empty}
    \begin{flushright}
        วันที่ \SubD
    \end{flushright}
    
    \noindent เรื่อง ขอส่งรายงานการปฏิบัติงานสหกิจศึกษา \\
    เรียน \Advisor \vskip0.1cm
    
    \hskip0.2cm ที่ปรึกษาสหกิจศึกษาในสาขาเทคโนโลยีสารสนเทศ \vskip1cm
    
    ตามที่ข้าพเจ้า \AuName \ นักศึกษาสาขาวิชาเทคโนโลยีสารสนเทศ คณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง ได้ปฏิบัติงานสหกิจศึกษาระหว่างวันที่ \StartDWork \ ถึงวันที่ \EndDWork \ ในตำแหน่ง \Position \ ณ สถานประกอบการชื่อ \Company \ และได้รับมอบหมายจากพนักงานที่ปรึกษาให้ศึกษาและจัดทำรายงาน เรื่อง \ThesisTiTle
    
    บัดนี้ การปฏิบัติงานสหกิจศึกษาได้สิ้นสุดลงแล้ว จึงใคร่ขอส่งรายงานการปฏิบัติงาน สหกิจศึกษาดังกล่าวมาพร้อมนี้ จำนวน 1 เล่ม เพื่อขอรับคำปรึกษาต่อไป \vskip1cm
    
    จึงเรียนมาเพื่อโปรดพิจารณา 
    
    \vskip1.5cm
    \begin{flushright}    
        \begin{tabular}{c}
            ขอแสดงความนับถือ \\ \\
            .............................................................. \\
            (\AuName ) 
        \end{tabular}
    \end{flushright}
}

\newcommand{\makeack}[1]{
    %-- ACKNOWLEDGEMENTS Page -------------------------------------------
    \newpage
    \begin{center}
        {\LARGE \textbf{กิตติกรรมประกาศ} }
    \end{center} \vskip2em
    \addcontentsline{toc}{chapter}{กิตติกรรมประกาศ}
    
    ตามที่ข้าพเจ้า \AuName \ ได้มาปฏิบัติงานสหกิจศึกษา ณ \Company \ ตั้งแต่วันที่ \StartDWork \ ถึงวันที่ \EndDWork \ ทำให้ข้าพเจ้าได้รับความรู้และประสบการณ์ต่าง ๆ ที่มีคุณค่ามากมาย สำหรับรายงานสหกิจศึกษาฉบับนี้สำเร็จลงได้ด้วยดี จากความช่วยเหลือและความร่วมมือสนับสนุนของหลายฝ่าย ดังนี้ 
    
    #1
    
    นอกจากนี้ยังมีบุคคลท่านอื่น ๆ อีกที่ไม่ได้กล่าวไว้ ณ ที่นี้ ซึ่งให้ความกรุณาแนะนำในจัดทำรายงานสหกิจศึกษาฉบับนี้ ข้าพเจ้าจึงใคร่ขอขอบพระคุณทุกท่านที่ได้มีส่วนร่วมในการให้ข้อมูลและให้ความเข้าใจเกี่ยวกับชีวิตของการปฏิบัติงาน รวมถึงเป็นที่ปรึกษาในการจัดทำรายงานฉบับนี้จนเสร็จสมบูรณ์ 
    
    \vskip1.5cm
    \begin{flushright}    
        \begin{tabular}{c}
            \AuName \\
            ผู้จัดทำรายงาน \\
            วันที่ \SubD
        \end{tabular}
    \end{flushright}
}

\newcommand{\makeapproveletter}{
    %-X- หน้าอนุมัติรายงาน -X------------------------------------------
    % Do NOT EDIT this page
    \newpage
    \thispagestyle{empty}
    \begin{table}[h]
        \begin{tabularx}{\linewidth}{lX}
            \textbf{ชื่อรายงานการปฏิบัติงานสหกิจศึกษา} & เว็บแอพพลิเคชั่นประเมินความสามารถเบื้องต้นของ \\
            \textbf {} & ผู้สมัครงาน \\
            \textbf{ผู้รายงาน} & \AuName \\
            \textbf{คณะ} & เทคโนโลยีสารสนเทศ \\
            \textbf{สาขาวิชา} & เทคโนโลยีสารสนเทศ
        \end{tabularx}
    \end{table} \vskip3cm
    
    
    \begin{center}
        ...................................................................... \\
        (\Advisor ) \\
        อาจารย์ที่ปรึกษาสหกิจศึกษา \vskip2.5cm
        
        ...................................................................... \\
        (\Exami) \\
        พนักงานที่ปรึกษา \null \vfill
        
        คณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง	\\
        อนุมัติให้นับรายงานการปฏิบัติงานสหกิจศึกษาฉบับนี้ เป็นส่วนหนึ่งของการศึกษา \\
        ตามหลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชาเทคโนโลยีสารสนเทศ
        
    \end{center}
}

\newcommand{\makeabstract}[1]{
    %-- Abstract Page ------------------------------------------
    \setcounter{page}{1}
    \newpage
    \addcontentsline{toc}{chapter}{บทคัดย่อ}
    
    \begin{table}[h]
        \begin{tabularx}{\linewidth}{lX}
            \textbf{ชื่อรายงาน} & \ThesisTiTle \\
            \textbf{ชื่อนักศึกษา} & \AuName \\
            \textbf{รหัสนักศึกษา} & \SId \\
            \textbf{สาขาวิชา} & เทคโนโลยีสารสนเทศ \\
            \textbf{อาจารย์ที่ปรึกษา} & \Advisor \\
            \textbf{ปีการศึกษา} & \AcaY
        \end{tabularx}
    \end{table}
    
    \vskip1cm
    \begin{center}
        \textbf{\large บทคัดย่อ}
    \end{center}
    
    รายงานการปฏิบัติงานสหกิจศึกษาฉบับนี้ กล่าวถึงวัตถุประสงค์ของการปฏิบัติงาน และรายละเอียดของการปฏิบัติงาน ซึ่งประกอบด้วย ที่มา, ความสำคัญ, รายละเอียด, การออกแบบ ของกระบวนการทำงานของเว็ปแอพพลิเคชั่นประเมินความสามารถเบื้องต้นของผู้สมัครงาน โดยทางบริษัท ไซเจ็น ได้มอบหมายในช่วงเวลาที่ปฏิบัติงานสหกิจศึกษา สร้างเว็ปแอพพลิเคชั่นประเมินความสามารถเบื้องต้นของผู้สมัครงาน เป็นเว็บแอพพลิเคชั่นที่
    สามารถให้พนักงานมาออกแบบข้อสอบเพื่อทดสอบความสามารถของผู้ที่มาสมัครงาน โดยการออกข้อสอบนั้นสามารถออกแบบคำถามได้หลายรูปแบบ เช่น คำถามอัตนัย, ปรนัย หรือ ถามโดยการแนบไฟล์ต่างๆให้ทำเพื่อวัดความสามารถของผู้สมัครงาน ซึ่งทางบริษัทนั้นมีระบบดังกล่าวมาก่อนหน้านี้แล้ว แต่การส่งข้อสอบในแต่ละครั้งทางบริษัทต้องออกข้อสอบใหม่ทุกครั้ง เพื่อป้องกันข้อสอบที่อาจถูกเผยแพร่ ทำให้พนักงานในบริษัทต้องสละเวลามาออกข้อสอบทุกครั้งที่มีการสมัครงานเพื่อให้ข้อสอบมีมาตรฐานสม่ำเสมอ ทางบริษัทจึงมีการมอบหมายให้นักศึกษาสร้างเว็ปแอพพลิเคชั่นประเมินความสามารถเบื้องต้นของผู้สมัครงานใหม่ โดยที่เว็บแอพพลิเคชั่นนี้สามารถกำหนดความยากของข้อสอบ เพื่อทำการสุ่มคำถามจากคลังข้อสอบที่สร้างไว้ ทำให้การทดสอบแต่ละครั้งผู้ทดสอบจะได้ข้อสอบที่แตกต่างกันออกไป อ้างอิงโดยระดับความยากที่ผู้ออกข้อสอบทำการทำหนดไว้ มีการกำหนดเวลาในการทำข้อสอบ เพื่อวัดความสามารถของผู้สมัครงาน ให้ทำข้อสอบภายในเวลาที่กำหนด และมีการกำหนดวันสิ้นสุดของการทำข้อสอบ เพื่อให้ผู้สมัครงานทำข้อสอบในเวลาที่กำหนด โดยเว็บแอพพลิเคชั่นนี้จะทำการส่งข้อสอบทางอีเมลให้ผู้สมัครงานตามที่ผู้ออกข้อสอบกำหนด เมื่อผู้สมัครงานทำข้อสอบแล้วทางบริษัทจะได้รับผลคะแนนที่เป็นปรนัย ส่วนคำถามที่เป็นอัตนัย และคำถามที่มีไฟล์แนบนั้นผู้ที่ส่งข้อสอบให้ทำต้องเป็นผู้ทำการตรวจต้วยตนเอง แล้วระบบจะทำการสรุปคะแนนทั้งหมดให้โดยอัติโนมัติ เว็ปแอพพลิเคชั่นนี้จะทำให้ทางบริษัท ไซเจ็น ลดระยะเวลาในการคัดกรองผู้ที่มาสมัครงาน และได้รับผู้สมัครงานที่มีคุณภาพตรงตามความต้องการของบริษัท


}

\newcommand{\makeabstracteng}[1]{
    %-- Abstract Page ------------------------------------------
    \newpage
    \addcontentsline{toc}{chapter}{บทคัดย่อ ภาษาอังกฤษ}
    
    \begin{table}[h]
        \begin{tabularx}{\linewidth}{lX}
            \textbf{Project Title} & \ThesisTiTleENG \\
            \textbf{Name} & \AuNameENG \\
            \textbf{Student ID} & \SId \\
            \textbf{Department} & \DepartmentENG \\
            \textbf{Advisor} & \AdvisorENG \\
            \textbf{Year} & \AcaY
        \end{tabularx}
    \end{table}    
    
    \vskip1cm
    \begin{center}
        \textbf{\large Abstract}
    \end{center}
    
    #1
}

\newcommand\startappendix{
    \appendix
    \renewcommand*{\appendixname}{ภาคผนวก}
    \renewcommand{\thechapter}{\thaialph{chapter}}
    
    \titlecontents{chapter}[0mm]
    {\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{สารบัญ}}
    {ภาคผนวก\hspace{1ex}\thecontentslabel\hspace{2mm}}
    {}{\hfill \contentspage}
}