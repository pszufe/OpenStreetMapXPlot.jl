###
# Functions for with Plots.jl Packages
###

"""
	struct Style{T}
		color::T
		width::Float64
		spec::String
	end


For most cases you will use constructor declared as:
```julia
Style(col, width, spec="-")
```

"""
struct Style{T}
    color::T
    width::Float64
    spec::String
end

Style(col::T, width::Int, spec) where T= Style{T}(col, Float64(width), spec)
Style(col::T, width) where T = Style{T}(col, Float64(width), "-")

const Styles{T} = Union{OpenStreetMapXPlot.Style{T},Dict{Int,OpenStreetMapXPlot.Style{T}}} where T

const gr_linestyles = Dict("-" => :solid, ":"=>:dot, ";"=>:dashdot, "-."=>:dashdot,"--"=>:dash)

"""
Compute approximate "aspect ratio" at mean latitude
"""
function aspect_ratio(bounds::OpenStreetMapX.Bounds{OpenStreetMapX.LLA})
    c_adj = cosd((bounds.min_y + bounds.max_y) / 2)
    range_y = bounds.max_y - bounds.min_y
    range_x = bounds.max_x - bounds.min_x
    return range_x * c_adj / range_y
end

"""
Compute exact "aspect ratio"
"""
aspect_ratio(bounds::OpenStreetMapX.Bounds{OpenStreetMapX.ENU}) =
    (bounds.max_x - bounds.min_x) / (bounds.max_y - bounds.min_y)

"""
Draw Ways without defined layers
"""
function draw_ways!(p,nodes::Dict{Int,T}, ways::Vector{OpenStreetMapX.Way},
                    style::OpenStreetMapXPlot.Styles,
                    km::Bool) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    for way in ways
        X = [OpenStreetMapX.getX(nodes[node]) for node in way.nodes]
        Y = [OpenStreetMapX.getY(nodes[node]) for node in way.nodes]
        if isa(nodes,Dict{Int,OpenStreetMapX.ENU}) && km
            X /= 1000
            Y /= 1000
        end
        if length(X) > 1
                Plots.plot!(p, X, Y, color=style.color,width=style.width,
                                     linestyle=gr_linestyles[style.spec])
        end
    end
end

"""
Draw Ways with defined Layers
"""
function draw_ways!(p,nodes::Dict{Int,T}, ways::Vector{OpenStreetMapX.Way},
                    class::Dict{Int,Int}, style::OpenStreetMapXPlot.Styles,
                    km::Bool) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    for i = 1:length(ways)
        lineStyle = style[class[ways[i].id]]
        X = [OpenStreetMapX.getX(nodes[node]) for node in ways[i].nodes]
        Y = [OpenStreetMapX.getY(nodes[node]) for node in ways[i].nodes]
        if isa(nodes,Dict{Int,OpenStreetMapX.ENU}) && km
            X /= 1000
            Y /= 1000
        end
        if length(X) > 1
            Plots.plot!(p, X, Y, color=lineStyle.color,width=lineStyle.width,
                            linestyle=gr_linestyles[lineStyle.spec])
        end
    end
end

"""
Draw Buildings
"""
function draw_buildings!(p,nodes::Dict{Int,T},
                         buildings::Vector{OpenStreetMapX.Way}, style::OpenStreetMapXPlot.Styles,
                         km::Bool) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    if isa(style, OpenStreetMapXPlot.Style)
        OpenStreetMapXPlot.draw_ways!(p,nodes,buildings,style,km)
    else
        classes = OpenStreetMapX.classify_buildings(buildings)
        OpenStreetMapXPlot.draw_ways!(p,nodes,buildings, classes, style,km)
    end
end

"""
Draw Roadways
"""
function draw_roadways!(p,nodes::Dict{Int,T},
                        roadways::Vector{OpenStreetMapX.Way}, style::OpenStreetMapXPlot.Styles,
                        km::Bool) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    if isa(style, OpenStreetMapXPlot.Style)
        OpenStreetMapXPlot.draw_ways!(p,nodes,roadways,style,km)
    else
        classes = OpenStreetMapX.classify_roadways(roadways)
        OpenStreetMapXPlot.draw_ways!(p,nodes,roadways, classes, style,km)
    end
