

## generic node, name 1U

This is a normalized node for our simulator

Following defines the Bill of Material and composition of such a noce

```js
!!component_define name:AMD32 
    description: 'powerful amd cpu'
    cost:250.0
    //in watt
    power:70
    cru:32

!!component_define name:CASE1U 
    description: '1U rack mountable case'
    cost:150.0
    rackspace:1
    power:20

!!component_define name:MEM32
    description: 'memory 32 GB'
    cost:90.0
    power:20
    mru:32

!!component_define name:SSD1TB 
    description: 'SSD of 2 GT'
    cost:120.0
    power:5
    sru:1000

!!node_template_define name:'1U'

!!node_template_component_add name:'1U' nr:1 component:AMD32
!!node_template_component_add name:'1U' nr:1 component:CASE1U
!!node_template_component_add name:'1U' nr:4 component:MEM32
!!node_template_component_add name:'1U' nr:2 component:SSD1TB

```