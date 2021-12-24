	
	
module simulator



pub fn (mut sim Simulator) run() ?{

	nr_nodes_month := extrapolate_addmonths(sim.params.growth_nr_new_nodes_per_month,5)

	for month in 0..nr_nodes_month.len{
		// println(" - add month: ${month+1}")
		sim.add_nodes_for_1_month(nr_nodes_month[month])?
	}


}