end

"""
Draw Walkways
"""
function draw_walkways!(p,nodes::Dict{Int,T},
                        walkways::Vector{OpenStreetMapX.Way}, style::OpenStreetMapXPlot.Styles,
                        km::Bool) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    if isa(style, OpenStreetMapXPlot.Style)
        OpenStreetMapXPlot.draw_ways!(p,nodes,walkways,style,km)
    else
        classes = OpenStreetMapX.classify_walkways(walkways)
        OpenStreetMapXPlot.draw_ways!(p,nodes,walkways, classes, style,km)
    end
end

"""
Draw Cycleways
"""
function draw_cycleways!(p,nodes::Dict{Int,T},
                         cycleways::Vector{OpenStreetMapX.Way}, style::OpenStreetMapXPlot.Styles,
                         km::Bool) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    if isa(style, OpenStreetMapXPlot.Style)
        OpenStreetMapXPlot.draw_ways!(p,nodes,cycleways,style,km)
    else
        classes = OpenStreetMapX.classify_cycleways(cycleways)
        OpenStreetMapXPlot.draw_ways!(p,nodes,cycleways, classes, style,km)
    end
end

"""
Draw Features
"""
function draw_features!(p,nodes::Dict{Int,T},
                        features::Dict{Int,Tuple{String,String}}, style::OpenStreetMapXPlot.Styles,
                        km::Bool) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    if isa(style, OpenStreetMapXPlot.Style)
        X = [OpenStreetMapX.getX(nodes[node]) for node in keys(features)]
        Y = [OpenStreetMapX.getY(nodes[node]) for node in keys(features)]
        if isa(nodes,Dict{Int,OpenStreetMapX.ENU}) && km
                X /= 1000
                Y /= 1000
        end
        if length(X) > 1
            Plots.plot!(p, X, Y, color=style.color,width=style.width,
                                linestyle=gr_linestyles[style.spec])
        end
    else
        classes = OpenStreetMapX.classify_features(features)
        for (key,val) in style
            indices = [id for id in keys(classes) if classes[id] == key]
            X = [OpenStreetMapX.getX(nodes[node]) for node in indices]
            Y = [OpenStreetMapX.getY(nodes[node]) for node in indices]
            if isa(nodes,Dict{Int,OpenStreetMapX.ENU}) && km
                X /= 1000
                Y /= 1000
            end
            if length(X) > 1
                Plots.plot!(p, X, Y, color=val.color,width=val.width,
                                     linestyle=gr_linestyles[val.spec])
            end
        end
    end
end

