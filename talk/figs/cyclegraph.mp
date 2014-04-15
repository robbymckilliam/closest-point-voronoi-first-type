prologues := 2;
filenametemplate "%j-%c.mps";
verbatimtex
%&latex
\documentclass{minimal}
\begin{document}
etex

  pi=3.141592653689793238462643; % definition pi
r=3cm;%radius of graph
numv=8; %number of vertices we will draw
theta=360/numv;

%number of
pair v[];
v1 = r*(cosd(2*theta),sind(2*theta));
v2 = r*(cosd(3*theta),sind(3*theta));
v3 = r*(cosd(4*theta),sind(4*theta));
v4 = r*(cosd(5*theta),sind(5*theta));
v5 = r*(cosd(6*theta),sind(6*theta));
v6 = r*(cosd(7*theta),sind(7*theta));
v7 = r*(cosd(8*theta),sind(8*theta));
v8 = r*(cosd(9*theta),sind(9*theta));
 
%An cycle figure
  beginfig(1);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  draw v1--v2; label.ulft(btex $1$ etex, 1/2[v1,v2]);
  draw v2--v3; label.lft(btex $1$ etex, 1/2[v2,v3]);
  draw v3--v4; label.llft(btex $1$ etex, 1/2[v3,v4]);
    draw v4--v5; label.bot(btex $1$ etex, 1/2[v4,v5]);
    draw v5--v6 dashed evenly; %label.lft(btex $1$ etex, 1/2[v5,v6]);
    draw v6--v7 ; label.lrt(btex $1$ etex, 1/2[v6,v7]);
    draw v7--v8; label.rt(btex $1$ etex, 1/2[v7,v8]);
    draw v8--v1; label.urt(btex $1$ etex, 1/2[v8,v1]);
%draw v4--v1; label.top(btex $1$ etex, 1/2[v4,v1]);

    
  dotlabel.top(btex $v_1$ etex, v1);
  dotlabel.ulft(btex $v_2$ etex, v2);
  dotlabel.lft(btex $v_3$ etex, v3);
  dotlabel.llft(btex $v_4$ etex, v4);
    dotlabel.bot(btex $v_5$ etex, v5);
    dotlabel.lrt(btex $v_{n-1}$ etex, v6);
    dotlabel.rt(btex $v_{n}$ etex, v7);
    dotlabel.urt(btex $v_{n+1}$ etex, v8);
    
  
  endfig;

%An cycle figure
  beginfig(2);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  draw v1--v2; label.ulft(btex $1$ etex, 1/2[v1,v2]);
  draw v2--v3 withcolor(0.7,0.7,0.7); label.lft(btex $1$ etex, 1/2[v2,v3]) withcolor(0.7,0.7,0.7);
  draw v3--v4 withcolor(0.7,0.7,0.7); label.llft(btex $1$ etex, 1/2[v3,v4]) withcolor(0.7,0.7,0.7);
    draw v4--v5 withcolor(0.7,0.7,0.7); label.bot(btex $1$ etex, 1/2[v4,v5]) withcolor(0.7,0.7,0.7);
    draw v5--v6 dashed evenly withcolor(0.7,0.7,0.7); %label.lft(btex $1$ etex, 1/2[v5,v6]);
    draw v6--v7 withcolor(0.7,0.7,0.7); label.lrt(btex $1$ etex, 1/2[v6,v7]) withcolor(0.7,0.7,0.7);
    draw v7--v8 withcolor(0.7,0.7,0.7); label.rt(btex $1$ etex, 1/2[v7,v8]) withcolor(0.7,0.7,0.7);
    draw v8--v1; label.urt(btex $1$ etex, 1/2[v8,v1]);
%draw v4--v1; label.top(btex $1$ etex, 1/2[v4,v1]);

    
  dotlabel.top(btex $v_1$ etex, v1) withcolor(0,0.6,0);
  dotlabel.ulft(btex $v_2$ etex, v2) withcolor(0.6,0,0);
  dotlabel.lft(btex $v_3$ etex, v3) withcolor(0.6,0,0);
  dotlabel.llft(btex $v_4$ etex, v4) withcolor(0.6,0,0);
    dotlabel.bot(btex $v_5$ etex, v5) withcolor(0.6,0,0);
    dotlabel.lrt(btex $v_{n-1}$ etex, v6) withcolor(0.6,0,0);
    dotlabel.rt(btex $v_{n}$ etex, v7) withcolor(0.6,0,0);
    dotlabel.urt(btex $v_{n+1}$ etex, v8) withcolor(0.6,0,0);
    
  
  endfig;


%An cycle figure
  beginfig(3);

  %for i = 1 upto 4: fill fullcircle scaled 0.1cm shifted v[i]; endfor;

  draw v1--v2 withcolor(0.7,0.7,0.7); label.ulft(btex $1$ etex, 1/2[v1,v2]) withcolor(0.7,0.7,0.7);
  draw v2--v3 withcolor(0.7,0.7,0.7);  label.lft(btex $1$ etex, 1/2[v2,v3]) withcolor(0.7,0.7,0.7);
  draw v3--v4 ; label.llft(btex $1$ etex, 1/2[v3,v4]);
    draw v4--v5 withcolor(0.7,0.7,0.7); label.bot(btex $1$ etex, 1/2[v4,v5]) withcolor(0.7,0.7,0.7);
    draw v5--v6 dashed evenly withcolor(0.7,0.7,0.7); %label.lft(btex $1$ etex, 1/2[v5,v6]);
    draw v6--v7 withcolor(0.7,0.7,0.7); label.lrt(btex $1$ etex, 1/2[v6,v7]) withcolor(0.7,0.7,0.7);
    draw v7--v8 withcolor(0.7,0.7,0.7); label.rt(btex $1$ etex, 1/2[v7,v8]) withcolor(0.7,0.7,0.7);
    draw v8--v1; label.urt(btex $1$ etex, 1/2[v8,v1]);
%draw v4--v1; label.top(btex $1$ etex, 1/2[v4,v1]);

    
  dotlabel.top(btex $v_1$ etex, v1) withcolor(0,0.6,0);
  dotlabel.ulft(btex $v_2$ etex, v2) withcolor(0,0.6,0);
  dotlabel.lft(btex $v_3$ etex, v3) withcolor(0,0.6,0);
  dotlabel.llft(btex $v_4$ etex, v4) withcolor(0.6,0,0);
    dotlabel.bot(btex $v_5$ etex, v5) withcolor(0.6,0,0);
    dotlabel.lrt(btex $v_{n-1}$ etex, v6) withcolor(0.6,0,0);
    dotlabel.rt(btex $v_{n}$ etex, v7) withcolor(0.6,0,0);
    dotlabel.urt(btex $v_{n+1}$ etex, v8) withcolor(0.6,0,0);
    
  
  endfig;

  
  end;