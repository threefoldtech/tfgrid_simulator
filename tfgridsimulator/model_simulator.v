module tfgridsimulator

[heap]
pub struct Simulator{
pub mut:
	months []NodesBatch
	params SimulatorParams

}

//create a new simulator
// ```
// 	nrmonths int = 60
// 	//multiplicators for the return
// 	mult_start f64 = 1.0
// 	mult_end f64 = 1.0
// 	//token prices
// 	token_price_start f64 = 0.05
// 	token_price_end f64 = 10
// 	//env params
// 	power_cost_avg f64 = 0.2
// 	//rackspace cost per U
// 	rackspace_cost_avg f64 = 10
// 	//template for the avg node
// 	node_template NodeTemplate
// 	//nr of months lockup after adding node
// 	farming_lockup int = 24
// 	farming_min_utilizaton int = 30
// 	//growth
// 	regional_internets_nr []int
// ```
pub fn new(a SimulatorParams)? Simulator{
	mut s := Simulator{
		params: a
	}
	if s.params.regional_internets_nr == [] {
		s.params.regional_internets_nr = [1,2,5,10,100,1000]  //nr of regional internets, first month is start position
	}
	if s.params.regional_internet_growth == [] {
		s.params.regional_internet_growth= [0,10,20,50,100,100] //percentage of nodes which are installed per regional internet over years
	}
	if s.params.growth_factor == [] {
		s.params.growth_factor= [20,30,50,100,100,100] //growth in relation to above
	}

	s.run()?
	return s
}


[heap]
pub struct SimulatorParams{
pub mut:
	nrmonths int = 60
	//multiplicators for the return
	mult_start f64 = 1.0
	mult_end f64 = 1.0
	//token prices
	token_price_start f64 = 0.05
	token_price_end f64 = 10
	//env params
	power_cost_avg f64 = 0.2
	//rackspace cost per U
	rackspace_cost_avg f64 = 10
	//template for the avg node
	node_template NodeTemplate
	//nr of months lockup after adding node
	farming_lockup int = 24
	farming_min_utilizaton int = 30
	//growth
	regional_internets_nr []int
	regional_internet_growth []int
	growth_factor []int
}

