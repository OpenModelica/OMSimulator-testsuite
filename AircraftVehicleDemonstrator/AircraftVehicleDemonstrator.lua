-- status: correct
-- teardown_command: rm -rf AircraftVehicleDemonstrator_tmp/ AircraftVehicleDemonstrator.log AircraftVehicleDemonstrator*.dot AircraftVehicleDemonstrator_res.mat
-- linux: no
-- mingw: yes
-- win: yes

oms2_setLoggingLevel(0)
oms2_setLogFile("AircraftVehicleDemonstrator.log")
oms2_setTempDirectory("./AircraftVehicleDemonstrator_tmp")

oms2_newFMIModel("AircraftVehicleDemonstrator")

-- instantiate FMUs
oms2_addFMU("AircraftVehicleDemonstrator", "FMUs/Atmosphere_Model_FMU_sf.fmu", "atmosphere_Model_FMU_sf")
oms2_addFMU("AircraftVehicleDemonstrator", "FMUs/bC.fmu", "bC")
oms2_addFMU("AircraftVehicleDemonstrator", "FMUs/cockpit.fmu", "cockpit")
oms2_addFMU("AircraftVehicleDemonstrator", "FMUs/consumer_A.fmu", "consumer_A")
oms2_addFMU("AircraftVehicleDemonstrator", "FMUs/consumer_B.fmu", "consumer_B")
oms2_addFMU("AircraftVehicleDemonstrator", "FMUs/eCS_Generic_Export.fmu", "eCS_Generic_Export")
oms2_addFMU("AircraftVehicleDemonstrator", "FMUs/eCS_SW.fmu", "eCS_SW")
oms2_addFMU("AircraftVehicleDemonstrator", "FMUs/engine.fmu", "engine")

-- connections (input to eCS_Generic_Export)
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:CABIN_TEMP_REQ_POS", "eCS_SW:CABIN_TEMP_REQ_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:CABIN_TEMP_CMD_INH", "eCS_SW:CABIN_TEMP_CMD_INH")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:DistrA_REQ_POS", "eCS_SW:DistrA_REQ_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:DistrA_CMD_INH", "eCS_SW:DistrA_CMD_INH")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:CABIN_FLOW_REQ_POS", "eCS_SW:CABIN_FLOW_REQ_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:CABIN_FLOW_CMD_INH", "eCS_SW:CABIN_FLOW_CMD_INH")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PACK_TEMP_REQ_POS", "eCS_SW:PACK_TEMP_REQ_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PACK_TEMP_CMD_INH", "eCS_SW:PACK_TEMP_CMD_INH")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:EJECTOR_V_CMD", "eCS_SW:EJECTOR_V_CMD")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:EJECTOR_CMD_INH", "eCS_SW:EJECTOR_CMD_INH")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PACK_PRESS_REQ_POS", "eCS_SW:PACK_PRESS_REQ_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PACK_PRESS_CMD_INH", "eCS_SW:PACK_PRESS_CMD_INH")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:DistrB_V_CMD_OPEN", "eCS_SW:DistrB_V_CMD_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:DistrB_V_CMD_CLOSE", "eCS_SW:DistrB_V_CMD_CLOSE")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PRSOV_CMD_OPEN_HOLD", "eCS_SW:PRSOV_CMD_OPEN_HOLD")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:RAMAIR_V_CMD_CLOSE", "eCS_SW:RAMAIR_V_CMD_CLOSE")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:Alt", "bC:Alt")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:Mach", "bC:Mach")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:pBleedAPU", "bC:pBleedAPU")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:TbleedAPU", "bC:TBleedAPU")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:CanopyClosed", "bC:CanopyClosed")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:Tamb", "atmosphere_Model_FMU_sf:Out_t_oat")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:Pamb", "atmosphere_Model_FMU_sf:Out_p_oap")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:Tfrict", "atmosphere_Model_FMU_sf:Out_t_stag")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:Psat", "atmosphere_Model_FMU_sf:Out_psat_a")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortCockpitA.m", "cockpit:portA.m")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortCockpitA.hn", "cockpit:portA.hn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortCockpitA.xsn", "cockpit:portA.xsn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortCockpitA.xwn", "cockpit:portA.xwn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortCockpitB.m", "cockpit:portB.m")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortCockpitB.hn", "cockpit:portB.hn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortCockpitB.xsn", "cockpit:portB.xsn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortCockpitB.xwn", "cockpit:portB.xwn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortConsumerA.m", "consumer_A:pin.m")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortConsumerA.hn", "consumer_A:pin.hn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortConsumerA.xsn", "consumer_A:pin.xsn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortConsumerA.xwn", "consumer_A:pin.xwn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortConsumerB.m", "consumer_B:pin.m")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortConsumerB.hn", "consumer_B:pin.hn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortConsumerB.xsn", "consumer_B:pin.xsn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortConsumerB.xwn", "consumer_B:pin.xwn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortBleedA.m", "engine:pB.m")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortBleedA.hn", "engine:pB.hn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortBleedA.xsn", "engine:pB.xsn")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_Generic_Export:PortBleedA.xwn", "engine:pB.xwn")

