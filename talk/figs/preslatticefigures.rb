require 'rubygems'
require 'rubypost'

require 'matrix'
require 'mathn'

include RubyPost

file = RubyPost::File.new('preslatticefigures')

#create an axis peicture
axes = Picture.new('axes')

xaxis = Path.new
xaxis.add_pair(Pair.new(-3.95.cm, 0))
xaxis.add_pair(Pair.new(3.95.cm, 0))
yaxis = Path.new
yaxis.add_pair(Pair.new(0, -3.95.cm))
yaxis.add_pair(Pair.new(0, 3.95.cm))

#Axes.add_drawable(DoubleArrow.new(xaxis))
#axes.add_drawable(DoubleArrow.new(yaxis))
#axes.add_drawable(Label.new(latex("$y$"), Pair.new(0,3.95.cm)).bottom_right)
#axes.add_drawable(Label.new(latex("$x$"), Pair.new(3.95.cm, 0)).top_left)



pic = Picture.new('picL')
pic.add_drawable(Draw.new(axes))

M = Matrix[ [1,0.2], [0.2, 1] ]
(-7..7).each do |x|
	(-7..7).each do |y|
		v = M*Vector[x,y]
		pic.add_drawable(Fill.new(Circle.new()).scale(0.08.cm).translate(v[0].cm,v[1].cm).colour(0.7,0.0,0.0))
	end
end

fL = Picture.new('fL')
v = M*Vector[1,0]
cyc = Path.new
cyc.add_pair(Pair.new(0,0))
cyc.add_pair(Pair.new(v[0].cm,v[1].cm))
v2 = M*Vector[0,1]
cyc.add_pair(Pair.new((v[0]+v2[0]).cm,(v[1]+v2[1]).cm))
cyc.add_pair(Pair.new(v2[0].cm,v2[1].cm))
cyc.add_pair('cycle')
fL.add_drawable(Fill.new(cyc).colour(0.8,0.8,0.8))
v = M*Vector[1,0]
vec = Path.new
vec.add_pair(Pair.new(0,0))
vec.add_pair(Pair.new(v[0].cm,v[1].cm))
fL.add_drawable(Arrow.new(vec))
v = M*Vector[0,1]
vec = Path.new
vec.add_pair(Pair.new(0,0))
vec.add_pair(Pair.new(v[0].cm,v[1].cm))
fL.add_drawable(Arrow.new(vec))

fR = Picture.new('fR')
v = M*Vector[1,1]
cyc = Path.new
cyc.add_pair(Pair.new(0,0))
cyc.add_pair(Pair.new(v[0].cm,v[1].cm))
v2 = M*Vector[1,2]
cyc.add_pair(Pair.new((v[0]+v2[0]).cm,(v[1]+v2[1]).cm))
cyc.add_pair(Pair.new(v2[0].cm,v2[1].cm))
cyc.add_pair('cycle')
fR.add_drawable(Fill.new(cyc).colour(0.8,0.8,0.8))
v = M*Vector[1,1]
vec = Path.new
vec.add_pair(Pair.new(0,0))
vec.add_pair(Pair.new(v[0].cm,v[1].cm))
fR.add_drawable(Arrow.new(vec))
v = M*Vector[1,2]
vec = Path.new
vec.add_pair(Pair.new(0,0))
vec.add_pair(Pair.new(v[0].cm,v[1].cm))
fR.add_drawable(Arrow.new(vec))

fig = Figure.new
fig.add_drawable(Clip.new("(-4.05cm,-3.1cm)--(4.05cm,-3.1cm)--(4.05cm,3.1cm)--(-4.05cm,3.1cm)--cycle", pic))
#fig.add_drawable(Draw.new(fL))
fig.add_drawable(Draw.new(pic))
#fig.add_drawable(Draw.new(fR).translate(8.4.cm, 0))
#fig.add_drawable(Draw.new(pic).translate(8.4.cm, 0))
file.add_figure(fig)

#draw a picture of a bigshaded square that we will clip to the Voronoi region
vorPic = Picture.new('vorregion')
vorPic.add_drawable(Fill.new(Square.new).scale(5.cm).colour(0.8,0.8,0.8))

#this is a figure with a Voronoi region in it
fig2 = Figure.new

