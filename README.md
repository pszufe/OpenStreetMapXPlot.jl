# OpenStreetMapXPlot.jl
This is a complete re-write of OpenStreetMap.jl package - plotting module.  

Compared to the original package this module uses `Plots.jl` with GR is used as backend for map vizualization. 



## Installation

The current version uses Julia 1.0.0

```julia
using Pkg
Pkg.add(PackageSpec(url="https://github.com/pszufe/OpenStreetMapX.jl"))
Pkg.add(PackageSpec(url="https://github.com/pszufe/OpenStreetMapXPlot.jl"))
```



## Usage

```julia
using OpenStreetMapX, OpenStreetMapXPlot
map_data = OpenStreetMapX.get_map_data("/home/ubuntu/", "mymap.osm");

p = OpenStreetMapX.plotmap(map_data.nodes, OpenStreetMapX.ENU(map_data.bounds), roadways=map_data.roadways,roadwayStyle = OpenStreetMapX.LAYER_STANDARD, width=600, height=600)
```

See the `samples` directory for a more complete example.  



**Any push requests are welcome!**
