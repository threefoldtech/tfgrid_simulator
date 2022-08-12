module tfgridsimulator
import freeflowuniverse.crystallib.texttools

pub struct Currencies{
pub mut:
	currencies []Currency
	
}

pub struct Cost{
	currency Currency
	price f64
}

pub struct Currency{
pub mut:
	symbol string	
	usdprice f64
}

pub fn currencies_new() Currencies{
	mut c:= Currencies{}
	c.currency_new(symbol:"usd",usdprice:1)or {panic(err)}
	return c
}

pub fn (mut c Currencies) usd(price f64) Cost{
	return Cost{
		currency:c.currencies[0]
		price:price
	}
}


pub fn (mut c Currencies) add(costs ... Cost) Cost{
	mut usd := 0.0
	for cost in costs{
		usd += cost.usd()
	}
	return c.usd(usd)
}



pub fn (cost Cost) usd() f64 {
	return cost.price / cost.currency.usdprice
}


pub fn (mut c Currencies) currency_new(arg Currency)?{
	s := texttools.name_fix(arg.symbol)
	for cur in c.currencies{
		if cur.symbol == s {
			return error("cannot add currency $arg because alredy in the currencies table.")
		}
	}
	c.currencies << Currency{symbol:s,usdprice:arg.usdprice}
	
}