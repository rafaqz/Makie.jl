# This file was generated, do not modify it. # hide
using GLMakie # All functionality is defined in Makie and every backend re-exports Makie
GLMakie.activate!() # hide

Base.@kwdef mutable struct Lorenz # define the Lorenz attractor
    dt::Float64 = 0.01
    σ::Float64 = 10
    ρ::Float64 = 28
    β::Float64 = 8/3
    x::Float64 = 1
    y::Float64 = 1
    z::Float64 = 1
end

function step!(l::Lorenz) # define how to advance in time
    dx = l.σ * (l.y - l.x)
    dy = l.x * (l.ρ - l.z) - l.y
    dz = l.x * l.y - l.β * l.z
    l.x += l.dt * dx
    l.y += l.dt * dy
    l.z += l.dt * dz
    Point3f(l.x, l.y, l.z)
end

attractor = Lorenz()

points = Observable(Point3f[]) # Observables are like boxes which hold values
colors = Observable(Int[])

set_theme!(theme_black()) # Makie can be themed!

fig, ax, l = lines(points, color = colors,
    colormap = :inferno, transparency = true, # these are attributes of the line plot
    axis = (; type = Axis3, protrusions = (0, 0, 0, 0), # these are attributes of the axis
        viewmode = :fit, limits = (-30, 30, -30, 30, 0, 50)))

record(fig, "lorenz.mp4", 1:120) do frame # this records an animation by iterating through the last argument
    for i in 1:50
        push!(points[], step!(attractor)) # update the value which points holds
        push!(colors[], frame)            # update the value which colors holds
    end
    ax.azimuth[] = 1.7pi + 0.3 * sin(2pi * frame / 120) # set the view angle of the axis
    notify.((points, colors)) # tell points and colors that their value has been updated
    l.colorrange = (0, frame) # set the range of the colormap for the plot
end
set_theme!() # hide