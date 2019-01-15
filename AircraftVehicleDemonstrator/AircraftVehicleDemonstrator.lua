-- status: correct
-- teardown_command: rm -rf AircraftVehicleDemonstrator_tmp/ AircraftVehicleDemonstrator.log AircraftVehicleDemonstrator*.dot AircraftVehicleDemonstrator_res.mat
-- linux: no
-- mingw: yes
-- win: yes

oms3_setLoggingLevel(0)
oms3_setCommandLineOption("--suppressPath=true")
oms3_setLogFile("AircraftVehicleDemonstrator.log")
oms3_setTempDirectory("./AircraftVehicleDemonstrator_tmp/")

oms3_newModel("AircraftVehicleDemonstrator")
oms3_addSystem("AircraftVehicleDemonstrator.root", oms_system_wc)


-- instantiate FMUs
oms3_addSubModel("AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf", "FMUs/Atmosphere_Model_FMU_sf.fmu")
oms3_addSubModel("AircraftVehicleDemonstrator.root.bC", "FMUs/bC.fmu")
oms3_addSubModel("AircraftVehicleDemonstrator.root.cockpit", "FMUs/cockpit.fmu")
oms3_addSubModel("AircraftVehicleDemonstrator.root.consumer_A", "FMUs/consumer_A.fmu")
oms3_addSubModel("AircraftVehicleDemonstrator.root.consumer_B", "FMUs/consumer_B.fmu")
oms3_addSubModel("AircraftVehicleDemonstrator.root.eCS_Generic_Export", "FMUs/eCS_Generic_Export.fmu")
oms3_addSubModel("AircraftVehicleDemonstrator.root.eCS_SW", "FMUs/eCS_SW.fmu")
oms3_addSubModel("AircraftVehicleDemonstrator.root.engine", "FMUs/engine.fmu")

-- connections (input to eCS_Generic_Export)
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.CABIN_TEMP_REQ_POS", "AircraftVehicleDemonstrator.root.eCS_SW.CABIN_TEMP_REQ_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.CABIN_TEMP_CMD_INH", "AircraftVehicleDemonstrator.root.eCS_SW.CABIN_TEMP_CMD_INH")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.DistrA_REQ_POS", "AircraftVehicleDemonstrator.root.eCS_SW.DistrA_REQ_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.DistrA_CMD_INH", "AircraftVehicleDemonstrator.root.eCS_SW.DistrA_CMD_INH")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.CABIN_FLOW_REQ_POS", "AircraftVehicleDemonstrator.root.eCS_SW.CABIN_FLOW_REQ_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.CABIN_FLOW_CMD_INH", "AircraftVehicleDemonstrator.root.eCS_SW.CABIN_FLOW_CMD_INH")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PACK_TEMP_REQ_POS", "AircraftVehicleDemonstrator.root.eCS_SW.PACK_TEMP_REQ_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PACK_TEMP_CMD_INH", "AircraftVehicleDemonstrator.root.eCS_SW.PACK_TEMP_CMD_INH")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.EJECTOR_V_CMD", "AircraftVehicleDemonstrator.root.eCS_SW.EJECTOR_V_CMD")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.EJECTOR_CMD_INH", "AircraftVehicleDemonstrator.root.eCS_SW.EJECTOR_CMD_INH")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PACK_PRESS_REQ_POS", "AircraftVehicleDemonstrator.root.eCS_SW.PACK_PRESS_REQ_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PACK_PRESS_CMD_INH", "AircraftVehicleDemonstrator.root.eCS_SW.PACK_PRESS_CMD_INH")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.DistrB_V_CMD_OPEN", "AircraftVehicleDemonstrator.root.eCS_SW.DistrB_V_CMD_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.DistrB_V_CMD_CLOSE", "AircraftVehicleDemonstrator.root.eCS_SW.DistrB_V_CMD_CLOSE")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PRSOV_CMD_OPEN_HOLD", "AircraftVehicleDemonstrator.root.eCS_SW.PRSOV_CMD_OPEN_HOLD")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.RAMAIR_V_CMD_CLOSE", "AircraftVehicleDemonstrator.root.eCS_SW.RAMAIR_V_CMD_CLOSE")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.Alt", "AircraftVehicleDemonstrator.root.bC.Alt")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.Mach", "AircraftVehicleDemonstrator.root.bC.Mach")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.pBleedAPU", "AircraftVehicleDemonstrator.root.bC.pBleedAPU")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.TbleedAPU", "AircraftVehicleDemonstrator.root.bC.TBleedAPU")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.CanopyClosed", "AircraftVehicleDemonstrator.root.bC.CanopyClosed")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.Tamb", "AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Out_t_oat")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.Pamb", "AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Out_p_oap")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.Tfrict", "AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Out_t_stag")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.Psat", "AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Out_psat_a")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitA.m", "AircraftVehicleDemonstrator.root.cockpit.portA.m")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitA.hn", "AircraftVehicleDemonstrator.root.cockpit.portA.hn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitA.xsn", "AircraftVehicleDemonstrator.root.cockpit.portA.xsn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitA.xwn", "AircraftVehicleDemonstrator.root.cockpit.portA.xwn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitB.m", "AircraftVehicleDemonstrator.root.cockpit.portB.m")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitB.hn", "AircraftVehicleDemonstrator.root.cockpit.portB.hn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitB.xsn", "AircraftVehicleDemonstrator.root.cockpit.portB.xsn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitB.xwn", "AircraftVehicleDemonstrator.root.cockpit.portB.xwn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerA.m", "AircraftVehicleDemonstrator.root.consumer_A.pin.m")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerA.hn", "AircraftVehicleDemonstrator.root.consumer_A.pin.hn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerA.xsn", "AircraftVehicleDemonstrator.root.consumer_A.pin.xsn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerA.xwn", "AircraftVehicleDemonstrator.root.consumer_A.pin.xwn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerB.m", "AircraftVehicleDemonstrator.root.consumer_B.pin.m")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerB.hn", "AircraftVehicleDemonstrator.root.consumer_B.pin.hn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerB.xsn", "AircraftVehicleDemonstrator.root.consumer_B.pin.xsn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerB.xwn", "AircraftVehicleDemonstrator.root.consumer_B.pin.xwn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortBleedA.m", "AircraftVehicleDemonstrator.root.engine.pB.m")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortBleedA.hn", "AircraftVehicleDemonstrator.root.engine.pB.hn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortBleedA.xsn", "AircraftVehicleDemonstrator.root.engine.pB.xsn")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortBleedA.xwn", "AircraftVehicleDemonstrator.root.engine.pB.xwn")

