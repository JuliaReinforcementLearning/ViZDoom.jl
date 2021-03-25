module ViZDoom

using Artifacts
using CxxWrap
const vizdoom_artifact_dir = artifact"ViZDoom"
@wrapmodule(joinpath(vizdoom_artifact_dir, "ViZDoom-1.1.8", "bin", "libvizdoomjl.so"))

function __init__()
    @initcxx
end

include("util.jl")
export get_scenario_path, set_game

include("games/games.jl")
export basic_game

end # module
