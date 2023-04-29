# This file was generated, do not modify it. # hide
__result = begin # hide
    using CairoMakie
using CairoMakie # hide
CairoMakie.activate!() # hide
fig = Figure()
Axis(fig[1, 1], xticks = 1:10)
Axis(fig[2, 1], xticks = (1:2:9, ["A", "B", "C", "D", "E"]))
Axis(fig[3, 1], xticks = WilkinsonTicks(5))
fig
end # hide
save(joinpath(@OUTPUT, "example_3457944462637020189.png"), __result; ) # hide
save(joinpath(@OUTPUT, "example_3457944462637020189.svg"), __result; ) # hide
nothing # hide