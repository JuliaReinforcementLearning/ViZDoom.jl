using Artifacts
using BinaryProvider
using CxxWrap

vizdoom_artifact_dir = artifact"ViZDoom"
vizdoom_dir = joinpath(vizdoom_artifact_dir, "ViZDoom-1.1.8")

# Copy our lib_julia to the src dir and remove any old ones
const deps_dir = @__DIR__
run(`rm -rf $(joinpath(vizdoom_dir, "src", "lib_julia"))`)
run(`cp -r $(joinpath(deps_dir, "lib_julia")) $(joinpath(vizdoom_dir, "src"))`)

const JLCxx_DIR = get(ENV, "JLCXX_DIR", joinpath(CxxWrap.prefix_path(), "lib", "cmake", "JlCxx"))
const cmake_cmd = `cmake -DJlCxx_DIR=$(JLCxx_DIR) -DBUILD_JULIA=ON -DJulia_EXECUTABLE=$(joinpath(Sys.BINDIR, "julia")) .`
@info cmake_cmd
cd(() -> run(cmake_cmd), vizdoom_dir)
# build with num_cores - 1. Saving 1 for the user
num_cores = parse(Int, read(`nproc`, String))
cd(() -> run(`make -j $(num_cores - 1)`), vizdoom_dir)

# Copy freedoom2.wad into bin where everything else is.
# The default config looks for ./freedoom2.wad so this allows for simpler configs
run(`cp $(joinpath(vizdoom_dir, "src", "freedoom2.wad")) $(joinpath(vizdoom_dir, "bin"))`)