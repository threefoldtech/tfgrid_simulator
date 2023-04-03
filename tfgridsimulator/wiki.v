	
	
module tfgridsimulator

import freeflowuniverse.crystallib.pathlib

pub fn (mut sim Simulator) wiki() !{

	mut p:=pathlib.get_dir(sim.params.wiki_path,true)!

	for _,mut nt in sim.node_templates{
		//get file inside the dir
		p.file_get_new("node_template_${nt.name}.md")!
		c:=$tmpl('templates/node.md')
		p.write(c)!
	}

}
