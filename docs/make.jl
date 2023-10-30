using Documenter
using Pkg

if isfile("src/OpenStreetMapXPlot.jl")
    if !("." in LOAD_PATH)
        push!(LOAD_PATH,".")
    end
elseif isfile("../src/OpenStreetMapXPlot.jl")
    if !(".." in LOAD_PATH)
	   push!(LOAD_PATH,"..")
    end
end

using OpenStreetMapXPlot


println("Generating docs for module\n$(pathof(OpenStreetMapXPlot))")

makedocs(
    sitename = "OpenStreetMapXPlot",
    format = format = Documenter.HTML(),
    modules = [OpenStreetMapXPlot],
    pages = ["index.md", "reference.md"],
    checkdocs = :exports,
    doctest = true
)

deploydocs(
    repo ="github.com/pszufe/OpenStreetMapXPlot.jl.git",
    target="build"
)
