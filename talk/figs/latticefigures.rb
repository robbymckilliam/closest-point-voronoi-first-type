require 'rubypost'

require 'matrix'
require 'mathn'

include RubyPost

#a picture containing lattice points zoomed out
scale = 0.42
pic = Picture.new('picL')
M = Matrix[ [3.0,0.6], [0.6, 3.0] ]
(-7..7).each do |x|
  (-7..7).each do |y|
    v = M*Vector[x,y]*scale
    pic.add_drawable(Fill.new(Circle.new()).scale(0.1.cm).translate(v[0].cm,v[1].cm).colour(0.7,0,0))
  end
end

#clippath for all figures.  Fits nicely on beamer screen
clippath = "((-5.6cm,-3.83cm)--(5.6cm,-3.83cm)--(5.6cm,3.83cm)--(-5.6cm,3.83cm)--cycle)"

#figure with just lattice points
file = RubyPost::File.new('lattice')
fig = Figure.new
fig.add_drawable(Clip.new(clippath, pic))
fig.add_drawable(Draw.new(pic))
file.add_figure(fig)
file.compile

#a picture showing the sphere packing
sphere_diameter = (M*Vector[1,0]).r * scale
picsphp = Picture.new('picsphp')
(-7..7).each do |x|
  (-7..7).each do |y|
    v = M*Vector[x,y]*scale
    picsphp.add_drawable(Draw.new(Circle.new()).scale(sphere_diameter.cm).translate(v[0].cm,v[1].cm))
  end
end

#figure with lattice points and sphere packing
file = RubyPost::File.new('latticewithspherepacking')
fig = Figure.new
fig.add_drawable(Clip.new(clippath, pic))
fig.add_drawable(Draw.new(pic))
fig.add_drawable(Clip.new(clippath, picsphp))
fig.add_drawable(Draw.new(picsphp))
file.add_figure(fig)
file.compile