-- connections (input to eCS_SW)
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_PACK_TEMP_V_POS_OPEN", "eCS_Generic_Export:Meas_PACK_TEMP_V_POS_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_PACK_TEMP_V_POS", "eCS_Generic_Export:Meas_PACK_TEMP_V_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CABIN_FLOW_V_POS_CLOSED", "eCS_Generic_Export:Meas_CABIN_FLOW_V_POS_CLOSED")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CABIN_FLOW_V_POS_OPEN", "eCS_Generic_Export:Meas_CABIN_FLOW_V_POS_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CABIN_FLOW_V_POS", "eCS_Generic_Export:Meas_CABIN_FLOW_V_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_DistrA_FLOW_V_POS_CLOSED", "eCS_Generic_Export:Meas_DistrA_FLOW_V_POS_CLOSED")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_DistrA_FLOW_V_POS_OPEN", "eCS_Generic_Export:Meas_DistrA_FLOW_V_POS_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CABIN_TEMP_V_POS_CLOSED", "eCS_Generic_Export:Meas_CABIN_TEMP_V_POS_CLOSED")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CABIN_TEMP_V_POS_OPEN", "eCS_Generic_Export:Meas_CABIN_TEMP_V_POS_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CABIN_TEMP_V_POS", "eCS_Generic_Export:Meas_CABIN_TEMP_V_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_COND_LO_DIFF_PRESS", "eCS_Generic_Export:Meas_COND_LO_DIFF_PRESS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_COND_HIGH_DIFF_PRESS", "eCS_Generic_Export:Meas_COND_HIGH_DIFF_PRESS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_OVERPRESS_SWITCH", "eCS_Generic_Export:Meas_OVERPRESS_SWITCH")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_PACK_PRESS", "eCS_Generic_Export:Meas_PACK_PRESS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_DistrA_FLOW_V_POS", "eCS_Generic_Export:Meas_DistrA_FLOW_V_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_PACK_PRESS_V_POS_OPEN", "eCS_Generic_Export:Meas_PACK_PRESS_V_POS_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_PACK_PRESS_V_POS", "eCS_Generic_Export:Meas_PACK_PRESS_V_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_EJECTOR_V_POS_CLOSED", "eCS_Generic_Export:Meas_EJECTOR_V_POS_CLOSED")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_EJECTOR_V_POS_OPEN", "eCS_Generic_Export:Meas_EJECTOR_V_POS_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_EJECTOR_V_POS", "eCS_Generic_Export:Meas_EJECTOR_V_POS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_PACK_TEMP_V_POS_CLOSED", "eCS_Generic_Export:Meas_PACK_TEMP_V_POS_CLOSED")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_COMPR_INLET_TEMP", "eCS_Generic_Export:Meas_COMPR_INLET_TEMP")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_DistrA_INLET_OVERTEMP", "eCS_Generic_Export:Meas_DistrA_INLET_OVERTEMP")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CAB_INLET_TEMP", "eCS_Generic_Export:Meas_CAB_INLET_TEMP")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_DistrA_INLET_TEMP", "eCS_Generic_Export:Meas_DistrA_INLET_TEMP")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_PACK_TEMP", "eCS_Generic_Export:Meas_PACK_TEMP")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CABIN_FLOW_SIGN", "eCS_Generic_Export:Meas_CABIN_FLOW_SIGN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_CABIN_PRESS", "eCS_Generic_Export:Meas_CABIN_PRESS")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_DisrtA_FLOW", "eCS_Generic_Export:Meas_DisrtA_FLOW")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_RAMAIR_V_POS_OPEN", "eCS_Generic_Export:Meas_RAMAIR_V_POS_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_DistrB_V_POS_CLOSED", "eCS_Generic_Export:Meas_DistrB_V_POS_CLOSED")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_DistrB_V_POS_OPEN", "eCS_Generic_Export:Meas_DistrB_V_POS_OPEN")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_PACK_PRESS_V_POS_CLOSED", "eCS_Generic_Export:Meas_PACK_PRESS_V_POS_CLOSED")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Meas_RAMAIR_V_POS_CLOSED", "eCS_Generic_Export:Meas_RAMAIR_V_POS_CLOSED")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Altitude", "bC:Alt")
oms2_addConnection("AircraftVehicleDemonstrator", "eCS_SW:Mach", "bC:Mach")

