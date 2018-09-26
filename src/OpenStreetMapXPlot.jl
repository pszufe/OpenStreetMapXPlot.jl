module OpenStreetMapXPlot

using Plots

export plotmap, addroute! #Plotting

include("plot.jl") #plotting
include("layers.jl") #plotting
end
