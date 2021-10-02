using Revise
using Particles
# using GLMakie
using WGLMakie

a = Arena([200,200],100)
m=Particles
m.randomize_pos(a)
m.randomize_vel(a,1)
n=Node(Point2f0.((p->p.pos).(a.particles)))

scene=Scene(show_axis = false)
scatter!(scene,n)
xlims!(scene,-500,500)
ylims!(scene,-500,500)

for _ in 1:100
    m.update_arena(a)
    n[]=Point2f0.((p->p.pos).(a.particles))
 
    
    sleep(0.001)
end