-- connections (input to engine)
oms2_addConnection("AircraftVehicleDemonstrator", "engine:Mach", "bC:Mach")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:Altitude", "bC:Alt")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:Tamb", "atmosphere_Model_FMU_sf:Out_t_oat")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:Pamb", "atmosphere_Model_FMU_sf:Out_p_oap")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:Tfrict", "atmosphere_Model_FMU_sf:Out_t_stag")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:Psat", "atmosphere_Model_FMU_sf:Out_psat_a")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:pB.p", "eCS_Generic_Export:PortBleedA.p")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:pB.h", "eCS_Generic_Export:PortBleedA.h")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:pB.xs", "eCS_Generic_Export:PortBleedA.xs")
oms2_addConnection("AircraftVehicleDemonstrator", "engine:pB.xw", "eCS_Generic_Export:PortBleedA.xw")

-- connections (input to consumer_A)
oms2_addConnection("AircraftVehicleDemonstrator", "consumer_A:pin.p", "eCS_Generic_Export:PortConsumerA.p")
oms2_addConnection("AircraftVehicleDemonstrator", "consumer_A:pin.h", "eCS_Generic_Export:PortConsumerA.h")
oms2_addConnection("AircraftVehicleDemonstrator", "consumer_A:pin.xs", "eCS_Generic_Export:PortConsumerA.xs")
oms2_addConnection("AircraftVehicleDemonstrator", "consumer_A:pin.xw", "eCS_Generic_Export:PortConsumerA.xw")

-- connections (input to consumer_B)
oms2_addConnection("AircraftVehicleDemonstrator", "consumer_B:pin.p", "eCS_Generic_Export:PortConsumerB.p")
oms2_addConnection("AircraftVehicleDemonstrator", "consumer_B:pin.h", "eCS_Generic_Export:PortConsumerB.h")
oms2_addConnection("AircraftVehicleDemonstrator", "consumer_B:pin.xs", "eCS_Generic_Export:PortConsumerB.xs")
oms2_addConnection("AircraftVehicleDemonstrator", "consumer_B:pin.xw", "eCS_Generic_Export:PortConsumerB.xw")

