-- status: correct
-- teardown_command: rm -rf dualmassoscillator-lua/ DualMassOscillator.mat
-- linux: yes
-- mingw: no
-- win: no
-- mac: no

oms3_setCommandLineOption("--suppressPath=true --ignoreInitialUnknowns=true")
oms3_setTempDirectory("./dualmassoscillator-lua/")

oms3_newModel("DualMassOscillator")
oms3_addSystem("DualMassOscillator.root", oms_system_sc)

-- instantiate FMUs
oms3_addSubModel("DualMassOscillator.root.system1", "../FMUs/DualMassOscillator.System1.fmu")
oms3_addSubModel("DualMassOscillator.root.system2", "../FMUs/DualMassOscillator.System2.fmu")

-- add connections
oms3_addConnection("DualMassOscillator.root.system1.F", "DualMassOscillator.root.system2.F")
oms3_addConnection("DualMassOscillator.root.system1.s1", "DualMassOscillator.root.system2.s1")
oms3_addConnection("DualMassOscillator.root.system1.v1", "DualMassOscillator.root.system2.v1")
oms3_addConnection("DualMassOscillator.root.system1.a1", "DualMassOscillator.root.system2.a1")

-- simulation settings
oms3_setResultFile("DualMassOscillator", "DualMassOscillator.mat", 100)
oms3_setStopTime("DualMassOscillator", 0.1)
oms3_setFixedStepSize("DualMassOscillator.root", 1e-5)

oms3_instantiate("DualMassOscillator")
oms3_setReal("DualMassOscillator.root.system2.s2_start", 2.5)

oms3_initialize("DualMassOscillator")
print("info:    Initialization")
print("info:      system1.s1: " .. oms3_getReal("DualMassOscillator.root.system1.s1"))
print("info:      system2.s2: " .. oms3_getReal("DualMassOscillator.root.system2.s2"))

oms3_simulate("DualMassOscillator")
print("info:    Simulation")
print("info:      system1.s1: " .. oms3_getReal("DualMassOscillator.root.system1.s1"))
print("info:      system2.s2: " .. oms3_getReal("DualMassOscillator.root.system2.s2"))

oms3_terminate("DualMassOscillator")
oms3_delete("DualMassOscillator")

-- Result:
-- info:    maximum step size for 'DualMassOscillator.root': 0.100000
-- info:    Result file: DualMassOscillator.mat (bufferSize=100)
-- info:    Initialization
-- info:      system1.s1: 1.0
-- info:      system2.s2: 2.5
-- info:    Simulation
-- info:      system1.s1: 0.91068548987697
-- info:      system2.s2: 1.956251983577
-- info:    Final Statistics for 'DualMassOscillator.root':
--          NumSteps = 656 NumRhsEvals  = 911 NumLinSolvSetups = 120
--          NumNonlinSolvIters = 910 NumNonlinSolvConvFails = 0 NumErrTestFails = 57
-- endResult
