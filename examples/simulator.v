module main
import tfgridsimulator as sim

fn do()!{

	mut currencies := sim.currencies_new()
	currencies.currency_new(symbol:"eur",usdprice:0.97)!
	currencies.currency_new(symbol:"aed",usdprice:0.25)!

	//define a template node
	cpu_amd_gr9 := sim.Component{
		name: "AMD32"
		description: "powerful amd cpu"
		cost:400.0
		power:70
		cru:32
	}	
	case1u := sim.Component{
		name: "case_1u"
		description: "1U rack mountable case"
		cost:150.0
		rackspace:1
		power:20
	}	
	mem32 := sim.Component{
		name: "32GB"
		description: "memory 32 GB"
		cost:200.0
		power:20
		mru:32
	}
	ssd1 := sim.Component{
		name: "ssd1gb"
		description: "SSD of 1 GB"
		cost:120.0
		power:5
		sru:1000
	}			

	//lets populate our template
	mut node_1u_template := sim.node_template_new("1u")
	node_1u_template.components_add(nr:1,component:case1u) //add case
	node_1u_template.components_add(nr:1,component:cpu_amd_gr9) //add CPU
	node_1u_template.components_add(nr:4,component:mem32) //add mem
	node_1u_template.components_add(nr:2,component:ssd1) //add ssd
	println(node_1u_template)

	mut simulator := sim.new(
		//token prices
		token_price_start  : 0.05
		token_price_end  : 10
		//env params
		power_cost_avg  : 0.2
		//rackspace cost per U
		rackspace_cost_avg  : 10
		//nr of months lockup after adding node
		farming_lockup  : 24
		farming_min_utilizaton  : 30
	)!

	println(simulator)

	// simulator.run()!
	

}

fn main(){
	do() or {panic(err)}
}