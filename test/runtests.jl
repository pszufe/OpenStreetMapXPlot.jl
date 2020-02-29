println("Running tests at $(pwd())")
 
using Test, OpenStreetMapX

const m = OpenStreetMapX.get_map_data("data/reno_east3.osm",use_cache=false);

using Random
Random.seed!(0);
const pointA = point_to_nodes(generate_point_in_bounds(m), m)
const pointB = point_to_nodes(generate_point_in_bounds(m), m)

sr1, shortest_distance1, shortest_time1 = OpenStreetMapX.shortest_route(m, pointA, pointB)
@assert length(sr1) > 0

ENV["PLOTS_TEST"] = "true" #copied from Plots.jl tests
ENV["GKSwstype"] = "100" #copied from Plots.jl tests
ENV["MPLBACKEND"]="agg" # no GUI - copied from PyPlot.jl tests

using OpenStreetMapXPlot
println("OpenStreetMapXPlot is located at $(pathof(OpenStreetMapXPlot))")


import Plots
Plots.gr()
Plots.default(show=false, reuse=true)

const trk = [LLA(m.bounds.min_y,m.bounds.min_x,0.0), LLA(m.bounds.max_y,m.bounds.max_x,0.0)]


@testset "Plots backend " begin
	p = OpenStreetMapXPlot.plotmap(m)
	@test typeof(p) == Plots.Plot{Plots.GRBackend}
	@test addroute!(p,m,sr1;route_color="red") == p
	@test plot_nodes!(p,m,[sr1[1],sr1[end]],start_numbering_from=nothing,fontsize=13,color="pink") == p
	@test addroute!(p,m,trk;route_color="red") == p
end

@testset "PyPlot backend" begin
	p=OpenStreetMapXPlot.plotmap(m,use_plain_pyplot=true)
	@test p == :osm_use_pyplot
	@test addroute!(p,m,sr1;route_color="red") == p
	@test plot_nodes!(p,m,[sr1[1],sr1[end]],start_numbering_from=nothing,fontsize=13,color="pink") == p
	@test addroute!(p,m,trk;route_color="red") == p
end