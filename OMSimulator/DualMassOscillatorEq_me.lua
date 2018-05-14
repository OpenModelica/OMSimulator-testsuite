-- status: correct
-- teardown_command: rm DualMassOscillatorEq_me.log DualMassOscillatorEq_me.mat

oms2_setLogFile("DualMassOscillatorEq_me.log")
oms2_setTempDirectory("./DualMassOscillatorEq_me_tmp")
oms2_newFMIModel("DualMassOscillatorEq")

-- instantiate FMUs
oms2_addFMU("DualMassOscillatorEq", "../FMUs/DualMassOscillator.System1Eq_me.fmu", "System1")
oms2_addFMU("DualMassOscillatorEq", "../FMUs/DualMassOscillator.System2Eq_me.fmu", "System2")

-- add connections
oms2_addConnection("DualMassOscillatorEq", "System1:in_F", "System2:out_F")
oms2_addConnection("DualMassOscillatorEq", "System1:out_s1", "System2:in_s1")
oms2_addConnection("DualMassOscillatorEq", "System1:out_v1", "System2:in_v1")

oms2_setResultFile("DualMassOscillatorEq", "DualMassOscillatorEq_me.mat")

oms2_setStopTime("DualMassOscillatorEq", 0.1)
oms2_setCommunicationInterval("DualMassOscillatorEq", 1e-5)

oms2_initialize("DualMassOscillatorEq")
oms2_simulate("DualMassOscillatorEq")

tcur = oms2_getCurrentTime("DualMassOscillatorEq")
vars = {"DualMassOscillatorEq.System1:s1", "DualMassOscillatorEq.System2:s2"}
for _,var in ipairs(vars) do
  print(var .. " at " .. tcur .. ": " .. oms2_getReal(var))
end

oms2_terminate("DualMassOscillatorEq")
oms2_unloadModel("DualMassOscillatorEq")

-- Result:
-- DualMassOscillatorEq.System1:s1 at 0.1: -0.607142765476
-- DualMassOscillatorEq.System2:s2 at 0.1: -0.067723471629764
-- info:    Logging information has been saved to "DualMassOscillatorEq_me.log"
-- endResult
