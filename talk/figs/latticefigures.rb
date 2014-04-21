require 'rubypost'

require 'matrix'
require 'mathn'

include RubyPost

#a picture containing lattice points zoomed out
SCALE = 0.42
pic = Picture.new('picL')
M = Matrix[ [3.0,0.6], [0.6, 3.0] ]*SCALE
(-7..7).each do |x|
  (-7..7).each do |y|
    v = M*Vector[x,y]
    pic.add_drawable(Fill.new(Circle.new()).scale(0.1.cm).translate(v[0].cm,v[1].cm).colour(0.7,0,0))
  end
end

#clippath for all figures.  Fits nicely on beamer screen
CLIPPATH = "((-5.6cm,-3.83cm)--(5.6cm,-3.83cm)--(5.6cm,3.83cm)--(-5.6cm,3.83cm)--cycle)"

#figure with just lattice points
file = RubyPost::File.new('lattice')
fig = Figure.new
fig.add_drawable(Clip.new(CLIPPATH, pic))
fig.add_drawable(Draw.new(pic))
file.add_figure(fig)
file.compile

#a picture showing the sphere packing
sphere_diameter = (M*Vector[1,0]).r
picsphp = Picture.new('picsphp')
(-7..7).each do |x|
  (-7..7).each do |y|
    v = M*Vector[x,y]
    picsphp.add_drawable(Draw.new(Circle.new()).scale(sphere_diameter.cm).translate(v[0].cm,v[1].cm))
  end
end

#figure with lattice points and sphere packing
file = RubyPost::File.new('latticewithspherepacking')
fig = Figure.new
fig.add_drawable(Clip.new(CLIPPATH, pic))
fig.add_drawable(Draw.new(pic))
fig.add_drawable(Clip.new(CLIPPATH, picsphp))
fig.add_drawable(Draw.new(picsphp))
file.add_figure(fig)
file.compile

#matrix with columns given by vector from obtuse superbasis
B = Matrix[ 
           [3.0, -2.4, -0.6], 
           [0.6, 2.4, -3.0] 
]*SCALE

#draws a picture of a bigshaded square that we will clip to the Voronoi region
def voronoiCell(fig)
  vorPic = Picture.new('vorregion')
  vorPic.add_drawable(Fill.new(Square.new).scale(15.cm).colour(0.7,0.7,0.7))
  #relevant vector given by the appropriate combinations of the obtuse superbasis
  (0..1).each do |x|
    (0..1).each do |y|
      (0..1).each do |z|
        if( ((x+y+z)!=0) && ((x+y+z)!=3) )
          v = (B*Vector[x,y,z])*0.5
          pv = Vector[1/v[0], -1/v[1]]*30
          clipp = Path.new
          clipp.add_pair(Pair.new((pv+v)[0].cm, (pv+v)[1].cm))
          clipp.add_pair(Pair.new((pv*(-1)+v)[0].cm, (pv*(-1)+v)[1].cm))
          clipp.add_pair(Pair.new((pv*(-1)-v)[0].cm, (pv*(-1)-v)[1].cm))
          clipp.add_pair(Pair.new((pv-v)[0].cm, (pv-v)[1].cm))
          clipp.add_pair('cycle')
          fig.add_drawable(Clip.new(clipp, vorPic))
        end
      end
    end
  end
  clip_sphere_diameter = ((M*Vector[1,0]).r)*1.5 #a guess for an upper bound on the covering radius
  fig.add_drawable(Clip.new("fullcircle scaled " + clip_sphere_diameter.to_s + "cm", vorPic))
  return vorPic
end

#figure with lattice points and Voronoi cell
file = RubyPost::File.new('voronoicell')
fig = Figure.new
fig.add_drawable(Draw.new(voronoiCell(fig)))
#fig.add_drawable(Clip.new(CLIPPATH, picsphp))
#fig.add_drawable(Draw.new(picsphp))
fig.add_drawable(Clip.new(CLIPPATH, pic))
fig.add_drawable(Draw.new(pic))
file.add_figure(fig)
file.compile

#picture containing the relevant vectors
relvecsPic = Picture.new('relvecs')
(0..1).each do |x|
  (0..1).each do |y|
    (0..1).each do |z|
      if( ((x+y+z)!=0) && ((x+y+z)!=3) )
        v = B*Vector[x,y,z]
        relvecsPic.add_drawable(Draw.new(Circle.new()).scale(0.2.cm).translate(v[0].cm,v[1].cm).colour(0,0,0.7))
      end
    end
  end
end

#figure with lattice points and Voronoi cell
file = RubyPost::File.new('relevantvectors')
fig = Figure.new
fig.add_drawable(Draw.new(voronoiCell(fig)))
#fig.add_drawable(Clip.new(CLIPPATH, picsphp))
#fig.add_drawable(Draw.new(picsphp))
fig.add_drawable(Clip.new(CLIPPATH, pic))
fig.add_drawable(Draw.new(pic))
fig.add_drawable(Draw.new(relvecsPic))
file.add_figure(fig)
file.compile