-- connections (input to eCS_SW)
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_PACK_TEMP_V_POS_OPEN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_TEMP_V_POS_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_PACK_TEMP_V_POS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_TEMP_V_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CABIN_FLOW_V_POS_CLOSED", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CABIN_FLOW_V_POS_CLOSED")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CABIN_FLOW_V_POS_OPEN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CABIN_FLOW_V_POS_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CABIN_FLOW_V_POS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CABIN_FLOW_V_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_DistrA_FLOW_V_POS_CLOSED", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_DistrA_FLOW_V_POS_CLOSED")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_DistrA_FLOW_V_POS_OPEN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_DistrA_FLOW_V_POS_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CABIN_TEMP_V_POS_CLOSED", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CABIN_TEMP_V_POS_CLOSED")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CABIN_TEMP_V_POS_OPEN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CABIN_TEMP_V_POS_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CABIN_TEMP_V_POS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CABIN_TEMP_V_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_COND_LO_DIFF_PRESS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_COND_LO_DIFF_PRESS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_COND_HIGH_DIFF_PRESS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_COND_HIGH_DIFF_PRESS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_OVERPRESS_SWITCH", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_OVERPRESS_SWITCH")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_PACK_PRESS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_PRESS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_DistrA_FLOW_V_POS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_DistrA_FLOW_V_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_PACK_PRESS_V_POS_OPEN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_PRESS_V_POS_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_PACK_PRESS_V_POS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_PRESS_V_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_EJECTOR_V_POS_CLOSED", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_EJECTOR_V_POS_CLOSED")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_EJECTOR_V_POS_OPEN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_EJECTOR_V_POS_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_EJECTOR_V_POS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_EJECTOR_V_POS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_PACK_TEMP_V_POS_CLOSED", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_TEMP_V_POS_CLOSED")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_COMPR_INLET_TEMP", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_COMPR_INLET_TEMP")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_DistrA_INLET_OVERTEMP", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_DistrA_INLET_OVERTEMP")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CAB_INLET_TEMP", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CAB_INLET_TEMP")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_DistrA_INLET_TEMP", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_DistrA_INLET_TEMP")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_PACK_TEMP", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_TEMP")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CABIN_FLOW_SIGN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CABIN_FLOW_SIGN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_CABIN_PRESS", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_CABIN_PRESS")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_DisrtA_FLOW", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_DisrtA_FLOW")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_RAMAIR_V_POS_OPEN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_RAMAIR_V_POS_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_DistrB_V_POS_CLOSED", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_DistrB_V_POS_CLOSED")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_DistrB_V_POS_OPEN", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_DistrB_V_POS_OPEN")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_PACK_PRESS_V_POS_CLOSED", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_PRESS_V_POS_CLOSED")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Meas_RAMAIR_V_POS_CLOSED", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_RAMAIR_V_POS_CLOSED")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Altitude", "AircraftVehicleDemonstrator.root.bC.Alt")
oms3_addConnection("AircraftVehicleDemonstrator.root.eCS_SW.Mach", "AircraftVehicleDemonstrator.root.bC.Mach")

