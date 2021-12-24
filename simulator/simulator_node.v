	
	
module simulator

[heap]
pub struct NodeTemplate{
pub mut:
	investment_cost int
	//consumption for 1 node
	power_watt f64
	//expressed in U, there are 44 in 1 rack
	rackspace f64
}


//X nr of nodes who are added in 1 month
struct NodesAddedInMonth{
pub mut:	
	nrnodes f64
	start_month int
	status NodeStatus
	tokens_month f64
	//how much is cost for the rackspace per month, expressed in U
	rackspace_cost_month f64
	//how much is cost for the power per month
	power_cost_month f64
}


enum NodeStatus{
	new
	active
	down
}

//how much return do we want to give to a farmer if the tokens would not go up in value?
fn (mut node NodesAddedInMonth) return_no_token_upside(mut simulator &Simulator, month f64) f64 {
	//between start & end, interpolated
	return (simulator.params.mult_end - simulator.params.mult_start)/simulator.params.nrmonths * month

}


//month where the initialization starts
fn  (mut simulator Simulator) add_nodes_for_1_month( nrnodes f64)? {
	start_month := simulator.months.len
	mut nodes_added := NodesAddedInMonth{
			nrnodes: nrnodes,
			start_month:start_month
		}
	//the logic for minting
	nodes_added.tokens_month = nodes_added.return_no_token_upside(mut simulator, start_month) * simulator.params.node_template.investment_cost / simulator.params.nrmonths
	nodes_added.rackspace_cost_month = simulator.params.rackspace_cost_avg * simulator.params.node_template.rackspace
	nodes_added.power_cost_month = simulator.params.power_cost_avg * simulator.params.node_template.power_watt
	simulator.months << nodes_added
}

