
## parameters for the simulation


```js
!!environment_params_define
    //power cost per khw
    power_cost: '1:0.06,60:0.15'
    //rackspace cost per U in USD
    rackspace_cost: '1:10,60:5'

!!farming_params_define
    //nr of months lockup after adding node
    farming_lockup: 24 	
    farming_min_utilizaton: 30
	//how much will node hardware cost more (here less) over time, 2 means double, 0.5 means half
	price_increase_nodecost: '1:1,60:0.3'
    //price in USD for support cost per node per month
	support_cost_node: '1:10'

```
