module main
import tfgridsimulator as sim
import os

const testpath = os.dir(@FILE) + '/inputdata'

fn do()!{

	mut simulator := sim.new(path:testpath)!

	// w:=ri.sheet.wiki()!
	println(simulator)

}

fn main(){
	do() or {panic(err)}
}