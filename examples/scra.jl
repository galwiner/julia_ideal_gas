using Plots
gr()

fig =scatter()

for _ in 1:10
    x=[rand() for _ in 1:100]
    y=[rand() for _ in 1:100]

    scatter!(fig,x,y)
    
    sleep(0.1)
end
