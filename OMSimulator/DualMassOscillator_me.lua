-- status: correct
-- teardown_command: rm omsllog.txt DualMassOscillator_me.mat

setLogFile("omsllog.txt")

model = newModel()
setTempDirectory(".")

-- instantiate FMUs
instantiateFMU(model, "../FMUs/DualMassOscillator.System1_me.fmu", "System1")
instantiateFMU(model, "../FMUs/DualMassOscillator.System2_me.fmu", "System2")

-- add connections
addConnection(model, "System1.F", "System2.F")
addConnection(model, "System1.s", "System2.s")
addConnection(model, "System1.v", "System2.v")
addConnection(model, "System1.a", "System2.a")

setResultFile(model, "DualMassOscillator_me.mat")

setStopTime(model, 0.1)
setCommunicationInterval(model, 1e-5)

--describe(model)

--exportDependencyGraph(model, "DualMassOscillator_me")
--os.execute("gvpr -c \"N[$.degree==0]{delete(root, $)}\" DualMassOscillator_me_simulation.dot | dot -Tpdf -o DualMassOscillator_me_simulation.pdf")
--os.execute("gvpr -c \"N[$.degree==0]{delete(root, $)}\" DualMassOscillator_me_initialization.dot | dot -Tpdf -o DualMassOscillator_me_initialization.pdf")

--exportCompositeStructure(model, "DualMassOscillator_me")
--os.execute("dot -Gsplines=none DualMassOscillator_me.dot | neato -n -Gsplines=ortho -Tpdf -oDualMassOscillator_me.pdf")

initialize(model)
simulate(model)

tcur = getCurrentTime(model)
vars = {"System1.mass1.s", "System2.mass2.s"}
for _,var in ipairs(vars) do
  print(var .. " at " .. tcur .. ": " .. getReal(model, var))
end

terminate(model)

unload(model)

-- Result:
-- System1.mass1.s at 0.1: -0.44647144348144
-- System2.mass2.s at 0.1: -0.28277588561346
-- info:    1 warnings
-- info:    0 errors
-- info:    Logging information has been saved to "omsllog.txt"
-- endResult
