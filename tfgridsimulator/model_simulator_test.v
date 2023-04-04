module tfgridsimulator

// test regionalinternet_get
fn test_regionalinternet_get(){
	mut s:=Simulator{}
	mut r:=RegionalInternet{}
	r.name="test"
	s.regional_internets[r.name]=&r
	assert s.regionalinternet_get(r.name)!.name==r.name
}

// test nodetemplate_get
fn test_nodetemplate_get(){
	mut s:=Simulator{}
	mut n:=NodeTemplate{}
	n.name="test"
	s.node_templates[n.name]=&n
	assert s.nodetemplate_get(n.name)!.name==n.name
}