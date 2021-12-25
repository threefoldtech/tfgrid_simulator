	
	
import simulator

fn main() {

	println(simulator.extrapolate([0.0,1.0,2.0,5.0,10.0]))
	
	panic("s")

	mut sim := simulator.new()

	//define the avg node used in the simulator
	sim.params.node_template.investment_cost = 1100
	sim.params.node_template.power_watt = 50
	sim.params.node_template.rackspace = 0

	//the logic for minting, how much upside do we want to provide when there is no token upside
	sim.params.mult_start = 1.5 //means at start, we provide people X time return if token does not go up, does not take power cost in consideration
	sim.params.mult_end = 3.0	

	//token params
	sim.params.token_price_start = 1
	sim.params.token_price_end = 30

	//environment parameters
	sim.params.power_cost_avg = 0.15
	sim.params.rackspace_cost_avg = 10

	//in nr of nodes per month over 5 years, first col is start
	sim.params.growth_nr_new_nodes_per_month = [10.0,200.0,500.0,5000.0,10000.0,20000.0]


	sim.run()?

	println(" // PARAMS // ")
	println(sim)
	

	
}