(-1..1).each do |x|
	(-1..1).each do |y|
    if( !((x==0) && (y==0)))
      v = (M*Vector[x,y])*0.5
      pv = Vector[1/v[0], -1/v[1]]*20
      clipp = Path.new
      clipp.add_pair(Pair.new((pv+v)[0].cm, (pv+v)[1].cm))
      clipp.add_pair(Pair.new((pv*(-1)+v)[0].cm, (pv*(-1)+v)[1].cm))
      clipp.add_pair(Pair.new((pv*(-1)-v)[0].cm, (pv*(-1)-v)[1].cm))
      clipp.add_pair(Pair.new((pv-v)[0].cm, (pv-v)[1].cm))
      clipp.add_pair('cycle')
      fig2.add_drawable(Clip.new(clipp, vorPic))
    end
	end
end
fig2.add_drawable(Clip.new(Square.new, vorPic).scale(2.cm))
fig2.add_drawable(Draw.new(vorPic))
v = M*Vector[2,2]
fig2.add_drawable(Draw.new(vorPic).translate(v[0].cm, v[1].cm))

fig2.add_drawable(Draw.new(pic))
file.add_figure(fig2)


#this is a picture that shows a covering and the outradius
piccovering = Picture.new('picconvering')
convp = Path.new
outrad = Vector[1.0/6 - 0.4, 1.0/6 + 0.4]*3
convp.add_pair(Pair.new)
convp.add_pair(Pair.new(outrad[0].cm, outrad[1].cm))
piccovering.add_drawable(Arrow.new(convp))
piccovering.add_drawable(Draw.new(axes))
piccovering.add_drawable( Label.new(latex('$\displaystyle R$'), Pair.new((-0.2/2*3).cm, (0.6/2*3).cm)).bottom_left)
(-3..3).each do |x|
	(-3..3).each do |y|
		v = M*Vector[x,y]*3
		piccovering.add_drawable(Fill.new(Circle.new).scale(0.05.cm).translate(v[0].cm,v[1].cm).colour(0.8,0.1,0.1))
    piccovering.add_drawable(Draw.new(Circle.new).scale((outrad.r*2).cm).translate(v[0].cm,v[1].cm))
	end
end


#this is a picture that shows a packing and the inradius
picsphp = Picture.new('picsphp')
#v = M*Vector[1,0]*(3.0/2.0)
#inradp = Path.new
#inradp.add_pair(Pair.new)
#inradp.add_pair(Pair.new(v[0].cm, v[1].cm))
#picsphp.add_drawable(Arrow.new(inradp))
#picsphp.add_drawable(Draw.new(axes))
#picsphp.add_drawable( Label.new(latex('$\displaystyle \rho$'), Pair.new((v[0]/2).cm, (v[1]/2).cm)) )
(-7..7).each do |x|
	(-7..7).each do |y|
		v = M*Vector[x,y]
		picsphp.add_drawable(Fill.new(Circle.new()).scale(0.08.cm).translate(v[0].cm,v[1].cm).colour(0.7,0.0,0.0))
    picsphp.add_drawable(Draw.new(Circle.new()).scale(((M*Vector[1,0]).r).cm).translate(v[0].cm,v[1].cm))
	end
end



#this is a figure that shows a sphere packing and the inradius
fig3 = Figure.new
#fig3.add_drawable(Clip.new(Square.new, vorPic).scale(2.cm))
fig.add_drawable(Clip.new("(-4.05cm,-3.1cm)--(4.05cm,-3.1cm)--(4.05cm,3.1cm)--(-4.05cm,3.1cm)--cycle", picsphp))
#fig3.add_drawable(Clip.new(Square.new, piccovering).scale(7.93.cm))
#fig3.add_drawable(Draw.new(vorPic).scale(3))
fig3.add_drawable(Draw.new(picsphp))
#fig3.add_drawable(Draw.new(vorPic).scale(3).translate(8.5.cm, 0))
#fig3.add_drawable(Draw.new(piccovering).translate(8.5.cm, 0))
#fig3.add_drawable(Clip.new(Rectangle.new(16.5.cm, 8.cm)))
file.add_figure(fig3)


#this is a picture that shows the relavant vectors
picrel = Picture.new('picrel')
picrel.add_drawable(Draw.new(axes))
(-4..4).each do |x|
	(-4..4).each do |y|
		v = M*Vector[x,y]*2
		picrel.add_drawable(Fill.new(Circle.new()).scale(0.05.cm).translate(v[0].cm,v[1].cm).colour(0.8,0.1,0.1))
	end
