# Julia script
# Kibaek Kim - ANL MCS 2016

using MPI, Dsp

if length(ARGS) < 1
	error("Please give an SMPS file name.")
end

smps = ARGS[1]

# type of solution methods
solve_types = [:Dual, :Benders]

# initialize MPI
MPI.Init()

readSmps(smps)

optimize(solve_type = solve_types[1])

if MPI.Comm_rank(MPI.COMM_WORLD) == 0
    @show getprimobjval() 
    @show getdualobjval() 
    @show getprimvalue()
    @show getdualvalue()
end

MPI.Finalize()
