-- status: correct
-- teardown_command: rm -rf pi_controller_tmp/
-- linux: yes
-- mingw: no
-- win: no
-- mac: no

oms3_setCommandLineOption("--suppressPath=true")
oms3_setTempDirectory("./pi_controller_tmp/")

oms3_newModel("PI_Controller")
oms3_addSystem("PI_Controller.co_sim", oms_system_wc)

-- instantiate FMUs
oms3_addSubModel("PI_Controller.co_sim.addP", "../FMUs/Modelica.Blocks.Math.Add.fmu")
oms3_addSubModel("PI_Controller.co_sim.P", "../FMUs/Modelica.Blocks.Math.Gain.fmu")
oms3_addSubModel("PI_Controller.co_sim.addI", "../FMUs/Modelica.Blocks.Math.Add3.fmu")
oms3_addSubModel("PI_Controller.co_sim.I", "../FMUs/Modelica.Blocks.Continuous.Integrator.fmu")
oms3_addSubModel("PI_Controller.co_sim.addPI", "../FMUs/Modelica.Blocks.Math.Add.fmu")
oms3_addSubModel("PI_Controller.co_sim.gainPI", "../FMUs/Modelica.Blocks.Math.Gain.fmu")
oms3_addSubModel("PI_Controller.co_sim.limiter", "../FMUs/Modelica.Blocks.Nonlinear.Limiter.fmu")
oms3_addSubModel("PI_Controller.co_sim.addSat", "../FMUs/Modelica.Blocks.Math.Add.fmu")
oms3_addSubModel("PI_Controller.co_sim.gainTrack", "../FMUs/Modelica.Blocks.Math.Gain.fmu")

-- add connections
oms3_addConnection("PI_Controller.co_sim.addP.y", "PI_Controller.co_sim.P.u")
oms3_addConnection("PI_Controller.co_sim.addI.y", "PI_Controller.co_sim.I.u")
oms3_addConnection("PI_Controller.co_sim.P.y", "PI_Controller.co_sim.addPI.u1")
oms3_addConnection("PI_Controller.co_sim.I.y", "PI_Controller.co_sim.addPI.u2")
oms3_addConnection("PI_Controller.co_sim.addPI.y", "PI_Controller.co_sim.gainPI.u")
oms3_addConnection("PI_Controller.co_sim.gainPI.y", "PI_Controller.co_sim.limiter.u")
oms3_addConnection("PI_Controller.co_sim.gainPI.y", "PI_Controller.co_sim.addSat.u2")
oms3_addConnection("PI_Controller.co_sim.limiter.y", "PI_Controller.co_sim.addSat.u1")
oms3_addConnection("PI_Controller.co_sim.addSat.y", "PI_Controller.co_sim.gainTrack.u")
oms3_addConnection("PI_Controller.co_sim.gainTrack.y", "PI_Controller.co_sim.addI.u3")

oms3_exportDependencyGraphs("PI_Controller.co_sim", "a.dot", "b.dot")

oms3_instantiate("PI_Controller")
oms3_initialize("PI_Controller")
oms3_terminate("PI_Controller")

oms3_delete("PI_Controller")

-- Result:
-- info:    Set temp directory to    <suppressed>
-- info:    Set working directory to <suppressed>
-- info:    Set temp directory to    <suppressed>
-- info:    New model "PI_Controller" with corresponding temp directory <suppressed>
-- endResult
