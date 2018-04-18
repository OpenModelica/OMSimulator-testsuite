-- status: correct
-- teardown_command: rm DualMassOscillatorEq_cs_oms2.log DualMassOscillatorEq_cs_oms2.mat
-- linux: yes

oms2_setLogFile("DualMassOscillatorEq_cs_oms2.log")

status = oms2_setTempDirectory("./DualMassOscillatorEq_cs_oms2_tmp")

status = oms2_newFMIModel("DualMass")

-- add FMUs
status = oms2_addFMU("DualMass", "../FMUs/DualMassOscillator.System1Eq_cs.fmu", "System1")
status = oms2_addFMU("DualMass", "../FMUs/DualMassOscillator.System2Eq_cs.fmu", "System2")

-- add connections
status = oms2_addConnection("DualMass", "System1:in_F", "System2:out_F")
status = oms2_addConnection("DualMass", "System1:out_s1", "System2:in_s1")
status = oms2_addConnection("DualMass", "System1:out_v1", "System2:in_v1")

status = oms2_setResultFile("DualMass", "DualMassOscillatorEq_cs_oms2.mat")

stopTime = 0.1
status = oms2_setStopTime("DualMass", stopTime)
status = oms2_setCommunicationInterval("DualMass", 1e-5)

-- Master algorithm variants:
-- standard : The single-task standard
-- pctpl : Task pool approach using CTPL library (https://github.com/vit-vit/CTPL)
status = oms2_setMasterAlgorithm("DualMass", "pctpl")


status = oms2_initialize("DualMass")
status = oms2_simulate("DualMass")

vars = {"DualMass.System1:s1", "DualMass.System2:s2"}
for _,var in ipairs(vars) do
  print(var .. " at " .. stopTime .. ": " .. oms2_getReal(var))
end

oms2_terminate("DualMass")

oms2_unloadModel("DualMass")

-- Result:
-- DualMass.System1:s1 at 0.1: -0.45012153166449
-- DualMass.System2:s2 at 0.1: -0.30237070431675
-- info:    Logging information has been saved to "DualMassOscillatorEq_cs_oms2.log"
-- endResult
