using Revise
using Particles
# using GLMakie
using WGLMakie

a = Arena([200,200],5)
m=Particles
m.randomize_pos(a)
m.randomize_vel(a,1)
n=Node(Point2f0.((p->p.pos).(a.particles)))

scene=Scene()
scatter!(scene,n)
for _ in 1:100
    m.update_arena(a)
    n[]=Point2f0.((p->p.pos).(a.particles))
    sleep(0.01)
end
