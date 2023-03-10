module tfgridsimulator

import freeflowuniverse.crystallib.calc

pub struct RegionalInternet{
pub mut:
	name string
	batches []NodesBatch
	simulator &Simulator  [str: skip]
	sheet calc.Sheet
}


pub struct RegionalInternetNew{
pub mut:
	name string
}


pub fn (mut sim Simulator) regionalinternet_add (name string)! &RegionalInternet{

	mut sh := calc.sheet_new(name: name,nrcol:sim.params.nrmonths) or { panic(err) }
	mut ri := RegionalInternet{
		name:name
		simulator:&sim
		sheet: sh
	}
	sim.regional_internets << &ri
	return sim.regional_internets.last()
}

pub struct RegionalInternetNodesAddArgs{
pub mut:
	template NodeTemplate
	growth string = '3:0,4:50,12:100,24:1000,60:5000'	
}

// add nodes to a regional internet:
// args:
//   nodetemplate NodeTemplate
//   nodegrowth string = '3:0,4:50,12:5000,24:50000,60:1000000'	
pub fn (mut ri RegionalInternet) nodes_add (args RegionalInternetNodesAddArgs)!{
	mut sh := calc.sheet_new(name: 'temp') or { panic(err) }
	mut nrnodes_add := sh.row_new(name: 'nrnodes_added', growth: args.growth)!
	nrnodes_add.int()
	// mut nrnodes := nrnodes_add.aggregate('nrnodes')!
	// println(nrnodes_add)
	// println(nrnodes)
	mut month:=0
	for cell in nrnodes_add.cells{
		// mut sh_nb := calc.sheet_new(name: "nb",nrcol:ri.simulator.params.nrmonths) or { panic(err) }
		mut nb:= NodesBatch{
			node_template : &args.template
			nrnodes :int(cell.val)
			start_month :month
			nrmonths :ri.simulator.params.nrmonths
			regional_internet : &ri
			// sheet: sh_nb
		}
		// nb.node_template.calc()//not needed done in each component step
		ri.batches << nb
		month+=1
	}
}

//calculate how a regional internet will expand in relation to the arguments given
pub fn (mut ri RegionalInternet) calc()!{
	mut nrnodes := ri.sheet.row_new(name: 'nrnodes',aggregatetype:.max)!
	mut powerusage := ri.sheet.row_new(name: 'powerusage')!
	mut chi_total_tokens := ri.sheet.row_new(name: 'chi_total_tokens',growth:"1:0.0")!
	mut rackspace := ri.sheet.row_new(name: 'rackspace',aggregatetype:.max)!
	mut cost_power := ri.sheet.row_new(name: 'cost_power',tags:["cost"])!
	mut cost_rackspace := ri.sheet.row_new(name: 'cost_rackspace',tags:["cost"])!
	mut cost_network := ri.sheet.row_new(name: 'cost_network',tags:["cost"])!
	mut cost_hardware := ri.sheet.row_new(name: 'cost_hardware',tags:["cost"])!
	mut cost_support := ri.sheet.row_new(name: 'cost_support',tags:["cost"])!
	mut chi_price_usd := ri.sheet.row_new(name:'chi_price_usd',growth:ri.simulator.params.chi_price_usd,aggregatetype:.max)!
	mut chi_farmed_month := ri.sheet.row_new(name:'chi_farmed_month',aggregatetype:.max)!
	
	for x in 0..ri.simulator.params.nrmonths{
		for mut nb in ri.batches{
			res:=nb.calc(x)!
			nrnodes.cells[x].add(res.nrnodes)
			powerusage.cells[x].add(res.power_kwh)
			rackspace.cells[x].add(res.rackspace)
			cost_power.cells[x].add(res.power_cost)
			cost_rackspace.cells[x].add(res.rackspace_cost)
			cost_hardware.cells[x].add(res.hw_cost)
			cost_support.cells[x].add(res.support_cost)
			chi_farmed_month.cells[x].add(res.tokens_farmed)			
			if x>0{
				chi_total_tokens.cells[x].val = chi_farmed_month.cells[x].val + chi_total_tokens.cells[x-1].val
			}else{
				chi_total_tokens.cells[x].val = chi_farmed_month.cells[x].val
			}
		}
	}
	mut chi_farmed_month_node := chi_farmed_month.divide("chi_farmed_month_node",nrnodes)!
	// mut chi_total_tokens := chi_farmed_month.aggregate("chi_total_tokens")!
	
}