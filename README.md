# ViZDoom

[![Build Status](https://travis-ci.com/JuliaReinforcementLearning/ViZDoom.jl.svg?branch=master)](https://travis-ci.com/JuliaReinforcementLearning/ViZDoom.jl)

This package provides a wrapper around the [ViZDoom](https://github.com/mwydmuch/ViZDoom) and also some typical scenarios. Enjoy it!

## How to install

This package has only been tested on Ubuntu (18.04+) and Arch Linux with Julia 1.0/1.6 (and nightly). You need to install the necessary [dependencies](https://github.com/mwydmuch/ViZDoom/blob/master/doc/Building.md#-linux) first (or, you can also check the [packages](https://github.com/JuliaReinforcementLearning/RLEnvViZDoom.jl/blob/master/.travis.yml) in the `.travis.yml` file). It requires a gcc version with C++17 support. Then just add this package as usual:

```
(v1.6) pkg> add ViZDoom
```

## How to use

Most of the functions' name are kept same with Python. So you'll find it pretty easy to port the Python example code into Julia. To easily access the state of a game, The following functions are added:

- `get_screen_buffer(game)`. `Array<UInt8, 1>` is returned with size of width * height * channels. (You need to reshape this array to show it).
- `get_depth_buffer(game)`.`Array<UInt8, 1>` is returned with size of width * height, which provides the depth info.
- `get_label_buffer(game)`.`Array<UInt8, 1>` is returned with size of width * height, which provides the label info.
- `get_automap_buffer(game)`.`Array<UInt8, 1>` is returned with size of width * height * channels, which provides the map info from the top view.


Beyond that, some helper functions are also provided:

- `get_scenario_path("basic.wad")` can be used to get the absolute path of `basic.wad` files.
- `set_game(game; kw...)`. It's really verbose to set the game line by line. This function comes to simplify the process. The name of the argument should be the same with the original method without the `set_` or `add_` prefix. For example, we can use `set(game; doom_map="map01, mode=PLAYER")` to replace the original methods like`ViZDoom.set_doom_map(game, "map01"); ViZDoom.set_mode(game, "PLAYER")`. You can checkout the detailed examples in the `src/games`folder. Following are some special arguments:
    - `available_buttons` The original method name is `add_available_button`. Here you can set `available_buttons=[MOVE_LEFT, MOVE_RIGHT, ATTACK]`.
- `basic_game(;kw...)`. A simple game with default config is returned. (More default configs are coming soon.)

## Docker usage
Build the container with:
```bash
docker build -t vizdoom.jl .
```
which installs Julia v1.6, all ViZDoom dependencies, and builds this package.

Run the container with:
```bash
docker run -it --rm vizdoom.jl
```
The `--rm` flag can be omitted if you want to create multiple containers.

## Development with VSCode
Download/install VSCode and the [Remote Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) and follow the extra install steps there for using docker as a non-root user. Then open VSCode and do `Ctrl + Shift + p` and select the `Remote Containers: Rebuild and Reopen in Container` option. 

### Visualization with containers
If you want to view the game when in a VSCode devcontainer you'll need to run `xhost +local:root` before starting VSCode. NOTE: this is a technically unsafe command, see [here](http://wiki.ros.org/docker/Tutorials/GUI) for some details. For the security conscious you should run `xhost -local:root` after you're done.
This option is tested with Ubuntu only, you may need other workarounds for different OSes.