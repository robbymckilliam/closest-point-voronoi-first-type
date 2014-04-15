prologues := 2;
filenametemplate "%j-%c.mps";
verbatimtex
%&latex
\documentclass{minimal}
\begin{document}
etex

%input metagraph;

pair v[];
  v1 = (0,0);
  v2 = (0,6cm);
  v3 = (6cm,6cm);
  v4 = (6cm,0);

%A3 figure
  beginfig(1);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  dotlabel.llft(btex $v_1$ etex, v1);
  dotlabel.ulft(btex $v_2$ etex, v2);
  dotlabel.urt(btex $v_3$ etex, v3);
  dotlabel.lrt(btex $v_4$ etex, v4);

  draw v1--v2; label.rt(btex $1$ etex, 1/2[v1,v2]);
  draw v2--v3; label.bot(btex $1$ etex, 1/2[v2,v3]);
  draw v3--v4; label.lft(btex $1$ etex, 1/2[v3,v4]);
  draw v4--v1; label.top(btex $1$ etex, 1/2[v4,v1]);
  
  endfig;

  %A3* figure
  beginfig(2);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  dotlabel.llft(btex $v_1$ etex, v1);
  dotlabel.ulft(btex $v_2$ etex, v2);
  dotlabel.urt(btex $v_3$ etex, v3);
  dotlabel.lrt(btex $v_4$ etex, v4);

  draw v1--v2; label.rt(btex $\frac{1}{4}$ etex, 1/2[v1,v2]);
    draw v2--v3; label.bot(btex $\frac{1}{4}$ etex, 1/2[v2,v3]);
    draw v1--v3; label.ulft(btex $\frac{1}{4}$ etex, 1/2[v1,v3]);
  draw v3--v4; label.lft(btex $\frac{1}{4}$ etex, 1/2[v3,v4]);
  draw v4--v1; label.top(btex $\frac{1}{4}$ etex, 1/2[v4,v1]);

    draw v4..(-0.8cm,-0.8cm)..v2; label(btex $\frac{1}{4}$ etex, (1.8cm,-1.3cm));
    
  endfig;

  beginfig(3);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  dotlabel.llft(btex $v_1$ etex, v1);
  dotlabel.ulft(btex $v_2$ etex, v2);
  dotlabel.urt(btex $v_3$ etex, v3);
  dotlabel.lrt(btex $v_4$ etex, v4);

  draw v1--v2; label.lft(btex $w_{12} = 4$ etex, 1/2[v1,v2]);
    draw v1--v4; label.top(btex $w_{14} = 1$ etex, 1/2[v1,v4]);
    draw v2--v4; label.urt(btex $w_{24} = 1$ etex, 1/2[v2,v4]);
  draw v3--v4; label.rt(btex $w_{34} = 4$ etex, 1/2[v3,v4]);
  %draw v4--v1; label.bot(btex $\frac{1}{4}$ etex, 1/2[v4,v1]);

    %draw v4..(-0.8cm,-0.8cm)..v2; label.llft(btex $\frac{1}{4}$ etex, (-1cm,-1cm));
    
  endfig;

  
  beginfig(4);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  dotlabel.llft(btex $v_1$ etex, v1);
  dotlabel.ulft(btex $v_2$ etex, v2);
  dotlabel.urt(btex $v_3$ etex, v3);
  dotlabel.lrt(btex $v_4$ etex, v4);

  draw v1--v2; label.lft(btex $4$ etex, 1/2[v1,v2]);
    draw v1--v4; label.top(btex $1$ etex, 1/2[v1,v4]);
    draw v2--v4; label.urt(btex $1$ etex, 1/2[v2,v4]);
  draw v3--v4; label.rt(btex $4$ etex, 1/2[v3,v4]);
  %draw v4--v1; label.bot(btex $\frac{1}{4}$ etex, 1/2[v4,v1]);

    %draw v4..(-0.8cm,-0.8cm)..v2; label.llft(btex $\frac{1}{4}$ etex, (-1cm,-1cm));
    
 endfig;

  beginfig(5);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  draw v1--v2; label.lft(btex $4$ etex, 1/2[v1,v2]);
    draw v1--v4; label.top(btex $1$ etex, 1/2[v1,v4]);
    draw v2--v4; label.urt(btex $1$ etex, 1/2[v2,v4]);
  draw v3--v4; label.rt(btex $4$ etex, 1/2[v3,v4]);
  %draw v4--v1; label.bot(btex $\frac{1}{4}$ etex, 1/2[v4,v1]);

  dotlabel.llft(btex $v_1$ etex, v1) withcolor (0.6,0,0);
  dotlabel.ulft(btex $v_2$ etex, v2) withcolor (0,0.6,0);
  dotlabel.urt(btex $v_3$ etex, v3) withcolor (0.6,0,0);
  dotlabel.lrt(btex $v_4$ etex, v4) withcolor (0.6,0,0);

    %draw v4..(-0.8cm,-0.8cm)..v2; label.llft(btex $\frac{1}{4}$ etex, (-1cm,-1cm));
    
 endfig;

  beginfig(6);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  draw v1--v2; label.lft(btex $4$ etex, 1/2[v1,v2]);
    draw v1--v4 withcolor(0.7,0.7,0.7); label.top(btex $1$ etex, 1/2[v1,v4]) withcolor(0.7,0.7,0.7);
    draw v2--v4; label.urt(btex $1$ etex, 1/2[v2,v4]) dashed evenly;
  draw v3--v4 withcolor(0.7,0.7,0.7); label.rt(btex $4$ etex, 1/2[v3,v4]) withcolor(0.7,0.7,0.7);
  %draw v4--v1; label.bot(btex $\frac{1}{4}$ etex, 1/2[v4,v1]);

  dotlabel.llft(btex $v_1$ etex, v1) withcolor (0.6,0,0);
  dotlabel.ulft(btex $v_2$ etex, v2) withcolor (0,0.6,0);
  dotlabel.urt(btex $v_3$ etex, v3) withcolor (0.6,0,0);
  dotlabel.lrt(btex $v_4$ etex, v4) withcolor (0.6,0,0);

    %draw v4..(-0.8cm,-0.8cm)..v2; label.llft(btex $\frac{1}{4}$ etex, (-1cm,-1cm));
    
 endfig;


 beginfig(7);

  draw v1--v2; label.lft(btex $4$ etex, 1/2[v1,v2]);
    draw v1--v4; label.top(btex $1$ etex, 1/2[v1,v4]);
    draw v2--v4; label.urt(btex $1$ etex, 1/2[v2,v4]);
  draw v3--v4; label.rt(btex $4$ etex, 1/2[v3,v4]);
  %draw v4--v1; label.bot(btex $\frac{1}{4}$ etex, 1/2[v4,v1]);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;
    dotlabel.llft(btex $v_1$ etex, v1)  withcolor (0.6,0,0);
    dotlabel.ulft(btex $v_2$ etex, v2)  withcolor (0.6,0,0);
    dotlabel.urt(btex $v_3$ etex, v3)  withcolor (0,0.6,0);
    dotlabel.lrt(btex $v_4$ etex, v4) withcolor (0,0.6,0);
    
    %draw v4..(-0.8cm,-0.8cm)..v2; label.llft(btex $\frac{1}{4}$ etex, (-1cm,-1cm));
    
 endfig;

  beginfig(8);

  
  draw v1--v2  withcolor(0.7,0.7,0.7); label.lft(btex $4$ etex, 1/2[v1,v2]) withcolor(0.7,0.7,0.7);
    draw v1--v4 ; label.top(btex $1$ etex, 1/2[v1,v4])  ;
    draw v2--v4  ; label.urt(btex $1$ etex, 1/2[v2,v4])  ;
  draw v3--v4  withcolor(0.7,0.7,0.7); label.rt(btex $4$ etex, 1/2[v3,v4]) withcolor(0.7,0.7,0.7);
  %draw v4--v1; label.bot(btex $\frac{1}{4}$ etex, 1/2[v4,v1]);
%for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

    dotlabel.llft(btex $v_1$ etex, v1) withcolor (0.6,0,0);
    dotlabel.ulft(btex $v_2$ etex, v2) withcolor (0.6,0,0);
    dotlabel.urt(btex $v_3$ etex, v3) withcolor (0,0.6,0);
    dotlabel.lrt(btex $v_4$ etex, v4) withcolor (0,0.6,0);
    
    %draw v4..(-0.8cm,-0.8cm)..v2; label.llft(btex $\frac{1}{4}$ etex, (-1cm,-1cm));
    
 endfig;
 
 
end;