"""
    plotmap(nodes::Dict{Int,T},
                 bounds::Union{Nothing,OpenStreetMapX.Bounds{T}} = nothing;
                 buildings::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,
                 buildingStyle::Styles=OpenStreetMapXPlot.Style("0x000000", 1, "-"),
                 roadways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,
                 roadwayStyle::Styles=OpenStreetMapXPlot.Style("0x007CFF", 1.5, "-"),
                 walkways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,
                 walkwayStyle::Styles=OpenStreetMapXPlot.Style("0x007CFF", 1.5, "-"),
                 cycleways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,
                 cyclewayStyle::Styles=OpenStreetMapXPlot.Style("0x007CFF", 1.5, "-"),
                 features::Union{Nothing,Dict{Int64,Tuple{String,String}}} = nothing,
                 featureStyle::Styles=OpenStreetMapXPlot.Style("0xCC0000", 2.5, "."),
                 width::Integer=600,
                 height::Integer=600,
                 fontsize::Integer=0,
                 km::Bool=false,
				 use_plain_pyplot::Bool=false
				 ) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}

Plots selected map features for a given dictionary of node locations (`nodes`)
and within the given `bounds`.
The `km` parameter can be used to have a kilometer scale of the map instead of meters.


The default plotting backend is whatever is defined in `Plots.jl`, however if the `use_plain_pyplot`
is set to `true` Plots.pythonplot() will be called to switch to PythonPlot backend
(note this option is depraciated and normally backend should be changed outside of this function).


Returns an object that can be used for further plot updates.
"""
function plotmap(nodes::Dict{Int,T},
                 bounds::Union{Nothing,OpenStreetMapX.Bounds{T}} = nothing;
                 buildings::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,
                 buildingStyle::Styles=OpenStreetMapXPlot.Style("0x000000", 1, "-"),
                 roadways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,
                 roadwayStyle::Styles=OpenStreetMapXPlot.Style("0x007CFF", 1.5, "-"),
                 walkways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,
                 walkwayStyle::Styles=OpenStreetMapXPlot.Style("0x007CFF", 1.5, "-"),
                 cycleways::Union{Nothing,Vector{OpenStreetMapX.Way}} = nothing,
                 cyclewayStyle::Styles=OpenStreetMapXPlot.Style("0x007CFF", 1.5, "-"),
                 features::Union{Nothing,Dict{Int64,Tuple{String,String}}} = nothing,
                 featureStyle::Styles=OpenStreetMapXPlot.Style("0xCC0000", 2.5, "."),
                 width::Integer=600,
                 height::Integer=600,
                 fontsize::Integer=0,
                 km::Bool=false, use_plain_pyplot::Bool=false
                 ) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    if use_plain_pyplot && !any(contains.(string(Plots.backend()), ["Python", "PyPlot"]))
        @warn "Will now call Plots.pythonplot() to switch to PythonPlot backend"
        Plots.pythonplot()
    end
    # Chose labels according to point type and scale
    xlab, ylab = if isa(nodes, Dict{Int,OpenStreetMapX.LLA})
        "Longitude (deg)", "Latitude (deg)"
    elseif km
        "East (km)", "North (km)"
    else
        "East (m)", "North (m)"
    end

    local p
    if isa(bounds,Nothing)
        p = Plots.plot(xlabel=xlab,ylabel=ylab,legend=false,size=(width,height))
    else # Limit plot to specified bounds
        if km && isa(nodes, Dict{Int,OpenStreetMapX.ENU})
            xrange = (bounds.min_x/1000, bounds.max_x/1000)
            yrange = (bounds.min_y/1000, bounds.max_y/1000)
        else
            xrange = (bounds.min_x, bounds.max_x)
            yrange = (bounds.min_y, bounds.max_y)
        end
        p = Plots.plot(xlabel=xlab,ylabel=ylab,xlims=xrange,ylims=yrange,legend=false,size=(width,height))
    end
    # Draw all buildings
    if !isa(buildings,Nothing)
        OpenStreetMapXPlot.draw_buildings!(p,nodes, buildings, buildingStyle, km)
    end
    # Draw all roadways
    if !isa(roadways,Nothing)
        OpenStreetMapXPlot.draw_roadways!(p,nodes, roadways, roadwayStyle, km)
    end
    # Draw all walkways
    if !isa(walkways,Nothing)
        OpenStreetMapXPlot.draw_walkways!(p,nodes, walkways, walkwayStyle, km)
    end
    # Draw all cycleways
    if !isa(cycleways,Nothing)
        OpenStreetMapXPlot.draw_cycleways!(p,nodes, cycleways, cyclewayStyle, km)
    end
    #Draw all features
    if !isa(features,Nothing)
        OpenStreetMapXPlot.draw_features!(p,nodes, features, featureStyle, km)
    end
    if fontsize > 0
        attr = Dict(:fontsize => fontsize)
    end
    return p
end

"""
    plotmap(m::OpenStreetMapX.MapData;
        roadwayStyle = OpenStreetMapXPlot.LAYER_STANDARD,
        width::Integer=600, height::Integer=600, use_plain_pyplot::Bool=false)

Plots `roadways` for a given map `m`.

The width will be set to `width` and the height will be set to `height`. If only one of `width`
or `height` is set, the other will be set to perserve the aspect ratio of the bounding box.
The `km` parameter can be used to have a kilometer scale of the map instead of meters.

The default plotting backend is whatever is defined in `Plots.jl`, however if the `use_plain_pyplot`
is set to `true` Plots.pythonplot() will be called to switch to PythonPlot backend
(note this option is depraciated and normally backend should be changed outside of this function).

Returns an object that can be used for further plot updates.

"""
function plotmap(m::OpenStreetMapX.MapData;roadwayStyle = OpenStreetMapXPlot.LAYER_STANDARD,
	         width::Union{Integer,Nothing}=nothing, height::Union{Integer,Nothing}=nothing, km::Bool=false, use_plain_pyplot::Bool=false)

    # Set plot aspect ratio to that of bounds (in meters), unless both height and width are specified
    if isnothing(width) || isnothing(height)
        # Compute aspect ratio
        aspect_ratio = OpenStreetMapXPlot.aspect_ratio(m.bounds)

        if isnothing(width) && isnothing(height)
            width = 600
            height = Int(round(width/aspect_ratio))
        elseif isnothing(height)
            height = Int(round(width/aspect_ratio))
        elseif isnothing(width)
            width = Int(round(height*aspect_ratio))
        end
    end

    plotmap(m.nodes, OpenStreetMapX.ENU(m.bounds), roadways=m.roadways,roadwayStyle = roadwayStyle,
            width=width, height=height, km=km, use_plain_pyplot=use_plain_pyplot)
