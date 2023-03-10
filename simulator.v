module main
import tfgridsimulator as sim

fn do()!{

	//define a template node
	cpu_amd_gr9 := sim.Component{
		name: "AMD32"
		description: "powerful amd cpu"
		cost:250.0
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
		cost:90.0
		power:20
		mru:32
	}
	ssd1 := sim.Component{
		name: "ssd2gb"
		description: "SSD of 1 GB"
		cost:120.0
		power:5
		sru:2000
	}			

	//lets populate our template
	mut node_1u_template := sim.node_template_new("1u")
	node_1u_template.components_add(nr:1,component:case1u) //add case
	node_1u_template.components_add(nr:1,component:cpu_amd_gr9) //add CPU
	node_1u_template.components_add(nr:4,component:mem32) //add mem
	node_1u_template.components_add(nr:2,component:ssd1) //add ssd
	// println(node_1u_template)

	mut simulator := sim.new(
		power_cost_avg  : 0.06			//env params
		rackspace_cost_avg  : 10		//rackspace cost per U
		farming_lockup  : 24 			//nr of months lockup after adding node
		farming_min_utilizaton  : 30
		chi_price_usd : '1:0.1,12:0.2,24:0.5,36:3,60:10'
	)!

	mut ri:= simulator.regionalinternet_add("znz")!

	//specify how many nodes are added per month
	ri.nodes_add(template:node_1u_template, growth:'3:0,4:50,12:200,24:1000,60:3000')!

	simulator.calc()!

	w:=ri.sheet.wiki()!
	println(w)

}

fn main(){
	do() or {panic(err)}
}