-- status: correct
-- teardown_command: rm -rf test.ssp import_export/
-- linux: yes
-- mingw: yes
-- win: yes
-- mac: yes

oms3_setCommandLineOption("--suppressPath=true")
oms3_setTempDirectory("./import_export/")

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

status = oms3_newModel("test")
printStatus(status, 0)

status = oms3_addSystem("test.eoo", oms_system_tlm)
printStatus(status, 0)

status = oms3_addSystem("test.eoo.foo", oms_system_wc)
printStatus(status, 0)

-- CS FMU
status = oms3_addSubModel("test.eoo.foo.A", "../FMUs/source.fmu")
printStatus(status, 0)

status = oms3_addSystem("test.eoo.foo.goo", oms_system_sc)
printStatus(status, 0)

status = oms3_addSystem("test.eoo.foo2", oms_system_wc)
printStatus(status, 0)

status = oms3_addConnector("test.eoo.foo.f", input, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addConnector("test.eoo.foo.x", output, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addConnector("test.eoo.foo.v", output, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addConnector("test.eoo.foo.y1", output, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addConnector("test.eoo.foo.y2", output, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addTLMBus("test.eoo.foo.tlm", "mechanical", 1, default)
printStatus(status, 0)

status = oms3_addConnectorToTLMBus("test.eoo.foo.tlm", "test.eoo.foo.f", "effort")
printStatus(status, 0)

status = oms3_addConnectorToTLMBus("test.eoo.foo.tlm", "test.eoo.foo.x", "state")
printStatus(status, 0)

status = oms3_addConnectorToTLMBus("test.eoo.foo.tlm", "test.eoo.foo.v", "flow")
printStatus(status, 0)

status = oms3_addBus("test.eoo.foo.bus")
printStatus(status, 0)

status = oms3_addConnectorToBus("test.eoo.foo.bus", "test.eoo.foo.y1")
printStatus(status, 0)

status = oms3_addConnectorToBus("test.eoo.foo.bus", "test.eoo.foo.y2")
printStatus(status, 0)

status = oms3_addConnector("test.eoo.foo2.f", input, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addConnector("test.eoo.foo2.x", output, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addConnector("test.eoo.foo2.v", output, oms_signal_type_real)
printStatus(status, 0)

status = oms3_addTLMBus("test.eoo.foo2.tlm", "mechanical", 1, default)
printStatus(status, 0)

status = oms3_addConnectorToTLMBus("test.eoo.foo2.tlm", "test.eoo.foo2.f", "effort")
printStatus(status, 0)

status = oms3_addConnectorToTLMBus("test.eoo.foo2.tlm", "test.eoo.foo2.x", "state")
printStatus(status, 0)

status = oms3_addConnectorToTLMBus("test.eoo.foo2.tlm", "test.eoo.foo2.v", "flow")
printStatus(status, 0)

status = oms3_addTLMConnection("test.eoo.foo.tlm", "test.eoo.foo2.tlm", 0.001, 0.3, 100, 0)
printStatus(status, 0)

src, status = oms3_list("test")
printStatus(status, 0)
print(src)

status = oms3_export("test", "test.ssp");
printStatus(status, 0)

status = oms3_delete("test")
printStatus(status, 0)

model, status = oms3_import("test.ssp");
printStatus(status, 0)

src, status = oms3_list(model)
printStatus(status, 0)
print(src)

status = oms3_delete(model)
printStatus(status, 0)


-- Result:
-- info:    Set temp directory to    <suppressed>
-- info:    Set working directory to <suppressed>
-- info:    Set temp directory to    <suppressed>
-- info:    New model "test" with corresponding temp directory <suppressed>
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- <?xml version="1.0"?>
-- <ssd:SystemStructureDescription name="test" version="Draft20180219">
-- 	<ssd:System name="eoo">
-- 		<ssd:SimulationInformation>
-- 			<ssd:Annotations>
-- 				<ssd:Annotation type="org.openmodelica">
-- 					<oms:TlmMaster />
-- 				</ssd:Annotation>
-- 			</ssd:Annotations>
-- 		</ssd:SimulationInformation>
-- 		<ssd:Elements>
-- 			<ssd:System name="foo2">
-- 				<ssd:SimulationInformation>
-- 					<FixedStepMaster description="oms-ma" stepSize="0.100000" />
-- 				</ssd:SimulationInformation>
-- 				<ssd:Elements />
-- 				<ssd:Connectors>
-- 					<ssd:Connector name="f" kind="input" type="Real" />
-- 					<ssd:Connector name="x" kind="output" type="Real" />
-- 					<ssd:Connector name="v" kind="output" type="Real" />
-- 				</ssd:Connectors>
-- 				<ssd:Connections />
-- 				<ssd:Annotations>
-- 					<ssd:Annotation type="org.openmodelica">
-- 						<oms:Bus name="tlm" type="tlm" domain="mechanical" dimensions="1" interpolation="none">
-- 							<oms:Signals>
-- 								<oms:Signal name="x" type="state" />
-- 								<oms:Signal name="v" type="flow" />
-- 								<oms:Signal name="f" type="effort" />
-- 							</oms:Signals>
-- 						</oms:Bus>
-- 					</ssd:Annotation>
-- 				</ssd:Annotations>
-- 			</ssd:System>
-- 			<ssd:System name="foo">
-- 				<ssd:SimulationInformation>
-- 					<FixedStepMaster description="oms-ma" stepSize="0.100000" />
-- 				</ssd:SimulationInformation>
-- 				<ssd:Elements>
-- 					<ssd:System name="goo">
-- 						<ssd:SimulationInformation>
-- 							<VariableStepSolver description="cvode" absoluteTolerance="0.000100" relativeTolerance="0.000100" minimumStepSize="0.000100" maximumStepSize="0.100000" initialStepSize="0.000100" />
-- 						</ssd:SimulationInformation>
-- 						<ssd:Elements />
-- 						<ssd:Connectors />
-- 						<ssd:Connections />
-- 					</ssd:System>
-- 					<ssd:Component name="A" type="application/x-fmu-sharedlibrary" source="resources/A.fmu">
-- 						<ssd:Connectors>
-- 							<ssd:Connector name="A.y" kind="output" type="Real">
-- 								<ssd:ConnectorGeometry x="1.000000" y="0.500000" />
-- 							</ssd:Connector>
-- 							<ssd:Connector name="A.A" kind="parameter" type="Real" />
-- 							<ssd:Connector name="A.omega" kind="parameter" type="Real" />
-- 						</ssd:Connectors>
-- 					</ssd:Component>
-- 				</ssd:Elements>
-- 				<ssd:Connectors>
-- 					<ssd:Connector name="f" kind="input" type="Real" />
-- 					<ssd:Connector name="x" kind="output" type="Real" />
-- 					<ssd:Connector name="v" kind="output" type="Real" />
-- 					<ssd:Connector name="y1" kind="output" type="Real" />
-- 					<ssd:Connector name="y2" kind="output" type="Real" />
-- 				</ssd:Connectors>
-- 				<ssd:Connections />
-- 				<ssd:Annotations>
-- 					<ssd:Annotation type="org.openmodelica">
-- 						<oms:Bus name="bus">
-- 							<oms:Signals>
-- 								<oms:Signal name="y1" />
-- 								<oms:Signal name="y2" />
-- 							</oms:Signals>
-- 						</oms:Bus>
-- 						<oms:Bus name="tlm" type="tlm" domain="mechanical" dimensions="1" interpolation="none">
-- 							<oms:Signals>
-- 								<oms:Signal name="x" type="state" />
-- 								<oms:Signal name="v" type="flow" />
-- 								<oms:Signal name="f" type="effort" />
-- 							</oms:Signals>
-- 						</oms:Bus>
-- 					</ssd:Annotation>
-- 				</ssd:Annotations>
-- 			</ssd:System>
-- 		</ssd:Elements>
-- 		<ssd:Connectors />
-- 		<ssd:Connections />
-- 		<ssd:Annotations>
-- 			<ssd:Annotation type="org.openmodelica">
-- 				<oms:Connections>
-- 					<oms:Connection startElement="foo" startConnector="tlm" endElement="foo2" endConnector="tlm" delay="0.001000" alpha="0.300000" linearimpedance="100.000000" angularimpedance="0.000000" />
-- 				</oms:Connections>
-- 			</ssd:Annotation>
-- 		</ssd:Annotations>
-- 	</ssd:System>
-- </ssd:SystemStructureDescription>
--
-- info:    Set working directory to <suppressed>
-- info:    Set working directory to <suppressed>
-- status:  [correct] ok
-- status:  [correct] ok
-- info:    Set working directory to <suppressed>
-- info:    New model "test" with corresponding temp directory <suppressed>
-- info:    Set working directory to <suppressed>
-- info:    Set working directory to <suppressed>
-- info:    Set working directory to <suppressed>
-- status:  [correct] ok
-- status:  [correct] ok
-- <?xml version="1.0"?>
-- <ssd:SystemStructureDescription name="test" version="Draft20180219">
-- 	<ssd:System name="eoo">
-- 		<ssd:SimulationInformation>
-- 			<ssd:Annotations>
-- 				<ssd:Annotation type="org.openmodelica">
-- 					<oms:TlmMaster />
-- 				</ssd:Annotation>
-- 			</ssd:Annotations>
-- 		</ssd:SimulationInformation>
-- 		<ssd:Elements>
-- 			<ssd:System name="foo2">
-- 				<ssd:SimulationInformation>
-- 					<FixedStepMaster description="oms-ma" stepSize="0.100000" />
-- 				</ssd:SimulationInformation>
-- 				<ssd:Elements />
-- 				<ssd:Connectors>
-- 					<ssd:Connector name="f" kind="input" type="Real" />
-- 					<ssd:Connector name="x" kind="output" type="Real" />
-- 					<ssd:Connector name="v" kind="output" type="Real" />
-- 				</ssd:Connectors>
-- 				<ssd:Connections />
-- 				<ssd:Annotations>
-- 					<ssd:Annotation type="org.openmodelica">
-- 						<oms:Bus name="tlm" type="tlm" domain="mechanical" dimensions="1" interpolation="none">
-- 							<oms:Signals>
-- 								<oms:Signal name="x" type="state" />
-- 								<oms:Signal name="v" type="flow" />
-- 								<oms:Signal name="f" type="effort" />
-- 							</oms:Signals>
-- 						</oms:Bus>
-- 					</ssd:Annotation>
-- 				</ssd:Annotations>
-- 			</ssd:System>
-- 			<ssd:System name="foo">
-- 				<ssd:SimulationInformation>
-- 					<FixedStepMaster description="oms-ma" stepSize="0.100000" />
-- 				</ssd:SimulationInformation>
-- 				<ssd:Elements>
-- 					<ssd:System name="goo">
-- 						<ssd:SimulationInformation>
-- 							<VariableStepSolver description="cvode" absoluteTolerance="0.000100" relativeTolerance="0.000100" minimumStepSize="0.000100" maximumStepSize="0.100000" initialStepSize="0.000100" />
-- 						</ssd:SimulationInformation>
-- 						<ssd:Elements />
-- 						<ssd:Connectors />
-- 						<ssd:Connections />
-- 					</ssd:System>
-- 					<ssd:Component name="A" type="application/x-fmu-sharedlibrary" source="resources/A.fmu">
-- 						<ssd:Connectors>
-- 							<ssd:Connector name="A.y" kind="output" type="Real">
-- 								<ssd:ConnectorGeometry x="1.000000" y="0.500000" />
-- 							</ssd:Connector>
-- 							<ssd:Connector name="A.A" kind="parameter" type="Real" />
-- 							<ssd:Connector name="A.omega" kind="parameter" type="Real" />
-- 						</ssd:Connectors>
-- 					</ssd:Component>
-- 				</ssd:Elements>
-- 				<ssd:Connectors>
-- 					<ssd:Connector name="f" kind="input" type="Real" />
-- 					<ssd:Connector name="x" kind="output" type="Real" />
-- 					<ssd:Connector name="v" kind="output" type="Real" />
-- 					<ssd:Connector name="y1" kind="output" type="Real" />
-- 					<ssd:Connector name="y2" kind="output" type="Real" />
-- 				</ssd:Connectors>
-- 				<ssd:Connections />
-- 				<ssd:Annotations>
-- 					<ssd:Annotation type="org.openmodelica">
-- 						<oms:Bus name="bus">
-- 							<oms:Signals>
-- 								<oms:Signal name="y1" />
-- 								<oms:Signal name="y2" />
-- 							</oms:Signals>
-- 						</oms:Bus>
-- 						<oms:Bus name="tlm" type="tlm" domain="mechanical" dimensions="1" interpolation="none">
-- 							<oms:Signals>
-- 								<oms:Signal name="x" type="state" />
-- 								<oms:Signal name="v" type="flow" />
-- 								<oms:Signal name="f" type="effort" />
-- 							</oms:Signals>
-- 						</oms:Bus>
-- 					</ssd:Annotation>
-- 				</ssd:Annotations>
-- 			</ssd:System>
-- 		</ssd:Elements>
-- 		<ssd:Connectors />
-- 		<ssd:Connections />
-- 		<ssd:Annotations>
-- 			<ssd:Annotation type="org.openmodelica">
-- 				<oms:Connections>
-- 					<oms:Connection startElement="foo" startConnector="tlm" endElement="foo2" endConnector="tlm" delay="0.001000" alpha="0.300000" linearimpedance="100.000000" angularimpedance="0.000000" />
-- 				</oms:Connections>
-- 			</ssd:Annotation>
-- 		</ssd:Annotations>
-- 	</ssd:System>
-- </ssd:SystemStructureDescription>
--
-- status:  [correct] ok
-- endResult