end

"""
    plotmap(m::OpenStreetMapX.Mapaddroute!(p, m::OpenStreetMapX.MapData,
                   route::Vector{Int}; route_color::Union{String, Plots.RGB} ="0x000053",
                   km::Bool=false)

Adds a `route` to the plot `p` representing the map `m`.

The first element from the list of nodes `route` will be annoted by `start_name`
while the last will be annotated by `end_name`.
The `km` parameter can be used to have a kilometer scale of the map instead of meters.

Returns an object that can be used for further plot updates.

"""

function addroute!(p, m::OpenStreetMapX.MapData,
                   route::Vector{Int}; route_color::Union{String, Plots.RGB} ="0x000053",
                   km::Bool=false, start_name="A", end_name="B", fontsize=15)
    addroute!(p, m.nodes, route, route_color=route_color, km=km, start_name=start_name, end_name=end_name, fontsize=fontsize)
end

"""
    addroute!(p, nodes::Dict{Int,T},
                   route::Vector{Int};
                   route_color::Union{String, Plots.RGB} ="0x000053",
                   km::Bool=false,
                   start_name="A", end_name="B",
                   fontsize=15
                   ) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}

Adds a `route` to the plot `p` using the node information stored in `nodes`.

The first element from the list of nodes `route` will be annoted by `start_name`
while the last will be annotated by `end_name`.
The `km` parameter can be used to have a kilometer scale of the map instead of meters.

Returns an object that can be used for further plot updates.

"""
function addroute!(p, nodes::Dict{Int,T},
                   route::Vector{Int}; route_color::Union{String, Plots.RGB} ="0x000053",
                   km::Bool=false, start_name="A", end_name="B", fontsize=15) where T<:Union{OpenStreetMapX.LLA,OpenStreetMapX.ENU}
    route_style = OpenStreetMapXPlot.Style(route_color, 3, "--")
    X = [OpenStreetMapX.getX(nodes[node]) for node in route]
    Y = [OpenStreetMapX.getY(nodes[node]) for node in route]
    if isa(nodes,Dict{Int,OpenStreetMapX.ENU}) && km
        X /= 1000
        Y /= 1000
    end
    #length(X) > 1 && Winston.plot(p, X, Y, route_style.spec, color=route_style.color, linewidth=route_style.width)
    if length(X) > 1
        Plots.plot!(p, X, Y, color=route_style.color,width=route_style.width,linestyle=gr_linestyles[route_style.spec])
        Plots.annotate!(p,X[1],Y[1],Plots.text(start_name,fontsize))
        Plots.annotate!(p,X[end],Y[end],Plots.text(end_name,fontsize))
    end
    p
end

