module tfgridsimulator

pub struct RegionalInternet{
pub mut:
	nr i16
	name string
	location Location
	months []NodesBatch
	params SimulatorParams
	tokenprice  []f32
	growth  []f32
}


pub struct Location{
pub mut:
	name string
	//TODO need to add regional coordinates
}


pub fn regionalinternet_new(nr i16, params SimulatorParams)?RegionalInternet{
	mut ri := RegionalInternet{
		nr:nr
		params:params
	}
	ri.calc()?
	return ri
}

//calculate how a regional internet will expand in relation to the arguments given
pub fn (mut ri RegionalInternet) calc()?{


}