module tfgridsimulator

//is a template which can be used for deploying threefold nodes
//a component group describes which components make up the node template
[heap]
pub struct NodeTemplate{
pub mut:
	name string
	components []ComponentGroup
	capacity FarmingCapacity //the result for this node template
}


//as used in node template
pub struct ComponentGroup{
pub mut:
	name string
	nr	int //nr of components
	component Component
}

//is a component as used to create a node template
//see https://library.threefold.me/info/threefold/#/tfgrid/resource_units
pub struct Component{
pub mut:
	name string
	description string
	cost f64		//cost always in USD  
	rackspace f64	//expressed in U, typical rack has 44 units
	power	f64	//expressed in watt
	cru f64		//1 logical core
	mru f64		//1 GB of memory
	hru f64		//1 GB of HD
	sru f64		//1 GB of SSD
}


//a node template, holds the construction of a node as used in a grid
pub fn node_template_new(name string) NodeTemplate{
	return NodeTemplate{}
}

pub struct ComponentGroupArgs{
pub mut:
	nr	int //nr of components
	component Component
}


pub fn (mut nt NodeTemplate) components_add (cg ComponentGroupArgs){
	nt.components << ComponentGroup{
		name:cg.component.name
		nr:cg.nr
		component:cg.component
	}
	nt.calc()
}

//recalculate the totals of the template
fn (mut nt NodeTemplate) calc (){
	mut fc := FarmingCapacity{}
	for cg in nt.components{
		fc.cost += cg.component.cost * cg.nr
		fc.rackspace += cg.component.rackspace * cg.nr
		fc.power += cg.component.power * cg.nr
		fc.resourceunits.cru += cg.component.cru * cg.nr
		fc.resourceunits.mru += cg.component.mru * cg.nr
		fc.resourceunits.hru += cg.component.hru * cg.nr
		fc.resourceunits.sru += cg.component.sru * cg.nr
	}
	fc.cloudunits = cloudunits_calc(fc.resourceunits) //calculate the cloudunits
	nt.capacity = fc
}



