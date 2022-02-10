module OpenStreetMapXPlot

using OpenStreetMapX

import Plots
import PyPlot 

export plotmap, addroute!, plot_nodes!, plot_nodes_as_symbols! #Plotting

include("plot.jl") #plotting
include("layers.jl") #colors

end #module
