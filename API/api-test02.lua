-- status: correct
-- teardown_command: rm -rf api-test02.log api_test02.xml api_test02b.xml api-test02_tmp

oms2_setLogFile("api-test02.log")

status = oms2_setTempDirectory("./api-test02_tmp")
print("status code: " .. status)

status = oms2_newFMIModel("api_test02")
print("status code: " .. status)

-- add FMUs
status = oms2_addFMU("api_test02", "../FMUs/DualMassOscillator.System1.fmu", "System1")
print("status code: " .. status)
status = oms2_addFMU("api_test02", "../FMUs/DualMassOscillator.System2.fmu", "System2")
print("status code: " .. status)

-- add connections
status = oms2_addConnection("api_test02", "System1:F", "System2:F")
print("status code: " .. status)
status = oms2_addConnection("api_test02", "System1:s1", "System2:s1")
print("status code: " .. status)
status = oms2_addConnection("api_test02", "System1:v1", "System2:v1")
print("status code: " .. status)
status = oms2_addConnection("api_test02", "System1:a1", "System2:a1")
print("status code: " .. status)

status = oms2_saveModel("api_test02", "api_test02.xml")
print("status code: " .. status)

status, source1 = oms2_listModel("api_test02")
print("status code: " .. status)
status = oms2_unloadModel("api_test02")
print("status code: " .. status)

status, ident = oms2_loadModel("api_test02.xml")
print("status code: " .. status .. " (" .. ident .. ")")

status = oms2_deleteConnection("api_test02", "System1:a1", "System2:a1")
print("status code: " .. status)
status = oms2_deleteConnection("api_test02", "System1:s1", "System2:s1")
print("status code: " .. status)
status = oms2_deleteConnection("api_test02", "System1:F", "System2:F")
print("status code: " .. status)
status = oms2_deleteConnection("api_test02", "System1:v1", "System2:v1")
print("status code: " .. status)

status, source2 = oms2_listModel("api_test02")
print("status code: " .. status)

status = oms2_unloadModel("api_test02")
print("status code: " .. status)

print(source1)
print(source2)

-- Result:
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0 (api_test02)
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- status code: 0
-- <?xml version="1.0" encoding="UTF-8"?>
-- <ssd:SystemStructureDescription name="api_test02" version="Draft20171219">
-- 	<ssd:System name="api_test02">
-- 		<ssd:Component name="System1" type="application/x-fmu-sharedlibrary" source="../FMUs/DualMassOscillator.System1.fmu">
-- 			<ssd:Connectors>
-- 				<ssd:Connector name="F" kind="input" type="Real">
-- 					<ssd:ConnectorGeometry x="0.000000" y="0.500000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="a1" kind="output" type="Real">
-- 					<ssd:ConnectorGeometry x="1.000000" y="0.250000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="s1" kind="output" type="Real">
-- 					<ssd:ConnectorGeometry x="1.000000" y="0.500000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="v1" kind="output" type="Real">
-- 					<ssd:ConnectorGeometry x="1.000000" y="0.750000" />
-- 				</ssd:Connector>
-- 			</ssd:Connectors>
-- 		</ssd:Component>
-- 		<ssd:Component name="System2" type="application/x-fmu-sharedlibrary" source="../FMUs/DualMassOscillator.System2.fmu">
-- 			<ssd:Connectors>
-- 				<ssd:Connector name="a1" kind="input" type="Real">
-- 					<ssd:ConnectorGeometry x="0.000000" y="0.250000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="s1" kind="input" type="Real">
-- 					<ssd:ConnectorGeometry x="0.000000" y="0.500000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="v1" kind="input" type="Real">
-- 					<ssd:ConnectorGeometry x="0.000000" y="0.750000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="F" kind="output" type="Real">
-- 					<ssd:ConnectorGeometry x="1.000000" y="0.500000" />
-- 				</ssd:Connector>
-- 			</ssd:Connectors>
-- 		</ssd:Component>
-- 		<ssd:Connections>
-- 			<ssd:Connection startElement="System2" startConnector="F" endElement="System1" endConnector="F" />
-- 			<ssd:Connection startElement="System1" startConnector="s1" endElement="System2" endConnector="s1" />
-- 			<ssd:Connection startElement="System1" startConnector="v1" endElement="System2" endConnector="v1" />
-- 			<ssd:Connection startElement="System1" startConnector="a1" endElement="System2" endConnector="a1" />
-- 		</ssd:Connections>
-- 	</ssd:System>
-- 	<ssd:DefaultExperiment startTime="0.000000" stopTime="1.000000" />
-- </ssd:SystemStructureDescription>
--
-- <?xml version="1.0" encoding="UTF-8"?>
-- <ssd:SystemStructureDescription name="api_test02" version="Draft20171219">
-- 	<ssd:System name="api_test02">
-- 		<ssd:Component name="System1" type="application/x-fmu-sharedlibrary" source="../FMUs/DualMassOscillator.System1.fmu">
-- 			<ssd:Connectors>
-- 				<ssd:Connector name="F" kind="input" type="Real">
-- 					<ssd:ConnectorGeometry x="0.000000" y="0.500000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="a1" kind="output" type="Real">
-- 					<ssd:ConnectorGeometry x="1.000000" y="0.250000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="s1" kind="output" type="Real">
-- 					<ssd:ConnectorGeometry x="1.000000" y="0.500000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="v1" kind="output" type="Real">
-- 					<ssd:ConnectorGeometry x="1.000000" y="0.750000" />
-- 				</ssd:Connector>
-- 			</ssd:Connectors>
-- 		</ssd:Component>
-- 		<ssd:Component name="System2" type="application/x-fmu-sharedlibrary" source="../FMUs/DualMassOscillator.System2.fmu">
-- 			<ssd:Connectors>
-- 				<ssd:Connector name="a1" kind="input" type="Real">
-- 					<ssd:ConnectorGeometry x="0.000000" y="0.250000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="s1" kind="input" type="Real">
-- 					<ssd:ConnectorGeometry x="0.000000" y="0.500000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="v1" kind="input" type="Real">
-- 					<ssd:ConnectorGeometry x="0.000000" y="0.750000" />
-- 				</ssd:Connector>
-- 				<ssd:Connector name="F" kind="output" type="Real">
-- 					<ssd:ConnectorGeometry x="1.000000" y="0.500000" />
-- 				</ssd:Connector>
-- 			</ssd:Connectors>
-- 		</ssd:Component>
-- 		<ssd:Connections />
-- 	</ssd:System>
-- 	<ssd:DefaultExperiment startTime="0.000000" stopTime="1.000000" />
-- </ssd:SystemStructureDescription>
--
-- info:    Logging information has been saved to "api-test02.log"
-- endResult
