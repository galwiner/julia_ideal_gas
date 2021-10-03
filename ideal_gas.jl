using Revise
using Particles
# using GLMakie
using WGLMakie

a = Arena([500,500],100)
m=Particles
m.randomize_pos(a)
m.update_arena(a)

m.randomize_vel(a,10)
n=Node(Point2f0.((p->p.pos).(a.particles)))

scene=Scene(show_axis = true)
scatter!(scene,n)
xlims!(scene,-500,500)
ylims!(scene,-500,500)
m.set_force(a,Vector([0,0]))
m.apply_force(a,Vector([-0.0,0.01]))
for _ in 1:200
    m.update_arena(a)
    # m.randomize_vel(a,10)

    n[]=Point2f0.((p->p.pos).(a.particles))
 
    
    sleep(0.01)
end
