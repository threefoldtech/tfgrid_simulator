	
	
module tfgridsimulator

import freeflowuniverse.crystallib.calc

//X nr of nodes who are added in 1 month
[params]
struct NodesBatch{
pub mut:	
	node_template &NodeTemplate [str: skip]
	nrnodes int
	start_month int
	nrmonths int
	regional_internet &RegionalInternet [str: skip]
}

struct NBCalc{
pub mut:	
	power_kwh int
	tokens_farmed f64
	rackspace f64
	power_cost f64
	rackspace_cost f64
	hw_cost f64
	support_cost f64
	nrnodes f64
}


fn (mut nb NodesBatch) calc(month int)!NBCalc{


	power_kwh:=nb.node_template.capacity.power*24*30/1000 * nb.nrnodes
	rackspace:=nb.node_template.capacity.rackspace * nb.nrnodes
	params:=nb.regional_internet.simulator.params
	tokens_farmed:=nb.regional_internet.token_farming(nb.node_template, month )!

	if month < nb.start_month{
		return NBCalc{}
	}
	if month > nb.start_month + nb.nrmonths{
		return NBCalc{}
	}

	nbc:=NBCalc{
		power_kwh: int(power_kwh)
		power_cost: power_kwh * params.power_cost_avg
		rackspace: rackspace
		rackspace_cost: rackspace * params.rackspace_cost_avg
		hw_cost: nb.node_template.capacity.cost / 6 / 12 * nb.nrnodes			//over 6 years
		support_cost: params.support_cost_node + nb.node_template.capacity.cost * 0.02 / 12 * nb.nrnodes  //2% of HW has to be replaced
		tokens_farmed: tokens_farmed * nb.nrnodes	
		nrnodes: nb.nrnodes
	}

	return nbc
}