#figure with lattice points and Voronoi cell
file = RubyPost::File.new('relevantvectorsandspherepacking')
fig = Figure.new
fig.add_drawable(Draw.new(voronoiCell(fig)))
fig.add_drawable(Clip.new(CLIPPATH, picsphp))
fig.add_drawable(Draw.new(picsphp))
fig.add_drawable(Clip.new(CLIPPATH, pic))
fig.add_drawable(Draw.new(pic))
fig.add_drawable(Draw.new(relvecsPic))
file.add_figure(fig)
file.compile

@x = M*Vector[3,1] #the closest point to @y
@y = @x + Vector[0.5,-0.1] 

#figure depicting the closest lattice point
file = RubyPost::File.new('closestpoint')
fig = Figure.new
vcell = voronoiCell(fig)
fig.add_drawable(Draw.new(vcell))
fig.add_drawable(Draw.new(vcell).translate(@x[0].cm,@x[1].cm))
crossPic = Picture.new('cross')
puts "x = " + (@x/SCALE).to_s + " and y = " + (@y/SCALE).to_s
crossPic.add_drawable(Draw.new("((-0.07cm,-0.07cm)--(0.07cm,0.07cm))"))
crossPic.add_drawable(Draw.new("((-0.07cm,0.07cm)--(0.07cm,-0.07cm))"))
crossPic.add_drawable(Label.new(latex('$y$'), Pair.new(0,0) )) 
fig.add_drawable(Draw.new(crossPic).translate(@y[0].cm,@y[1].cm))
fig.add_drawable(Label.new(latex('$x$'), Pair.new(@x[0].cm,@x[1].cm) )) 
fig.add_drawable(Clip.new(CLIPPATH, pic))
fig.add_drawable(Draw.new(pic))
file.add_figure(fig)
file.compile

#computes a next nearest relvant vector
def nextrelvector(z)
  best = []
  bestDist = Float::MAX
  (0..1).each do |i|
    (0..1).each do |j|
      (0..1).each do |k|
        p = (B*Vector[i,j,k])
        dist = (z - p).magnitude()
        if(dist < bestDist)
          bestDist = dist
          best = p
        end
      end
    end
  end
  return best
end

#rounds floats to 4 decimal places
def dround(x)
 ((1000.0*x).round/1000.0).to_f
end

def iteratetonearestpoint(x, itrcount, fig)
  itrcount = itrcount + 1
  # @fig1.add_drawable(Draw.new(Circle.new()).scale(0.13.cm).translate(x[0].cm,x[1].cm))
  fig.add_drawable(Label.new(latex('$x_' + itrcount.to_s + '$'), Pair.new(dround(x[0]).cm,dround(x[1]).cm) ).top) 
  u = nextrelvector(@y - x)
  xnext = x + u
  if( (@y - xnext).magnitude() < (@y - x).magnitude() )
    arrowpath = Path.new
    arrowdir = xnext - x
    alpha = 0.3
    arrowstart = x + alpha*arrowdir
    arrowend = x + (1.0-alpha)*arrowdir
    arrowpath.add_pair(Pair.new(dround(arrowstart[0]).cm,dround(arrowstart[1]).cm))
    arrowpath.add_pair(Pair.new(dround(arrowend[0]).cm,dround(arrowend[1]).cm))
    fig.add_drawable(Arrow.new(arrowpath))
    xclosest = iteratetonearestpoint(xnext,itrcount,fig)
    return xclosest
  else return x
  end
end

#figure showing a series of relevant vectors convergin to a closest lattice point
file = RubyPost::File.new('seriesofrelevantvectors')
fig = Figure.new
vcell = voronoiCell(fig)
fig.add_drawable(Draw.new(vcell).translate(@x[0].cm,@x[1].cm))
x0 = M*Vector[-3,-1]
puts 'starting lattice point = ' + x0.to_s
xclosest = iteratetonearestpoint(x0, -1, fig)
puts 'closest lattice point is ' + (xclosest/SCALE).to_s
crossPic = Picture.new('cross')
puts "x = " + (@x/SCALE).to_s + " and y = " + (@y/SCALE).to_s
crossPic.add_drawable(Draw.new("((-0.07cm,-0.07cm)--(0.07cm,0.07cm))"))
crossPic.add_drawable(Draw.new("((-0.07cm,0.07cm)--(0.07cm,-0.07cm))"))
crossPic.add_drawable(Label.new(latex('$y$'), Pair.new(0,0) )) 
fig.add_drawable(Draw.new(crossPic).translate(@y[0].cm,@y[1].cm))
#fig.add_drawable(Label.new(latex('$x$'), Pair.new(@x[0].cm,@x[1].cm) ).right) 
fig.add_drawable(Clip.new(CLIPPATH, pic))
fig.add_drawable(Draw.new(pic))
file.add_figure(fig)
file.compile