-- connections (input to engine)
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.Mach", "AircraftVehicleDemonstrator.root.bC.Mach")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.Altitude", "AircraftVehicleDemonstrator.root.bC.Alt")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.Tamb", "AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Out_t_oat")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.Pamb", "AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Out_p_oap")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.Tfrict", "AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Out_t_stag")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.Psat", "AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Out_psat_a")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.pB.p", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortBleedA.p")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.pB.h", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortBleedA.h")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.pB.xs", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortBleedA.xs")
oms3_addConnection("AircraftVehicleDemonstrator.root.engine.pB.xw", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortBleedA.xw")

-- connections (input to consumer_A)
oms3_addConnection("AircraftVehicleDemonstrator.root.consumer_A.pin.p", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerA.p")
oms3_addConnection("AircraftVehicleDemonstrator.root.consumer_A.pin.h", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerA.h")
oms3_addConnection("AircraftVehicleDemonstrator.root.consumer_A.pin.xs", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerA.xs")
oms3_addConnection("AircraftVehicleDemonstrator.root.consumer_A.pin.xw", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerA.xw")

-- connections (input to consumer_B)
oms3_addConnection("AircraftVehicleDemonstrator.root.consumer_B.pin.p", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerB.p")
oms3_addConnection("AircraftVehicleDemonstrator.root.consumer_B.pin.h", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerB.h")
oms3_addConnection("AircraftVehicleDemonstrator.root.consumer_B.pin.xs", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerB.xs")
oms3_addConnection("AircraftVehicleDemonstrator.root.consumer_B.pin.xw", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortConsumerB.xw")

-- connections (input to cockpit)
oms3_addConnection("AircraftVehicleDemonstrator.root.cockpit.portA.p", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitA.p")
oms3_addConnection("AircraftVehicleDemonstrator.root.cockpit.portA.h", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitA.h")
oms3_addConnection("AircraftVehicleDemonstrator.root.cockpit.portA.xs", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitA.xs")
oms3_addConnection("AircraftVehicleDemonstrator.root.cockpit.portA.xw", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitA.xw")
oms3_addConnection("AircraftVehicleDemonstrator.root.cockpit.portB.p", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitB.p")
oms3_addConnection("AircraftVehicleDemonstrator.root.cockpit.portB.h", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitB.h")
oms3_addConnection("AircraftVehicleDemonstrator.root.cockpit.portB.xs", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitB.xs")
oms3_addConnection("AircraftVehicleDemonstrator.root.cockpit.portB.xw", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.PortCockpitB.xw")

-- connections (input to atmosphere_Model_FMU_sf)
oms3_addConnection("AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Mach", "AircraftVehicleDemonstrator.root.bC.Mach")
oms3_addConnection("AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Alt", "AircraftVehicleDemonstrator.root.bC.Alt")

-- simulation settings
oms3_setTolerance("AircraftVehicleDemonstrator.root", 1e-6)
oms3_setStopTime("AircraftVehicleDemonstrator", 1)

oms3_instantiate("AircraftVehicleDemonstrator")

-- set parameters
oms3_setReal("AircraftVehicleDemonstrator.root.atmosphere_Model_FMU_sf.Parameters.Atmos.Value", 6) -- Hot climate

oms3_setSignalFilter("AircraftVehicleDemonstrator", "AircraftVehicleDemonstrator\\.root\\.(engine\\.pB\\.p|eCS_Generic_Export\\.Meas_PACK_TEMP|eCS_Generic_Export\\.Meas_PACK_PRESS)")
oms3_initialize("AircraftVehicleDemonstrator")

oms3_setFixedStepSize("AircraftVehicleDemonstrator.root", 1e-4)
oms3_stepUntil("AircraftVehicleDemonstrator", 1e-2)
oms3_setFixedStepSize("AircraftVehicleDemonstrator.root", 1e-3)
oms3_simulate("AircraftVehicleDemonstrator")

oms3_terminate("AircraftVehicleDemonstrator")
oms3_delete("AircraftVehicleDemonstrator")

vars = {"AircraftVehicleDemonstrator.root.engine.pB.p", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_TEMP", "AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_PRESS"}
for _,var in ipairs(vars) do
  if 1 == oms3_compareSimulationResults("AircraftVehicleDemonstrator_res.mat", "../ReferenceFiles/AircraftVehicleDemonstrator.mat", var, 1e-2, 1e-4) then
    print("info:    " .. var .. " is equal")
  else
    print("warning: " .. var .. " is not equal")
  end
end

-- Result:
-- info:    AircraftVehicleDemonstrator.root.engine.pB.p is equal
-- info:    AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_TEMP is equal
-- info:    AircraftVehicleDemonstrator.root.eCS_Generic_Export.Meas_PACK_PRESS is equal
-- info:    Logging information has been saved to "AircraftVehicleDemonstrator.log"
-- endResult
