-- status: correct
-- teardown_command: rm omsllog.txt DualMassOscillatorEq_cs.mat

setLogFile("omsllog.txt")

model = newModel()
setTempDirectory(".")

-- instantiate FMUs
instantiateFMU(model, "../FMUs/DualMassOscillator.System1Eq_cs.fmu", "System1")
instantiateFMU(model, "../FMUs/DualMassOscillator.System2Eq_cs.fmu", "System2")

-- add connections
addConnection(model, "System1.in_F", "System2.out_F")
addConnection(model, "System1.out_s1", "System2.in_s1")
addConnection(model, "System1.out_v1", "System2.in_v1")

setResultFile(model, "DualMassOscillatorEq_cs.mat")

setStopTime(model, 0.1)
setCommunicationInterval(model, 1e-5)

--describe(model)

--exportDependencyGraph(model, "DualMassOscillatorEq_cs")
--os.execute("gvpr -c \"N[$.degree==0]{delete(root, $)}\" DualMassOscillatorEq_cs_simulation.dot | dot -Tpdf -o DualMassOscillatorEq_cs_simulation.pdf")
--os.execute("gvpr -c \"N[$.degree==0]{delete(root, $)}\" DualMassOscillatorEq_cs_initialization.dot | dot -Tpdf -o DualMassOscillatorEq_cs_initialization.pdf")

--exportCompositeStructure(model, "DualMassOscillatorEq_cs")
--os.execute("dot -Gsplines=none DualMassOscillatorEq_cs.dot | neato -n -Gsplines=ortho -Tpdf -oDualMassOscillatorEq_cs.pdf")

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
-- System1.s1 at 0.1: -0.44227660452253
-- System2.s2 at 0.1: -0.29696508616087
-- info:    Logging information has been saved to "omsllog.txt"
-- endResult
