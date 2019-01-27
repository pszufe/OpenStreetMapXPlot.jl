using Documenter

try
    using OpenStreetMapXPlot
catch
    if !("../src/" in LOAD_PATH)
       push!(LOAD_PATH,"../src/")
       @info "Added \"../src/\"to the path: $LOAD_PATH "
       using OpenStreetMapXPlot
    end
end

makedocs(
    sitename = "OpenStreetMapXPlot",
    format = format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    modules = [OpenStreetMapXPlot],
    pages = ["index.md", "reference.md"],
    doctest = true
)



deploydocs(
    repo ="github.com/pszufe/OpenStreetMapXPlot.jl.git",
    target="build"
)
