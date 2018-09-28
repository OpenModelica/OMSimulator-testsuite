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

status = oms3_addExternalModel("model.tlm.external", "resources/external.mo", "resources/startscript.sh")
printStatus(status, 0)

status = oms3_addTLMBus("model.tlm.external.tlmbus", "mechanical", 1, default)

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
-- <?xml version="1.0"?>
-- <ssd:System name="tlm">
-- 	<ssd:SimulationInformation>
-- 		<ssd:Annotations>
-- 			<ssd:Annotation type="org.openmodelica">
-- 				<tlm:Master />
-- 			</ssd:Annotation>
-- 		</ssd:Annotations>
-- 	</ssd:SimulationInformation>
-- 	<ssd:Elements>
-- 		<ssd:Component name="external" source="resources/external.mo">
-- 			<ssd:Annotations>
-- 				<ssd:Annotation type="org.openmodelica">
-- 					<OMSimulator:Bus name="tlmbus" type="tlm" domain="mechanical" dimensions="1" interpolation="none">
-- 						<Signals />
-- 					</OMSimulator:Bus>
-- 				</ssd:Annotation>
-- 			</ssd:Annotations>
-- 			<ssd:SimulationInformation>
-- 				<ssd:Annotations>
-- 					<ssd:Annotation type="org.openmodelica">
-- 						<OMSimulator:ExternalModel startscript="resources/startscript.sh" />
-- 					</ssd:Annotation>
-- 				</ssd:Annotations>
-- 			</ssd:SimulationInformation>
-- 		</ssd:Component>
-- 	</ssd:Elements>
-- 	<ssd:Connectors />
-- 	<ssd:Connections />
-- </ssd:System>
-- 
-- status:  [correct] ok
-- endResult
