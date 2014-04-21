require 'rubypost'

require 'matrix'
require 'mathn'

include RubyPost

#a picture containing lattice points zoomed out
scale = 0.42
pic = Picture.new('picL')
M = Matrix[ [3.0,0.6], [0.6, 3.0] ]*scale
(-7..7).each do |x|
  (-7..7).each do |y|
    v = M*Vector[x,y]
    pic.add_drawable(Fill.new(Circle.new()).scale(0.1.cm).translate(v[0].cm,v[1].cm).colour(0.7,0,0))
  end
end

#clippath for all figures.  Fits nicely on beamer screen
$clippath = "((-5.6cm,-3.83cm)--(5.6cm,-3.83cm)--(5.6cm,3.83cm)--(-5.6cm,3.83cm)--cycle)"

#figure with just lattice points
file = RubyPost::File.new('lattice')
fig = Figure.new
fig.add_drawable(Clip.new($clippath, pic))
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
fig.add_drawable(Clip.new($clippath, pic))
fig.add_drawable(Draw.new(pic))
fig.add_drawable(Clip.new($clippath, picsphp))
fig.add_drawable(Draw.new(picsphp))
file.add_figure(fig)
file.compile

#matrix with columns given by vector from obtuse superbasis
B = Matrix[ 
           [3.0, -2.4, -0.6], 
           [0.6, 2.4, -3.0] 
]*scale

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
  fig.add_drawable(Clip.new($clippath, vorPic))
  return vorPic
end

#figure with lattice points and Voronoi cell
file = RubyPost::File.new('voronoicell')
fig = Figure.new
fig.add_drawable(Draw.new(voronoiCell(fig)))
#fig.add_drawable(Clip.new($clippath, picsphp))
#fig.add_drawable(Draw.new(picsphp))
fig.add_drawable(Clip.new($clippath, pic))
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
#fig.add_drawable(Clip.new($clippath, picsphp))
#fig.add_drawable(Draw.new(picsphp))
fig.add_drawable(Clip.new($clippath, pic))
fig.add_drawable(Draw.new(pic))
fig.add_drawable(Draw.new(relvecsPic))
file.add_figure(fig)
file.compile

#figure with lattice points and Voronoi cell
file = RubyPost::File.new('relevantvectorsandspherepacking')
fig = Figure.new
fig.add_drawable(Draw.new(voronoiCell(fig)))
fig.add_drawable(Clip.new($clippath, picsphp))
fig.add_drawable(Draw.new(picsphp))
fig.add_drawable(Clip.new($clippath, pic))
fig.add_drawable(Draw.new(pic))
fig.add_drawable(Draw.new(relvecsPic))
file.add_figure(fig)
file.compile
