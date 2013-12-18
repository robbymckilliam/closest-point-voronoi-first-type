require 'rubypost'

require 'matrix'
require 'mathn'

include RubyPost

file = RubyPost::File.new('iterativeseriesexample')

pic = Picture.new('picL')

M = Matrix[ [2,0.4], [0.4, 2] ]
(-7..7).each do |x|
	(-7..7).each do |y|
		v = M*Vector[x,y]
    pic.add_drawable(Fill.new(Circle.new()).scale(0.07.cm).translate(v[0].cm,v[1].cm).colour(0,0,0))
	end
end

#matrix with columns given by vector from obtuse superbasis
B = Matrix[ 
           [2.0, -1.6, -0.4], 
           [0.4, 1.6, -2.0] 
]

@fig1 = Figure.new

#draw a picture of a bigshaded square that we will clip to the Voronoi region
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
        @fig1.add_drawable(Clip.new(clipp, vorPic))
      end
    end
  end
end

clippath = "((-6.5cm,-4.1cm)--(6.5cm,-4.1cm)--(6.5cm,4.1cm)--(-6.5cm,4.1cm)--cycle)"
v = M*Vector[2,1]
@fig1.add_drawable(Draw.new(vorPic).translate(v[0].cm,v[1].cm))
@fig1.add_drawable(Draw.new(pic))
@fig1.add_drawable(Clip.new(clippath))

@y = M*Vector[2,1] + Vector[-0.4,0.7]
crossPic = Picture.new('cross')
crossPic.add_drawable(Draw.new("((-0.07cm,-0.07cm)--(0.07cm,0.07cm))"))
crossPic.add_drawable(Draw.new("((-0.07cm,0.07cm)--(0.07cm,-0.07cm))"))
crossPic.add_drawable(Label.new(latex('$y$'), Pair.new(0,0) )) 
@fig1.add_drawable(Draw.new(crossPic).translate(@y[0].cm,@y[1].cm))
puts @y

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

def iteratetonearestpoint(x, itrcount)
  itrcount = itrcount + 1
  # @fig1.add_drawable(Draw.new(Circle.new()).scale(0.13.cm).translate(x[0].cm,x[1].cm))
  @fig1.add_drawable(Label.new(latex('$x_' + itrcount.to_s + '$'), Pair.new(dround(x[0]).cm,dround(x[1]).cm) ).top) 
  u = nextrelvector(@y - x)
  xnext = x + u
  if( (@y - xnext).magnitude() < (@y - x).magnitude() )
    arrowpath = Path.new
    arrowdir = xnext - x
    alpha = 0.2
    arrowstart = x + alpha*arrowdir
    arrowend = x + (1.0-alpha)*arrowdir
    arrowpath.add_pair(Pair.new(dround(arrowstart[0]).cm,dround(arrowstart[1]).cm))
    arrowpath.add_pair(Pair.new(dround(arrowend[0]).cm,dround(arrowend[1]).cm))
    @fig1.add_drawable(Arrow.new(arrowpath))
    xclosest = iteratetonearestpoint(xnext,itrcount)
    return xclosest
  else return x
  end
end

x = M*Vector[-2,-1]
puts 'starting lattice point = ' + x.to_s
xclosest = iteratetonearestpoint(x,-1)
puts 'closest lattice point is ' + xclosest.to_s

file.add_figure(@fig1)
file.compile
