/**
* Run montecarlo.
*/
import pubsim.distributions.RealRandomVariable
import pubsim.VectorFunctions.randomMatrix

val iters = 10
val Ns = List(1,2,3,4,5)

val starttime = (new java.util.Date).getTime

Ns.map{ n =>

}



val runtime = (new java.util.Date).getTime - starttime
println("Finished in " + (runtime/1000.0) + " seconds.\n") 





