require 'rubypost'

require 'matrix'
require 'mathn'

include RubyPost

file = RubyPost::File.new('latticefigures')

pic = Picture.new('picL')

M = Matrix[ [3,0.6], [0.6, 3] ]
(-7..7).each do |x|
	(-7..7).each do |y|
		v = M*Vector[x,y]
pic.add_drawable(Fill.new(Circle.new()).scale(0.07.cm).translate(v[0].cm,v[1].cm).colour(0,0,0))
	end
end

#matrix with columns given by vector from obtuse superbasis
B = Matrix[ 
           [3.0, -2.4, -0.6], 
           [0.6, 2.4, -3.0] 
]

fig1 = Figure.new

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
        fig1.add_drawable(Clip.new(clipp, vorPic))
      end
    end
  end
end

clippath = "((-6.5cm,-4cm)--(6.5cm,-4cm)--(6.5cm,4cm)--(-6.5cm,4cm)--cycle)"
fig1.add_drawable(Clip.new(clippath, pic))
fig1.add_drawable(Clip.new(clippath, vorPic))
fig1.add_drawable(Draw.new(vorPic))
fig1.add_drawable(Draw.new(pic))
(0..1).each do |x|
  (0..1).each do |y|
    (0..1).each do |z|
      if( ((x+y+z)!=0) && ((x+y+z)!=3) )
        v = B*Vector[x,y,z]
        fig1.add_drawable(Draw.new(Circle.new()).scale(0.15.cm).translate(v[0].cm,v[1].cm))
      end
    end
  end
end

#this is a picture that shows a packing and the inradius
picsphp = Picture.new('picsphp')
v = M*Vector[1,0]/2.0
inradp = Path.new
alpha = 0.0
inradp.add_pair(Pair.new((v[0]*alpha).cm, (v[1]*alpha).cm))
inradp.add_pair(Pair.new((v[0]*(1-alpha)).cm, (v[1]*(1-alpha)).cm))
picsphp.add_drawable(Arrow.new(inradp))
#pv = Vector[1/v[0], -1/v[1]]*0.025
#lengthtickpair = Path.new
#lengthtickpair.add_pair(Pair.new(pv[0].cm,pv[1].cm))
#lengthtickpair.add_pair(Pair.new((-pv[0]).cm,(-pv[1]).cm))
#picsphp.add_drawable(Draw.new(lengthtickpair).translate((v[0]*alpha).cm, (v[1]*alpha).cm))
#picsphp.add_drawable(Draw.new(lengthtickpair).translate((v[0]*(1-alpha)).cm, (v[1]*(1-alpha)).cm))
picsphp.add_drawable(Label.new(latex('$\displaystyle \rho$'), Pair.new((v[0]/2).cm, (v[1]/2).cm)) )
(-7..7).each do |x|
  (-7..7).each do |y|
    v = M*Vector[x,y]
    picsphp.add_drawable(Draw.new(Circle.new()).scale(((M*Vector[1,0]).r).cm).translate(v[0].cm,v[1].cm))
  end
end
fig1.add_drawable(Clip.new(clippath, picsphp))
fig1.add_drawable(Draw.new(picsphp))

file.add_figure(fig1)



file.compile
