game = basic_game(;window_visible=false)

ViZDoom.init(game)

actions = [[1., 0., 0.], [0., 1., 0.], [0., 0., 1.]]
episodes = 1
# example if running real time, you could use sleep(sleep_time)
sleep_time = 1.0 / ViZDoom.DEFAULT_TICRATE

for i in 1:episodes
    println("Episode #$i")
    ViZDoom.new_episode(game)

    while !ViZDoom.is_episode_finished(game)
        state = ViZDoom.get_screen_buffer(game)
        screen_shape = ViZDoom.get_screen_width(game), ViZDoom.get_screen_height(game), ViZDoom.get_screen_channels(game)
        print(size(state), screen_shape)
        # example reshaping screen size
        image_state = reshape(state, screen_shape)
        r = ViZDoom.make_action(game, rand(actions))
        println("Reward $r")
        # player is dead, most games have auto-respawn enabled
        # this is the code to use if you don't enable it
        if ViZDoom.is_player_dead(game)
            ViZDoom.respawn_player(game)
        end
    end
end
