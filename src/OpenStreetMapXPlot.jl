module OpenStreetMapXPlot

using Plots
using OpenStreetMapX

export plotmap, addroute! #Plotting

include("plot.jl") #plotting
include("layers.jl") #plotting

end #module
