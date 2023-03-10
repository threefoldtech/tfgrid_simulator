module tfgridsimulator



[heap]
pub struct SimulatorParams{
pub mut:
	nrmonths int = 6*12
	//multiplicators for the return
	mult_start f64 = 1.0
	mult_end f64 = 1.0
	//token prices
	token_price_start f64 = 1
	token_price_end f64 = 1
	//env params
	power_cost_avg f64 = 0.06
	support_cost_node f64 = 20.0
	//rackspace cost per U per month in USD
	rackspace_cost_avg f64 = 10
	//template for the avg node
	node_template NodeTemplate
	//nr of months lockup after adding node
	farming_lockup int = 24
	farming_min_utilizaton int = 0
	wiki_path string = "/tmp/simulatorwiki"
	chi_price_usd string = "1:1"
	chi_total_tokens_million int = 1000
}


[heap]
pub struct Simulator{
pub mut:
	params SimulatorParams
	regional_internets []&RegionalInternet
}
