using ViZDoom
using Test

# TODO: just check these exist instead of printing
# Type tests
println(ViZDoom.Mode)
println(ViZDoom.ScreenFormat)
println(ViZDoom.ScreenResolution)
println(ViZDoom.AutomapMode)
println(ViZDoom.Button)
println(ViZDoom.Label)
println(ViZDoom.ServerState)
println(ViZDoom.DoomGame)
# Cosnt tests
@assert ViZDoom.MAX_PLAYERS == 16
# Enum tests
@assert typeof(ViZDoom.PLAYER) == ViZDoom.Mode

# Basic test
include("basic.jl")