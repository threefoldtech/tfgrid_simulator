	
module tfgridsimulator
import freeflowuniverse.crystallib.actionsparser

//no need to change the defaults, give text or path
[params]
pub struct SimulatorInputArgs {
pub:
	text          string
	path          string // can be dir or file
	defaultdomain string = 'threefold'
	defaultbook   string = 'tfgrid'
	defaultactor  string = 'simulator'
}


//get a new simulator, define the path where the input is
//see the generic readme for examples
pub fn new(args SimulatorInputArgs)! Simulator {

	mut parser := actionsparser.new(
		text: args.text
		path: args.path
		defaultdomain: args.defaultdomain
		defaultbook: args.defaultbook
		defaultactor: args.defaultactor
	)!

	//get all the params out of the actions
	mut params:=params_new(parser)!

	mut s := Simulator{
		params:params
	}


	//NOW ADD THE NODE TEMPLATES
	actions_nt:=parser.filtersort(names_filter:["component_define","node_template_define","node_template_component_add"])!
	for action_nt in actions_nt{
		if action_nt.name=="component_define"{
			mut c_name:=action_nt.params.get_default("name","")!
			c_name=c_name.to_lower()
			mut c_description:=action_nt.params.get_default("description","")!
			mut c_cost:=action_nt.params.get_float("cost")!
			mut rackspace:=action_nt.params.get_float_default("rackspace",0)!
			mut power:=action_nt.params.get_float_default("power",0)!
			mut cru:=action_nt.params.get_float_default("cru",0)!
			mut mru:=action_nt.params.get_float_default("mru",0)!
			mut hru:=action_nt.params.get_float_default("hru",0)!
			mut sru:=action_nt.params.get_float_default("sru",0)!			
			mut component:=Component{
				name:c_name
				description:c_description
				cost:c_cost
				rackspace:rackspace
				power:power
				cru:cru
				mru:mru
				hru:hru
				sru:sru
			}
			s.components[c_name]=&component
		}
		if action_nt.name=="node_template_define"{
			mut nt_name:=action_nt.params.get("name")!
			nt_name=nt_name.to_lower()
			mut node_template:=node_template_new(nt_name)
			s.node_templates[nt_name]=&node_template
		}
		if action_nt.name=="node_template_component_add"{
			mut comp_templ_name:=action_nt.params.get("name")!
			mut comp_name:=action_nt.params.get("component")!
			mut comp_nr:=action_nt.params.get_int("nr")!
			comp_templ_name=comp_templ_name.to_lower()
			comp_name=comp_name.to_lower()
			mut node_template:=s.node_templates[comp_templ_name] or {return error("Cannot find node template: '$comp_templ_name', has it been defined?")}
			component:=s.components[comp_name] or {return error("Cannot find component: '$comp_name', has it been defined?")}
			node_template.components_add(nr:comp_nr,component:component)
		}
	}

	//NOW ADD THE REGIONAL INTERNETS
	actions_ri:=parser.filtersort(names_filter:["regional_internet_add","regional_internet_nodes_add"])!
	for action_ri in actions_ri{

		if action_ri.name=="regional_internet_add"{
			mut iname:=action_ri.params.get("name")!
			s.regionalinternet_add(iname)!
		}
		if action_ri.name=="regional_internet_nodes_add"{
			mut ri_name:=action_ri.params.get("name")!
			mut ri_template:=action_ri.params.get("template")!
			mut ri_t_growth:=action_ri.params.get("growth")!
			mut ri0:=s.regionalinternet_get(ri_name)!
			mut template:=s.nodetemplate_get(ri_template)!
			ri0.nodes_add(template:template,growth:ri_t_growth)!	
		}	
	}

	for _,mut ri in s.regional_internets{
		ri.calc()!
	}


	println(s)
	// if true{panic("sdsd")}
	return s
}
