	
	
module tfgridsimulator



pub fn (mut sim Simulator) run() ?{

	regional_internets_new := extrapolate_growth(sim.params.regional_internets_nr)
	for internet_new in regional_internets_new{
		//this is now many new internets will be added per month
		sim.regionalinternet_new(internet_new)?
	}


	println(regional_internets_new)
	panic("ss")

	// nr_nodes_month := extrapolate(sim.params.growth_nr_new_nodes_per_month,5)

	// for month in 0..nr_nodes_month.len{
	// 	// println(" - add month: ${month+1}")
	// 	// sim.add_nodes_for_1_month(nr_nodes_month[month])?
	// }


}
