-- status: correct
-- teardown_command:
-- linux: yes
-- mingw: yes
-- win: yes
-- mac: yes

oms3_setCommandLineOption("--suppressPath=true")

function printStatus(status, expected)
  cmp = ""
  if status == expected then
    cmp = "correct"
  else
    cmp = "wrong"
  end

  if 0 == status then
    status = "ok"
  elseif 1 == status then
    status = "warning"
  elseif 3 == status then
    status = "error"
  end
  print("status:  [" .. cmp .. "] " .. status)
end

status = oms3_setTempDirectory(".")
printStatus(status, 0)

status = oms3_newModel("model")
printStatus(status, 0)

status = oms3_addSystem("model.tlm", oms_system_tlm)
printStatus(status, 0)

status = oms3_addSystem("model.tlm.wc1", oms_system_wc)
printStatus(status, 0)

status = oms3_addSystem("model.tlm.wc2", oms_system_wc)
printStatus(status, 0)

status = oms3_addConnector("model.tlm.wc1.u1", input, oms_signal_type_real)
status = oms3_addConnector("model.tlm.wc1.u2", input, oms_signal_type_real)
status = oms3_addConnector("model.tlm.wc1.y", output, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addConnector("model.tlm.wc2.y1", output, oms_signal_type_real)
status = oms3_addConnector("model.tlm.wc2.y2", output, oms_signal_type_integer)
status = oms3_addConnector("model.tlm.wc2.y3", output, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addConnection("model.tlm.wc1.u1", "model.tlm.wc2.y1")
printStatus(status, 0)

--Connecting input to input (illegal)
status = oms3_addConnection("model.tlm.wc1.y", "model.tlm.wc2.y3")
printStatus(status, 3)

--Connecting Real to Integer (illegal)
status = oms3_addConnection("model.tlm.wc1.u2", "model.tlm.wc2.y2")
printStatus(status, 3)

--Connecting to already connected connector (illegal)
status = oms3_addConnection("model.tlm.wc1.u1", "model.tlm.wc2.y3")
printStatus(status, 3)

src, status = oms3_list("model.tlm")
print(src)

status = oms3_delete("model")
printStatus(status, 0)

-- Result:
-- info:    Set temp directory to    <suppressed>
-- info:    Set working directory to <suppressed>
-- info:    Set temp directory to    <suppressed>
-- status:  [correct] ok
-- info:    New model "model" with corresponding temp directory <suppressed>
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- error:   [addConnection] Causality mismatch in connection: wc1.y -> wc2.y3
-- status:  [correct] error
-- error:   [addConnection] Type mismatch in connection: wc1.u2 -> wc2.y2
-- status:  [correct] error
-- error:   [addConnection] Connector is already connected: wc1.u1
-- status:  [correct] error
-- <?xml version="1.0"?>
-- <ssd:System name="tlm">
-- 	<ssd:SimulationInformation>
-- 		<ssd:Annotation type="org.openmodelica">
-- 			<tlm:Master />
-- 		</ssd:Annotation>
-- 	</ssd:SimulationInformation>
-- 	<ssd:Elements>
-- 		<ssd:System name="wc2">
-- 			<ssd:SimulationInformation>
-- 				<FixedStepMaster description="oms-ma" stepSize="1e-1" />
-- 			</ssd:SimulationInformation>
-- 			<ssd:Elements />
-- 			<ssd:Connectors>
-- 				<ssd:Connector name="y1" kind="output" type="Real" />
-- 				<ssd:Connector name="y2" kind="output" type="Integer" />
-- 				<ssd:Connector name="y3" kind="output" type="Real" />
-- 			</ssd:Connectors>
-- 			<ssd:Connections />
-- 		</ssd:System>
-- 		<ssd:System name="wc1">
-- 			<ssd:SimulationInformation>
-- 				<FixedStepMaster description="oms-ma" stepSize="1e-1" />
-- 			</ssd:SimulationInformation>
-- 			<ssd:Elements />
-- 			<ssd:Connectors>
-- 				<ssd:Connector name="u1" kind="input" type="Real" />
-- 				<ssd:Connector name="u2" kind="input" type="Real" />
-- 				<ssd:Connector name="y" kind="output" type="Real" />
-- 			</ssd:Connectors>
-- 			<ssd:Connections />
-- 		</ssd:System>
-- 	</ssd:Elements>
-- 	<ssd:Connectors />
-- 	<ssd:Connections>
-- 		<ssd:Connection startElement="wc1" startConnector="u1" endElement="wc2" endConnector="y1" />
-- 	</ssd:Connections>
-- </ssd:System>
--
-- status:  [correct] ok
-- info:    0 warnings
-- info:    3 errors
-- endResult
