-- status: correct
-- teardown_command: rm -rf Example_res.mat Example.log
-- linux: yes
-- mingw: no
-- win: no
oms2_setLogFile("Example.log")
oms2_newFMIModel("Example")

oms2_addFMU("Example","ASSCExample_Class1.fmu","Class1")
oms2_addFMU("Example","ASSCExample_Class2.fmu","Class2")

oms2_addSolver("Example","solver","internal")
oms2_addConnection("Example","Class1","solver")
oms2_addConnection("Example","Class2","solver")
oms2_addConnection("Example","Class1:max","Class2:max")

oms2_setStopTime("Example", 6.0)
oms2_setMasterAlgorithm("Example","assc")
oms2_setMinimalStepSize("Example", 0.05)
oms2_setMaximalStepSize("Example", 0.5)

oms2_addEventIndicator("Example.Class1:max")
oms2_addTimeIndicator("Example.Class1:eventTime")
oms2_addStaticValueIndicator("Example.Class2:signalwiththreshold",4.5,5.0,0.1)
oms2_addDynamicValueIndicator("Example.Class2:signalwiththreshold","Example.Class1:closeToMax","Example.Class1:max",0.05)
oms2_addSignalsToResults("Example","Class2:signalwiththreshold")

oms2_initialize("Example")
oms2_simulate("Example")
oms2_unloadModel("Example")

if 1==oms2_compareSimulationResults("Example_res.mat", "../ReferenceFiles/SSC.mat", "Class2.signalwiththreshold", 0.0, 0.0) then
	print("info:	 Results are equal")
  else
    print("warning:	Results are not equal")
  end

-- Result:
-- stdout            | info    | The initialization finished successfully without homotopy method.
-- stdout            | info    | The initialization finished successfully without homotopy method.
-- info:	 Results are equal
-- info:    Logging information has been saved to "Example.log"
-- endResult