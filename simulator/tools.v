	
	
module simulator



pub fn extrapolate(growth []f64) []f64{
	mut months := []f64{}
	for year in 1..growth.len{
		val_start := growth[year-1]
		val_end := growth[year]
		increment := (val_end-val_start)/11
		for m in 0..12{
			months << val_start+increment * m
		}
	}
	return months
}

//add X months to the input
pub fn extrapolate_addmonths(growth []f64, nrmonthts int) []f64{
	mut months := []f64{}
	mut growth2 := growth.clone()
	for _ in 1..growth.len{
		growth2 << growth[growth.len-1]
	}
	for year in 1..growth2.len{
		val_start := growth2[year-1]
		val_end := growth2[year]
		increment := (val_end-val_start)/11
		for m in 0..12{
			months << val_start+increment * m
		}
	}
	return months
}
