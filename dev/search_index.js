var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "OpenStreetMapXPlot.jl",
    "title": "OpenStreetMapXPlot.jl",
    "category": "page",
    "text": ""
},

{
    "location": "#OpenStreetMapXPlot.jl-1",
    "page": "OpenStreetMapXPlot.jl",
    "title": "OpenStreetMapXPlot.jl",
    "category": "section",
    "text": "Documentation for OpenStreetMapXPlot.jlFor details please go to the Reference section."
},

{
    "location": "reference/#",
    "page": "Reference",
    "title": "Reference",
    "category": "page",
    "text": ""
},

{
    "location": "reference/#Reference-1",
    "page": "Reference",
    "title": "Reference",
    "category": "section",
    "text": "CurrentModule = OpenStreetMapXPlot\nDocTestSetup = quote\n    using OpenStreetMapXPlot\nend"
},

{
    "location": "reference/#OpenStreetMapXPlot.plotmap",
    "page": "Reference",
    "title": "OpenStreetMapXPlot.plotmap",
    "category": "function",
    "text": "plotmap(nodes::Dict{Int,T},\n             bounds::Union{Nothing,OpenStreetMapX.Bounds{T}} = nothing;\n             buildings::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,\n             buildingStyle::Styles=OpenStreetMapXPlot.Style(\"0x000000\", 1, \"-\"),\n             roadways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,\n             roadwayStyle::Styles=OpenStreetMapXPlot.Style(\"0x007CFF\", 1.5, \"-\"),\n             walkways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,\n             walkwayStyle::Styles=OpenStreetMapXPlot.Style(\"0x007CFF\", 1.5, \"-\"),\n             cycleways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,\n             cyclewayStyle::Styles=OpenStreetMapXPlot.Style(\"0x007CFF\", 1.5, \"-\"),\n             features::Union{Nothing,Dict{Int64,Tuple{String,String}}} = nothing,\n             featureStyle::Styles=OpenStreetMapXPlot.Style(\"0xCC0000\", 2.5, \".\"),\n             width::Int=600,\n             height::Int=600,\n             fontsize::Integer=0,\n             km::Bool=false, \n			 use_plain_pyplot=false\n			 ) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}\n\nPlots selected map features for a given dictionary of node locations (nodes) and within the given bounds. \n\nThe default plotting backend is Plots.jl, however if the use_plain_pyplot  is set to true than PyPlot.jl is used  (note that due to PyPlot\'s performance this setting should be used for maps up to few thousands nodes). \n\nReturns an object that can be used for further plot updates.\n\n\n\n\n\nplotmap(m::OpenStreetMapX.MapData;\n    roadwayStyle = OpenStreetMapXPlot.LAYER_STANDARD, \n    width=600, height=600, use_plain_pyplot=false)\n\nPlots roadways for a given map m.\n\nThe width will be set to width and the height will be set to height.\n\nThe default plotting backend is Plots.jl, however if the use_plain_pyplot  is set to true than PyPlot.jl is used  (note that due to PyPlot\'s performance this setting should be used for maps up to few thousands nodes). \n\nReturns an object that can be used for further plot updates.\n\n\n\n\n\n"
},

{
    "location": "reference/#OpenStreetMapXPlot.addroute!",
    "page": "Reference",
    "title": "OpenStreetMapXPlot.addroute!",
    "category": "function",
    "text": "addroute!(p, nodes::Dict{Int,T},\n               route::Vector{Int}; \n               route_color::String =\"0x000053\",\n               km::Bool=false, \n               start_name=\"A\", end_name=\"B\", \n               fontsize=15\n               ) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}\n\nAdds a route to the plot p using the node information stored in nodes.\n\nThe first element from the list of nodes route will be annoted by start_name  while the last will be annotated by end_name.\n\nReturns an object that can be used for further plot updates.\n\n\n\n\n\n"
},

{
    "location": "reference/#OpenStreetMapXPlot.plot_nodes!",
    "page": "Reference",
    "title": "OpenStreetMapXPlot.plot_nodes!",
    "category": "function",
    "text": "plot_nodes!(p, m::OpenStreetMapX.MapData, \n    nodeids::Vector{Int};\n    start_numbering_from::Union{Int,Nothing}=1, \n    km::Bool=false, \n    color=\"darkgreen\", \n    fontsize=10\n    ) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}\n\nPlots nodes having node identifiers nodeids on the plot p using map information m. By default the node indices within the are plotted (e.g. 1, 2, 3...), however, setting the parameter start_numbering_from to nothing will show actual OSM node identifiers. \n\nReturns an object that can be used for further plot updates.\n\n\n\n\n\n"
},

{
    "location": "reference/#Map-plotting-functions-1",
    "page": "Reference",
    "title": "Map plotting functions",
    "category": "section",
    "text": "plotmap\naddroute!\nplot_nodes!DocTestSetup = nothing"
},

]}
