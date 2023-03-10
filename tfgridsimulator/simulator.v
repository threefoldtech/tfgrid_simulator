	
	
module tfgridsimulator


pub fn (mut sim Simulator) calc() !{

	for mut ri in sim.regional_internets{
		ri.calc()!
	}
}

pub fn (mut sim Simulator) get_node_templates() []&NodeTemplate{
	mut res := []&NodeTemplate{}
	return res
}