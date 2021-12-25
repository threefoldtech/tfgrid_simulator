module simulator


[heap]
pub struct Simulator{
pub mut:
	months []NodesAddedInMonth
	params SimulatorParams

}

[heap]
pub struct SimulatorParams{
pub mut:
	nrmonths int = 60
	//multiplicators for the return
	mult_start f64 = 1.5
	mult_end f64 = 3.0
	//token prices
	token_price_start int = 1
	token_price_end int = 30
	//env params
	power_cost_avg f64 = 0.15
	//rackspace cost per U
	rackspace_cost_avg f64 = 10
	//template for the avg node
	node_template &NodeTemplate
	//nr of months lockup after adding node
	farming_lockup int = 24
	farming_min_utilizaton int = 30
	//growth
	growth_nr_new_nodes_per_month []f64
}


pub fn new() Simulator{
	mut nt := NodeTemplate{}
	return Simulator{
		params: SimulatorParams{
			node_template:&nt
		}
	}
}






