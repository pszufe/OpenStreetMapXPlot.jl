module OpenStreetMapXPlot

using OpenStreetMapX

import Plots
import PyPlot 

export plotmap, addroute!, plot_nodes! #Plotting

include("plot.jl") #plotting
include("layers.jl") #plotting

end #module