-- connections (input to cockpit)
oms2_addConnection("AircraftVehicleDemonstrator", "cockpit:portA.p", "eCS_Generic_Export:PortCockpitA.p")
oms2_addConnection("AircraftVehicleDemonstrator", "cockpit:portA.h", "eCS_Generic_Export:PortCockpitA.h")
oms2_addConnection("AircraftVehicleDemonstrator", "cockpit:portA.xs", "eCS_Generic_Export:PortCockpitA.xs")
oms2_addConnection("AircraftVehicleDemonstrator", "cockpit:portA.xw", "eCS_Generic_Export:PortCockpitA.xw")
oms2_addConnection("AircraftVehicleDemonstrator", "cockpit:portB.p", "eCS_Generic_Export:PortCockpitB.p")
oms2_addConnection("AircraftVehicleDemonstrator", "cockpit:portB.h", "eCS_Generic_Export:PortCockpitB.h")
oms2_addConnection("AircraftVehicleDemonstrator", "cockpit:portB.xs", "eCS_Generic_Export:PortCockpitB.xs")
oms2_addConnection("AircraftVehicleDemonstrator", "cockpit:portB.xw", "eCS_Generic_Export:PortCockpitB.xw")

-- connections (input to atmosphere_Model_FMU_sf)
oms2_addConnection("AircraftVehicleDemonstrator", "atmosphere_Model_FMU_sf:Mach", "bC:Mach")
oms2_addConnection("AircraftVehicleDemonstrator", "atmosphere_Model_FMU_sf:Alt", "bC:Alt")

-- set parameters
oms2_setRealParameter("AircraftVehicleDemonstrator.atmosphere_Model_FMU_sf:Parameters.Atmos.Value", 6) -- Hot climate

-- simulation settings
--oms2_setResultFile("AircraftVehicleDemonstrator", "demoM27BB_step1e3_tol1e4_20s.mat")
--oms2_setTolerance("AircraftVehicleDemonstrator", 1e-4)
oms2_setStopTime("AircraftVehicleDemonstrator", 1)

oms2_exportCompositeStructure("AircraftVehicleDemonstrator", "AircraftVehicleDemonstrator.dot")
--os.execute("dot -Gsplines=none AircraftVehicleDemonstrator.dot | neato -n -Gsplines=ortho -Tpdf -oAircraftVehicleDemonstrator.pdf")

oms2_initialize("AircraftVehicleDemonstrator")

oms2_exportDependencyGraphs("AircraftVehicleDemonstrator", "AircraftVehicleDemonstrator_initialUnknowns.dot", "AircraftVehicleDemonstrator_outputs.dot")
--os.execute("gvpr -c \"N[$.degree==0]{delete(root, $)}\" AircraftVehicleDemonstrator_initialUnknowns.dot | dot -Tpdf -o AircraftVehicleDemonstrator_initialUnknowns.pdf")
--os.execute("gvpr -c \"N[$.degree==0]{delete(root, $)}\" AircraftVehicleDemonstrator_outputs.dot | dot -Tpdf -o AircraftVehicleDemonstrator_outputs.pdf")

oms2_setCommunicationInterval("AircraftVehicleDemonstrator", 1e-4)
oms2_stepUntil("AircraftVehicleDemonstrator", 1e-3)
oms2_setCommunicationInterval("AircraftVehicleDemonstrator", 1e-3)
oms2_simulate("AircraftVehicleDemonstrator")

oms2_unloadModel("AircraftVehicleDemonstrator")

vars = {"engine.pB.p", "eCS_Generic_Export.Meas_PACK_TEMP", "eCS_Generic_Export.Meas_PACK_PRESS"}
for _,var in ipairs(vars) do
  if 1 == oms2_compareSimulationResults("AircraftVehicleDemonstrator_res.mat", "../ReferenceFiles/AircraftVehicleDemonstrator.mat", var, 1e-2, 1e-4) then
    print("info:    " .. var .. " is equal")
  else
    print("warning: " .. var .. " is not equal")
  end
end

-- Result:
-- info:    engine.pB.p is equal
-- info:    eCS_Generic_Export.Meas_PACK_TEMP is equal
-- info:    eCS_Generic_Export.Meas_PACK_PRESS is equal
-- info:    Logging information has been saved to "AircraftVehicleDemonstrator.log"
-- endResult