"""
    addroute!(p, m::OpenStreetMapX.MapData,
                   route::Vector{OpenStreetMapX.LLA};
                   route_color::Union{String, Plots.RGB} ="0x000053",
                   km::Bool=false,
                   start_name="A", end_name="B",
                   fontsize=15
                   )

Adds a `route` in LLA coordinates to the plot `p` representing the map `m`.

The first element from the list of route coordinates `route` will be annoted by `start_name`
while the last will be annotated by `end_name`.
The `km` parameter can be used to have a kilometer scale of the map instead of meters.


Returns an object that can be used for further plot updates.

"""
function addroute!(p, m::OpenStreetMapX.MapData,
                   route::Vector{OpenStreetMapX.LLA}; route_color::Union{String, Plots.RGB} ="0x000053",
                   km::Bool=false, start_name="A", end_name="B", fontsize=15)
    route_style = OpenStreetMapXPlot.Style(route_color, 3, "--")
    routeENU = [ENU(lla, m.bounds) for lla in route]
    X = map(enu->enu.east, routeENU)
    Y = map(enu->enu.north, routeENU)
    if km
        X /= 1000
        Y /= 1000
    end
    if length(X) > 1
        Plots.plot!(p, X, Y, color=route_style.color,width=route_style.width,linestyle=gr_linestyles[route_style.spec])
        Plots.annotate!(p,X[1],Y[1],Plots.text(start_name,fontsize))
        Plots.annotate!(p,X[end],Y[end],Plots.text(end_name,fontsize))
    end
    p
end

"""
    plot_nodes!(p, m::OpenStreetMapX.MapData,
        nodeids::Vector{Int};
        start_numbering_from::Union{Int,Nothing}=1,
        km::Bool=false,
        color="darkgreen",
        fontsize=10)

Plots nodes having node identifiers `nodeids` on the plot `p` using map information `m`.
By default the node indices within the are plotted (e.g. 1, 2, 3...), however,
setting the parameter `start_numbering_from` to nothing will show actual OSM node identifiers.
The `km` parameter can be used to have a kilometer scale of the map instead of meters.

Returns an object that can be used for further plot updates.
"""
function plot_nodes!(p,m::OpenStreetMapX.MapData,nodeids::Vector{Int};
		start_numbering_from ::Union{Int,Nothing}=1, km::Bool=false, color="darkgreen", fontsize=10)
    (length(nodeids) == 0) && return
    divkm = (isa(m.nodes[nodeids[1]],OpenStreetMapX.ENU) && km) ? 1000.0 : 1.0
    for i in 1:length(nodeids)
        X = OpenStreetMapX.getX(m.nodes[nodeids[i]]) / divkm
        Y = OpenStreetMapX.getY(m.nodes[nodeids[i]]) / divkm
        num = string(start_numbering_from == nothing ? nodeids[i] : (i-1+start_numbering_from))
        Plots.annotate!(p,X,Y,Plots.text(num,fontsize,color))
   end
   p
end
"""
    plot_nodes_as_symbols!(p, m::OpenStreetMapX.MapData,
        nodeids::Vector{Int};
        symbols::Union{T, Vector{T}}="*",
        colors::Union{U,Vector{U}}=["darkgreen"],
        km::Bool=false, fontsize=10)
            where {T <: Union{String,Symbol}, U <: Union{String,Plots.RGB}}

Plots nodes having node identifiers `nodeids` on the plot `p` using map information `m`.
By default the nodes are plotted with the "*" symbol, however,
setting the parameter `symbols` to a string will plot all node locations as that string.
Setting `symbols` to an array of strings will plot each successive location as the symbol
in that position of the array, repeating over the string array if the `symbols` array
is shorter than the `nodeids` array.
The `km` parameter can be used to have a kilometer scale of the map instead of meters.

Returns an object that can be used for further plot updates.
"""

function plot_nodes_as_symbols!(p,m::OpenStreetMapX.MapData,nodeids::Vector{Int};
		                symbols::Union{T, Vector{T}}="*",
                                colors::Union{U,Vector{U}}=["darkgreen"],
                                km::Bool=false, fontsize=10) where {T <: Union{String,Symbol}, U <: Union{String,Plots.RGB}}
    (length(nodeids) == 0) && return
    divkm = (isa(m.nodes[nodeids[1]],OpenStreetMapX.ENU) && km) ? 1000.0 : 1.0
    symbols = typeof(symbols)<:AbstractVector ? symbols : [symbols]
    colors = typeof(colors)<:AbstractVector ? colors : [colors]
    for i in 1:length(nodeids)
        X = OpenStreetMapX.getX(m.nodes[nodeids[i]]) / divkm
        Y = OpenStreetMapX.getY(m.nodes[nodeids[i]]) / divkm
        j = (i-1)%length(symbols) + 1
        k = (i-1)%length(colors) + 1
        Plots.annotate!(p,X,Y,Plots.text(symbols[j],fontsize,colors[k]))
    end
   p
end
