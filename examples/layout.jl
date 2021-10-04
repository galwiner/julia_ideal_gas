using WGLMakie

scene, layout = layoutscene(resolution = (1200, 900))

ax = layout[1, 1] = LAxis(scene)

toggles = [LToggle(scene, active = ac) for ac in [true, false]]
labels = [LText(scene, lift(x -> x ? "active" : "inactive", t.active))
    for t in toggles]

layout[1, 2] = grid!(hcat(toggles, labels), tellheight = false)