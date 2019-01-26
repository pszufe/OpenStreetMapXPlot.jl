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
    format = Documenter.HTML(),
    modules = [OpenStreetMapXPlot],
	pages = ["index.md", "reference.md"],
	doctest = true
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo ="github.com/pszufe/OpenStreetMapXPlot.jl.git",
	target="build"

)=#
