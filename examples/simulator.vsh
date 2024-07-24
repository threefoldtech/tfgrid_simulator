#!/usr/bin/env -S v -n -w -enable-globals run

import tfgridsimulator as sim
import os

const testpath = os.dir(@FILE) + '/inputdata'

mut simulator := sim.new(path: testpath)!

// w:=ri.sheet.wiki()!
println(simulator)
