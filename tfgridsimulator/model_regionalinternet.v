module tfgridsimulator

pub struct RegionalInternet{
pub mut:
	nr i16
	name string
	location Location
	months []NodesBatch
	simulator &Simulator
	tokenprice  []f32
	growth  []f32
}


pub struct Location{
pub mut:
	name string
	//TODO need to add regional coordinates
}


pub fn (mut sim Simulator) (nr int)?RegionalInternet{
	mut ri := RegionalInternet{
		nr:nr
		simulator:&sim
	}
	ri.calc()?
	return ri
}

//calculate how a regional internet will expand in relation to the arguments given
pub fn (mut ri RegionalInternet) calc()?{

	
}