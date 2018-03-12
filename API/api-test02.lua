-- status: correct
-- teardown_command: rm -rf api-test02.log api_test02.xml api_test02b.xml api-test02_tmp

setLogFile("api-test02.log")

status = oms2_setTempDirectory("./api-test02_tmp")
print("status code: " .. status)

status = oms2_newFMIModel("api_test02")
print("status code: " .. status)

-- add FMUs
status = oms2_addFMU("api_test02", "../FMUs/DualMassOscillator.System1_me.fmu", "System1")
print("status code: " .. status)
status = oms2_addFMU("api_test02", "../FMUs/DualMassOscillator.System2_me.fmu", "System2")
print("status code: " .. status)

-- add connections
status = oms2_addConnection("api_test02", "System1:F", "System2:F")
print("status code: " .. status)
status = oms2_addConnection("api_test02", "System1:s", "System2:s")
print("status code: " .. status)
status = oms2_addConnection("api_test02", "System1:v", "System2:v")
print("status code: " .. status)
status = oms2_addConnection("api_test02", "System1:a", "System2:a")
print("status code: " .. status)

status = oms2_saveModel("api_test02.xml", "api_test02")
print("status code: " .. status)

status = oms2_unloadModel("api_test02")
print("status code: " .. status)

status, ident = oms2_loadModel("api_test02.xml")
print("status code: " .. status .. " (" .. ident .. ")")

status = oms2_deleteConnection("api_test02", "System1:a", "System2:a")
print("status code: " .. status)
status = oms2_deleteConnection("api_test02", "System1:s", "System2:s")
print("status code: " .. status)
status = oms2_deleteConnection("api_test02", "System1:F", "System2:F")
print("status code: " .. status)
status = oms2_deleteConnection("api_test02", "System1:v", "System2:v")
print("status code: " .. status)

status = oms2_saveModel("api_test02b.xml", "api_test02")
print("status code: " .. status)

status = oms2_unloadModel("api_test02")
print("status code: " .. status)

os.execute("cat api_test02.xml")
os.execute("cat api_test02b.xml")

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
-- 		<ssd:Component name="System1" type="application/x-fmu-sharedlibrary" source="../FMUs/DualMassOscillator.System1_me.fmu" />
-- 		<ssd:Component name="System2" type="application/x-fmu-sharedlibrary" source="../FMUs/DualMassOscillator.System2_me.fmu" />
-- 		<ssd:Connections>
-- 			<ssd:Connection startElement="System1" startConnector="F" endElement="System2" endConnector="F" />
-- 			<ssd:Connection startElement="System1" startConnector="s" endElement="System2" endConnector="s" />
-- 			<ssd:Connection startElement="System1" startConnector="v" endElement="System2" endConnector="v" />
-- 			<ssd:Connection startElement="System1" startConnector="a" endElement="System2" endConnector="a" />
-- 		</ssd:Connections>
-- 	</ssd:System>
-- 	<ssd:DefaultExperiment startTime="0.000000" stopTime="1.000000" />
-- </ssd:SystemStructureDescription>
-- <?xml version="1.0" encoding="UTF-8"?>
-- <ssd:SystemStructureDescription name="api_test02" version="Draft20171219">
-- 	<ssd:System name="api_test02">
-- 		<ssd:Component name="System1" type="application/x-fmu-sharedlibrary" source="../FMUs/DualMassOscillator.System1_me.fmu" />
-- 		<ssd:Component name="System2" type="application/x-fmu-sharedlibrary" source="../FMUs/DualMassOscillator.System2_me.fmu" />
-- 		<ssd:Connections />
-- 	</ssd:System>
-- 	<ssd:DefaultExperiment startTime="0.000000" stopTime="1.000000" />
-- </ssd:SystemStructureDescription>
-- info:    Logging information has been saved to "api-test02.log"
-- endResult
