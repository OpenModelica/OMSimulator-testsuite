-- status: correct
-- teardown_command: rm omsllog.txt DualMassOscillatorEq_me.mat

setLogFile("omsllog.txt")

model = newModel()
setTempDirectory(".")

-- instantiate FMUs
instantiateFMU(model, "../FMUs/DualMassOscillator.System1Eq_me.fmu", "System1")
instantiateFMU(model, "../FMUs/DualMassOscillator.System2Eq_me.fmu", "System2")

-- add connections
addConnection(model, "System1.in_F", "System2.out_F")
addConnection(model, "System1.out_s1", "System2.in_s1")
addConnection(model, "System1.out_v1", "System2.in_v1")

setResultFile(model, "DualMassOscillatorEq_me.mat")

setStopTime(model, 0.1)
setCommunicationInterval(model, 1e-5)

--describe(model)

--exportDependencyGraph(model, "DualMassOscillatorEq_me")
--os.execute("gvpr -c \"N[$.degree==0]{delete(root, $)}\" DualMassOscillatorEq_me_simulation.dot | dot -Tpdf -o DualMassOscillatorEq_me_simulation.pdf")
--os.execute("gvpr -c \"N[$.degree==0]{delete(root, $)}\" DualMassOscillatorEq_me_initialization.dot | dot -Tpdf -o DualMassOscillatorEq_me_initialization.pdf")

--exportCompositeStructure(model, "DualMassOscillatorEq_me")
--os.execute("dot -Gsplines=none DualMassOscillatorEq_me.dot | neato -n -Gsplines=ortho -Tpdf -oDualMassOscillatorEq_me.pdf")

initialize(model)
simulate(model)

tcur = getCurrentTime(model)
vars = {"System1.s1", "System2.s2"}
for _,var in ipairs(vars) do
  print(var .. " at " .. tcur .. ": " .. getReal(model, var))
end

terminate(model)

unload(model)

-- Result:
-- System1.s1 at 0.1: -0.44647144348144
-- System2.s2 at 0.1: -0.28277588561346
-- info:    Logging information has been saved to "omsllog.txt"
-- endResult