end

#this is a figure that shows a sphere packing and the inradius
fig4 = Figure.new
fig4.add_drawable(Clip.new(Square.new, vorPic).scale(2.cm))
fig4.add_drawable(Clip.new(Square.new, picrel).scale(7.93.cm))
fig4.add_drawable(Draw.new(vorPic).scale(2.0))
fig4.add_drawable(Draw.new(picrel))
(-1..1).each do |x|
	(-1..1).each do |y|
    if( (x+y).abs != 2 ) 
      v = M*Vector[x,y]*(2.0)
      relv = Path.new
      relv.add_pair(Pair.new).add_pair(Pair.new(v[0].cm, v[1].cm))
      fig4.add_drawable(Arrow.new(relv))
    end
	end
end
file.add_figure(fig4)


#draw a picture of a Bresenham set
fig5 = Figure.new
#ind = [ [1,0], [1,-1], [0,-1], [-1,-1], [-1,-2], [-2,-2], [2,0], [2,1], [3, 1], [0,0]]
ind = [[-2,-2], [-1,-2], [-1,-1],[0,-1], [0,0],[1,0],[2,0],[2,1],[3, 1]]
ind.each_index do |i|
  z = ind[i]
  v = M*Vector[z[0],z[1]]
  if(i%2 == 0)
    fig5.add_drawable(Draw.new(vorPic).translate(v[0].cm, v[1].cm).colour(0.65,0.65,0.65))
  else
    fig5.add_drawable(Draw.new(vorPic).translate(v[0].cm, v[1].cm)) 
  end
end
fig5.add_drawable(Draw.new(pic))
bresl = Path.new
bresl.add_pair('(-2cm,-2.1cm)--(3cm,1.6cm)')
fig5.add_drawable(Draw.new(bresl))
fig5.add_drawable(Clip.new(Square.new).scale(7.93.cm))
file.add_figure(fig5)


fig = Figure.new
fig.add_drawable(Clip.new(Square.new, pic).scale(7.93.cm))
fig.add_drawable(Draw.new(pic))
file.add_figure(fig)


squarelat = Picture.new('squarelat')
(-9..9).each do |x|
	(-9..9).each do |y|
		squarelat.add_drawable(Fill.new(Circle.new()).scale(0.05.cm).translate(x.cm,y.cm).colour(0.8,0.1,0.1))
	end
end

squarelatvor = Picture.new('squarelatvor')
squarelatvor.add_drawable(Fill.new(Square.new).scale(1.cm).colour(0.8,0.8,0.8))

#draw the integer lattice
fig7 = Figure.new
fig7.add_drawable(Draw.new(squarelatvor))
fig7.add_drawable(Draw.new(axes))
fig7.add_drawable(Draw.new(squarelat))
fig7.add_drawable(Clip.new(Square.new).scale(7.93.cm))
file.add_figure(fig7)

#draw the integer lattice
fig8 = Figure.new
ind = [[-2,-2], [-1,-2], [-1,-1],[0,-1], [0,0],[1,0],[2,0],[2,1],[3, 1],[3, 2]]
ind.each_index do |i|
  v = ind[i]
  if(i%2 == 0)
    fig8.add_drawable(Draw.new(squarelatvor).translate(v[0].cm, v[1].cm).colour(0.65,0.65,0.65))
  else
    fig8.add_drawable(Draw.new(squarelatvor).translate(v[0].cm, v[1].cm)) 
  end
end

fig8.add_drawable(Draw.new(axes))

fig8.add_drawable(Draw.new(bresl))
fig8.add_drawable(Draw.new(squarelat))
fig8.add_drawable(Clip.new(Square.new).scale(7.93.cm))
file.add_figure(fig8)

#draw another fund ppd pic
fig = Figure.new
fig.add_drawable(Clip.new(Square.new, pic).scale(7.93.cm))
fig.add_drawable(Draw.new(fR))
fig.add_drawable(Draw.new(pic))
#fig.add_drawable(Draw.new(fR).translate(8.4.cm, 0))
#fig.add_drawable(Draw.new(pic).translate(8.4.cm, 0))
file.add_figure(fig)

file.compile
file.view
