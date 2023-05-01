# This file was generated, do not modify it. # hide
__result = begin # hide
    using CairoMakie
CairoMakie.activate!() # hide


himmelblau(x, y) = (x^2 + y - 11)^2 + (x + y^2 - 7)^2
x = y = range(-6, 6; length=100)
z = himmelblau.(x, y')

levels = 10.0.^range(0.3, 3.5; length=10)
colormap = Makie.sampler(:hsv, 100; scaling=Makie.Scaling(x -> x^(1 / 10), nothing))
f, ax, ct = contour(x, y, z; labels=true, levels, colormap)
f
end # hide
save(joinpath(@OUTPUT, "example_17532162846492516373.png"), __result; ) # hide

nothing # hide