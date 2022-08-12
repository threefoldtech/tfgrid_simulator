	
	
module tfgridsimulator


//extrapolate years
//eg growth [0,1,2,4,10], would give us 4 years starting from 0 going to 10
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

pub fn extrapolate_int(vals []int) []int{
	vals2 := extrapolate(array2float(vals))
	return array2int(vals2)
}

//will grow following a curve and then shows how per month we need to grow
pub fn extrapolate_growth(vals []int) []int{
	mut prev := 0 
	mut res := []int
	mut additional := 0 
	for i in extrapolate_int(vals){
		if i>prev{
			additional = i - prev
			prev = i
			res << additional
		}else{
			res << 0
		}
	}
	return res
}



pub fn array2float(list []int) []f64{
	mut list2 := []f64
	for i in list{
		list2 << f64(i)
	}
	return list2
}

pub fn array2int(list []f64) []int{
	mut list2 := []int
	for i in list{
		list2 << int(i)
	}
	return list2
}


// //add X months to the input
// pub fn extrapolate_addmonths(growth []f64, nrmonthts int) []f64{
// 	mut months := []f64{}
// 	mut growth2 := growth.clone()
// 	for _ in 1..growth.len{
// 		growth2 << growth[growth.len-1]
// 	}
// 	for year in 1..growth2.len{
// 		val_start := growth2[year-1]
// 		val_end := growth2[year]
// 		increment := (val_end-val_start)/11
// 		for m in 0..12{
// 			months << val_start+increment * m
// 		}
// 	}
// 	return months
// }
