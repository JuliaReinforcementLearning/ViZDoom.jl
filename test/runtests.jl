using ViZDoom
using Test

@testset "basic" begin
    game = basic_game(window_visible = false)
    ViZDoom.set_seed(game, 0)
    @test ViZDoom.init(game)
    buffer = deepcopy(ViZDoom.get_screen_buffer(game))
    @test typeof(buffer) == Array{UInt8, 1}
    @test length(buffer) == ViZDoom.get_screen_size(game)
    ViZDoom.make_action(game, [0., 1., 0.])
    @test ~ViZDoom.is_episode_finished(game)
    buffer2 = deepcopy(ViZDoom.get_screen_buffer(game))
    @test buffer != buffer2
    ViZDoom.new_episode(game)
end
