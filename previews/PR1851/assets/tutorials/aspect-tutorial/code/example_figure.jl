# This file was generated, do not modify it. # hide
__result = begin # hide
    import Makie.StatsBase

x_data = randn(500)
y_data = randn(500)

nbins = 30

central_heatmap = plot!(central_axis, StatsBase.fit(StatsBase.Histogram, (x_data, y_data); nbins = nbins); interpolate = false)

# We use Makie's hist recipe for the rest:
top_hist   = hist!(top_axis, x_data; nbins = nbins, strokewidth = 1, strokecolor = (:black, 0.6))
right_hist = hist!(right_axis, y_data; nbins = nbins, direction = :x, strokewidth = 1, strokecolor = (:black, 0.6))

fig
end # hide
save(joinpath(@OUTPUT, "example_6416273189947073450.png"), __result; ) # hide
save(joinpath(@OUTPUT, "example_6416273189947073450.svg"), __result; ) # hide
nothing # hide