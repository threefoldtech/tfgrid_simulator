module tfgridsimulator

// test token_farming
fn test_token_farming() {
	mut sim := new()!


	mut ri := sim.regionalinternet_add("test_ri")!

	ri.simulator.params.tokens.chi_total_tokens_million = 100
	mut node_template := NodeTemplate{}
	node_template.capacity.cloudunits.cu = 1
	node_template.capacity.cloudunits.su = 1
	node_template.capacity.cloudunits.nu = 1
	// println(ri.token_farming(node_template, 0))
	assert ri.token_farming(node_template, 0)! == 3.6
}