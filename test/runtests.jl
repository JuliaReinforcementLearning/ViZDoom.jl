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

# trying to access before init throws load error
try
    game = basic_game(;window_visible=false)
    # this should throw
    ViZDoom.get_screen_buffer(game)
catch LoadError
end

# this should throw nullptr: accessing after a game is over without reset
game = basic_game(;window_visible=false)
ViZDoom.init(game)
ViZDoom.new_episode(game)
while !ViZDoom.is_episode_finished(game)
    ViZDoom.make_action(game, [1.])
end
try
    ViZDoom.get_screen_buffer(game)
catch LoadError
end
try
    ViZDoom.get_automap_buffer(game)
catch LoadError
end
try
    ViZDoom.get_depth_buffer(game)
catch LoadError
end
try
    ViZDoom.get_labels_buffer(game)
catch LoadError
end

# Basic test
include("basic.jl")