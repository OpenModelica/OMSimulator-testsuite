-- status: correct
-- teardown_command: rm tlm.run tlm_res.mat tlm.csv TLM_External_Tools.log TLMlogfile.log
-- linux: yes
-- mingw: no
-- mac: no

--curdir = os.getenv("PWD")
--newpath = "export PATH="..curdir.."/../../OMTLMSimulator/bin:$PATH"
--tlmpath = "export OMTLMSimulatorPath="..curdir.."/../../OMTLMSimulator"
--os.execute(newpath)
--os.execute(tlmpath)

--print(newpath)
--print(tlmpath)

oms2_setLogFile("TLM_External_Tools.log")
oms2_newTLMModel("tlm")
oms2_setTempDirectory("./TLM_External_Tools_tmp")

oms2_addExternalModel("tlm", "adder", "../FMUs/adder.fmu", "./StartTLMFmiWrapper")
oms2_addExternalModel("tlm", "source1", "../FMUs/source.fmu", "./StartTLMFmiWrapper")
oms2_addExternalModel("tlm", "source2", "../FMUs/source.fmu", "./StartTLMFmiWrapper")
oms2_addExternalModel("tlm", "gain", "../FMUs/gain.fmu", "./StartTLMFmiWrapper")

oms2_addTLMInterface("tlm", "adder",  "x1", 1, input,  "Signal")
oms2_addTLMInterface("tlm", "adder",  "x2", 1, input,  "Signal")
oms2_addTLMInterface("tlm", "adder",  "y",  1, output, "Signal")
oms2_addTLMInterface("tlm", "source1","y",  1, output, "Signal")
oms2_addTLMInterface("tlm", "source2","y",  1, output, "Signal")
oms2_addTLMInterface("tlm", "gain",   "y",  1, input,  "Signal")
oms2_addTLMInterface("tlm", "gain",   "u",  1, output, "Signal")

oms2_addTLMConnection("tlm", "adder:x1", "source2:y", 0,0,0,0)
oms2_addTLMConnection("tlm", "adder:x2", "source1:y", 0,0,0,0)
oms2_addTLMConnection("tlm", "gain:y", "adder:y",     0,0,0,0)

oms2_setTLMSocketData("tlm","127.0.1.1",11142,12142)

-- oms2_describe("tlm")

oms2_setStartTime("tlm", 0.5)
oms2_setStopTime("tlm", 4)

oms2_initialize("tlm")

oms2_simulate("tlm")


vars = {"adder.y","source1.y","source2.y"} 
for _,var in ipairs(vars) do 
  if 1 == compareSimulationResults("tlm.csv", "../ReferenceFiles/TLM_External_Tools.csv", var, 1e-2, 1e-4) then 
    print(var .. " is equal") 
  else 
    print(var .. " is not equal") 
  end 
end

-- Result:
-- Starting FMIWrapper. Debug output will be written to "TLMlogfile.log".
-- Starting FMIWrapper. Debug output will be written to "TLMlogfile.log".
-- Starting FMIWrapper. Debug output will be written to "TLMlogfile.log".
-- Starting FMIWrapper. Debug output will be written to "TLMlogfile.log".
-- Starting TLM simulation.
-- Monitoring thread finished.
-- Manager thread finished.
-- adder.y is equal
-- source1.y is equal
-- source2.y is equal
-- info: Logging information has been saved to "TLM_External_Tools.log"
-- endResult
