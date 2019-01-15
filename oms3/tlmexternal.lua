-- status: correct
-- teardown_command: rm -rf tlmexternal.log tlmexternal-lua/ tlmexternal.csv tlmexternal.run tlmexternal_res.mat
-- linux: yes
-- mingw: no
-- mac: no

oms3_setLogFile("tlmexternal.log")
oms3_setTempDirectory("./tlmexternal-lua")
oms3_newModel("model");
oms3_setResultFile("model","tlmexternal_res.mat")
oms3_addSystem("model.tlmexternal", oms_system_tlm);

-- adder
oms3_addExternalModel("model.tlmexternal.adder", "../FMUs/adder.fmu", "./StartTLMFmiWrapper")
oms3_addTLMBus("model.tlmexternal.adder.x1",  oms_tlm_domain_input, 1, default)
oms3_addTLMBus("model.tlmexternal.adder.x2",  oms_tlm_domain_input, 1, default)
oms3_addTLMBus("model.tlmexternal.adder.y",   oms_tlm_domain_output, 1, default)

-- source1
oms3_addExternalModel("model.tlmexternal.source1", "../FMUs/source.fmu", "./StartTLMFmiWrapper")
oms3_addTLMBus("model.tlmexternal.source1.y", oms_tlm_domain_output, 1, default)

-- source2
oms3_addExternalModel("model.tlmexternal.source2", "../FMUs/source.fmu", "./StartTLMFmiWrapper")
oms3_addTLMBus("model.tlmexternal.source2.y", oms_tlm_domain_output, 1, default)

-- gain
oms3_addExternalModel("model.tlmexternal.gain", "../FMUs/gain.fmu", "./StartTLMFmiWrapper")
oms3_addTLMBus("model.tlmexternal.gain.y",    oms_tlm_domain_input, 1, default)
oms3_addTLMBus("model.tlmexternal.gain.u",    oms_tlm_domain_output, 1, default)

-- connections
oms3_addTLMConnection("model.tlmexternal.adder.x1", "model.tlmexternal.source2.y", 0,0,0,0)
oms3_addTLMConnection("model.tlmexternal.adder.x2", "model.tlmexternal.source1.y", 0,0,0,0)
oms3_addTLMConnection("model.tlmexternal.gain.y", "model.tlmexternal.adder.y",     0,0,0,0)

-- simulation parameters
oms3_setTLMSocketData("model.tlmexternal","127.0.1.1",13311,13411)
oms3_setStartTime("model", 0.5)
oms3_setStopTime("model", 4)

-- execute
oms3_instantiate("model");
oms3_initialize("model");
oms3_simulate("model");
oms3_terminate("model");

 vars = {"adder.y","source1.y","source2.y"}
 for _,var in ipairs(vars) do
   if 1 == oms3_compareSimulationResults("tlmexternal.csv", "../ReferenceFiles/tlmexternal.csv", var, 1e-2, 1e-4) then
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
-- info:    Logging information has been saved to "tlmexternal.log"
-- endResult
