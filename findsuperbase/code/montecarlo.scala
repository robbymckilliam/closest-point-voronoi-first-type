/**
* Run montecarlo.
*/
import pubsim.distributions.RealRandomVariable
import pubsim.VectorFunctions.randomMatrix

val iters = 10
val Ns = List(1,2,3,4,5)

val starttime = (new java.util.Date).getTime

val datalist = Ns.map{ n =>
val p = 1.0
(n,p,0.1)
}.toList

val file = new java.io.FileWriter("data/testname")
file.write("n" + "\t" + "proportion" + "\t" + "stddev" + "\n")
datalist.foreach{ v => 
  val (n,p,d) = v
  file.write(n + "\t" + p + "\t" + d + "\n")
}
file.close

val runtime = (new java.util.Date).getTime - starttime
println("Finished in " + (runtime/1000.0) + " seconds.\n") 
