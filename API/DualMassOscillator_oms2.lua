-- status: correct
-- teardown_command: rm -rf DualMassOscillator_oms2.log DualMassOscillator_oms2_tmp/ DualMassOscillator_oms2.mat DualMassInit.dot DualMassSim.dot
-- linux: yes

oms2_setLogFile("DualMassOscillator_oms2.log")

status = oms2_setTempDirectory("./DualMassOscillator_oms2_tmp")

status = oms2_newFMIModel("DualMass")

-- add FMUs
status = oms2_addFMU("DualMass", "../FMUs/DualMassOscillator.System1.fmu", "System1")
status = oms2_addFMU("DualMass", "../FMUs/DualMassOscillator.System2.fmu", "System2")

-- add solver
oms2_addSolver("DualMass", "solver1", "internal")

-- connect solver
oms2_addConnection("DualMass", "System1", "solver1")
oms2_deleteConnection("DualMass", "System1", "solver1")
oms2_addConnection("DualMass", "System1", "solver1")
oms2_addConnection("DualMass", "System2", "solver1")

-- add connections
status = oms2_addConnection("DualMass", "System1:F", "System2:F")
status = oms2_addConnection("DualMass", "System1:s1", "System2:s1")
status = oms2_addConnection("DualMass", "System1:v1", "System2:v1")
status = oms2_addConnection("DualMass", "System1:a1", "System2:a1")

status = oms2_setResultFile("DualMass", "DualMassOscillator_oms2.mat")

stopTime = 0.1
status = oms2_setStopTime("DualMass", stopTime)
status = oms2_setCommunicationInterval("DualMass", 1e-5)
oms2_setRealParameter("DualMass.System2:s2_start", 2.5)

-- Master algorithm variants:
-- standard : The single-task standard
-- pctpl : task pool approach using CTPL library (https://github.com/vit-vit/CTPL)
-- pmrchannela : Channel based approach using atomic variables for synchronization
-- pmrchannelcv : Channel based approach using condition variables for synchronization
-- pmrchannelm : Channel based approach using mutexes for synchronization
status = oms2_setMasterAlgorithm("DualMass", "pctpl")
-- Experimental idea for multi-rate execution. Has only an effect for the channel based master algorithms!
status = experimental_setActivationRatio("DualMass.System1", 1)
status = experimental_setActivationRatio("DualMass.System2", 1)

status = oms2_initialize("DualMass")

oms2_exportDependencyGraphs("DualMass", "DualMassInit.dot", "DualMassSim.dot")

status = oms2_simulate("DualMass")

vars = {"DualMass.System1:s1", "DualMass.System2:s2"}
for _,var in ipairs(vars) do
  print(var .. " at " .. stopTime .. ": " .. oms2_getReal(var))
end

oms2_unloadModel("DualMass")

-- Result:
-- DualMass.System1:s1 at 0.1: 0.87154409411158
-- DualMass.System2:s2 at 0.1: 1.9937955391923
-- info:    Logging information has been saved to "DualMassOscillator_oms2.log"
-- endResult
