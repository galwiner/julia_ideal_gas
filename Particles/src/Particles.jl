module Particles

export Particle, Arena

mutable struct Particle
    pos :: Vector{<:Number} 
    vel :: Vector{<:Number}
    accel :: Vector{<:Number}

    function Particle(pos :: Vector{<:Number}=[0,0],vel:: Vector{<:Number}=[0,0],accel::Vector{<:Number} = [0,0])
        new(pos,vel,accel)
    end
    function Particle(ndims::Int)
        new(zeros(ndims),zeros(ndims),zeros(ndims))
    end
end



struct Arena
    size :: Array{Int}
    particles :: Array{Particle}
    # pl :: Plots.Plot
    
    function Arena(size::Array{<:Int,1} , n_particles::Int=1)
        # pl = plot()
        arena = new(size,Particle[])
    
        [push!(arena.particles,Particle(length(size))) for _ in 0:n_particles-1]        
        arena
    end
end

function randomize_pos(arena :: Arena)
    for p in arena.particles
            p.pos = [rand(-arena.size[d]/2:arena.size[d]/2) for d in 1:length(arena.size) ]
    end
end

function randomize_vel(arena :: Arena,max_vel :: Number) 
    for p in arena.particles
        p.vel = [rand(Uniform(-max_vel,max_vel)) for d in 1:length(p.vel) ]
    end
end

function randomize_all(arena::Arena,max_vel::Number)
    randomize_pos(arena)
    randomize_vel(arena,max_vel)
end


function update_pos(p::Particle,arena:: Arena)
    p.pos += p.vel
    
    
    p.pos = p.pos .* (1 .- (p.pos .> arena.size))
 

    # p.pos = p.pos .* (1 .- (p.pos .<= 0) + arena.size .* (p.pos .<= 0))
end

function update_vel(p::Particle)
    p.vel += p.accel
end

function set_force(a::Arena,f::Vector{<:Number})
    for p in a.particles
        p.accel=f
    end
end

function apply_force(a::Arena,f::Vector{<:Number})
    for p in a.particles
        p.accel+=f
    end
end

function update_arena(a::Arena)
    for p in a.particles
        update_vel(p)
        update_pos(p,a)
    end
end
function get_coords(arena::Arena)
    
    coords = zeros(2)
    for p in arena.particles
        coords=hcat(coords,p.pos[:,:])
    end
    coords[1,2:end],coords[2,2:end]
end


function show_arena(arena::Arena)
    scatter(arena.pl,get_coords(arena))
end

end # module
