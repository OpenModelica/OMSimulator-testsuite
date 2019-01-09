-- status: correct
-- teardown_command: rm -rf dualmassoscillatoreq-lua/ DualMassOscillatorEq.mat
-- linux: yes
-- mingw: no
-- win: no
-- mac: no

oms3_setCommandLineOption("--suppressPath=true")
oms3_setTempDirectory("./dualmassoscillatoreq-lua/")

oms3_newModel("DualMassOscillatorEq")
oms3_addSystem("DualMassOscillatorEq.root", oms_system_sc)

-- instantiate FMUs
oms3_addSubModel("DualMassOscillatorEq.root.system1", "../FMUs/DualMassOscillator.System1Eq.fmu")
oms3_addSubModel("DualMassOscillatorEq.root.system2", "../FMUs/DualMassOscillator.System2Eq.fmu")

-- add connections
oms3_addConnection("DualMassOscillatorEq.root.system1.in_F", "DualMassOscillatorEq.root.system2.out_F")
oms3_addConnection("DualMassOscillatorEq.root.system1.out_s1", "DualMassOscillatorEq.root.system2.in_s1")
oms3_addConnection("DualMassOscillatorEq.root.system1.out_v1", "DualMassOscillatorEq.root.system2.in_v1")

-- simulation settings
oms3_setResultFile("DualMassOscillatorEq", "DualMassOscillatorEq.mat", 100)
oms3_setStopTime("DualMassOscillatorEq", 0.1)
oms3_setFixedStepSize("DualMassOscillatorEq.root", 1e-4)
oms3_setTolerance("DualMassOscillatorEq.root", 1e-6)

oms3_instantiate("DualMassOscillatorEq")

oms3_setReal("DualMassOscillatorEq.root.system1.s1_start", 1.1)
oms3_setReal("DualMassOscillatorEq.root.system2.s2_start", 2.5)

oms3_initialize("DualMassOscillatorEq")
print("info:    Initialization")
print("info:      system1.s1: " .. oms3_getReal("DualMassOscillatorEq.root.system1.s1"))
print("info:      system2.s2: " .. oms3_getReal("DualMassOscillatorEq.root.system2.s2"))

oms3_simulate("DualMassOscillatorEq")
print("info:    Simulation")
print("info:      system1.s1: " .. oms3_getReal("DualMassOscillatorEq.root.system1.s1"))
print("info:      system2.s2: " .. oms3_getReal("DualMassOscillatorEq.root.system2.s2"))

oms3_terminate("DualMassOscillatorEq")
oms3_delete("DualMassOscillatorEq")

-- Result:
-- info:    maximum step size for 'DualMassOscillatorEq.root': 0.100000
-- info:    Result file: DualMassOscillatorEq.mat (bufferSize=100)
-- info:    Initialization
-- info:      system1.s1: 1.1
-- info:      system2.s2: 2.5
-- info:    Simulation
-- info:      system1.s1: 0.90134339026353
-- info:      system2.s2: 1.9383786064617
-- info:    Final Statistics for 'DualMassOscillatorEq.root':
--          NumSteps = 1384 NumRhsEvals  = 1831 NumLinSolvSetups = 253
--          NumNonlinSolvIters = 1830 NumNonlinSolvConvFails = 0 NumErrTestFails = 107
-- endResult
