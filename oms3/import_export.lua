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

status = oms3_newModel("test")
printStatus(status, 0)

status = oms3_addSystem("test.eoo", oms_system_tlm)
printStatus(status, 0)

status = oms3_addSystem("test.eoo.foo", oms_system_wc)
printStatus(status, 0)

status = oms3_addSystem("test.eoo.foo.goo", oms_system_sc)
printStatus(status, 0)

--status = oms3_addSubModel("test.eoo.foo.goo.A", "../FMUs/source.fmu")
--printStatus(status, 0)

src, status = oms3_list("test")
printStatus(status, 0)
print(src)

status = oms3_export("test", "test.ssd");
printStatus(status, 0)

status = oms3_delete("test")
printStatus(status, 0)

model, status = oms3_import("test.ssd");
printStatus(status, 0)

src, status = oms3_list(model)
printStatus(status, 0)
print(src)

status = oms3_delete(model)
printStatus(status, 0)


-- Result:
-- info:    Set temp directory to    <suppressed>
-- info:    Set working directory to <suppressed>
-- info:    New model "test" with corresponding temp directory <suppressed>
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- status:  [correct] ok
-- <?xml version="1.0"?>
-- <ssd:SystemStructureDescription name="test" version="Draft20180219">
-- 	<ssd:System name="eoo">
-- 		<ssd:SimulationInformation>
-- 			<ssd:Annotation type="org.openmodelica">
-- 				<tlm:Master />
-- 			</ssd:Annotation>
-- 		</ssd:SimulationInformation>
-- 		<ssd:Elements>
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
-- 				</ssd:Elements>
-- 				<ssd:Connectors />
-- 				<ssd:Connections />
-- 			</ssd:System>
-- 		</ssd:Elements>
-- 		<ssd:Connectors />
-- 		<ssd:Connections />
-- 	</ssd:System>
-- </ssd:SystemStructureDescription>
--
-- status:  [correct] ok
-- status:  [correct] ok
-- info:    New model "test" with corresponding temp directory <suppressed>
-- status:  [correct] ok
-- status:  [correct] ok
-- <?xml version="1.0"?>
-- <ssd:SystemStructureDescription name="test" version="Draft20180219">
-- 	<ssd:System name="eoo">
-- 		<ssd:SimulationInformation>
-- 			<ssd:Annotation type="org.openmodelica">
-- 				<tlm:Master />
-- 			</ssd:Annotation>
-- 		</ssd:SimulationInformation>
-- 		<ssd:Elements>
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
-- 				</ssd:Elements>
-- 				<ssd:Connectors />
-- 				<ssd:Connections />
-- 			</ssd:System>
-- 		</ssd:Elements>
-- 		<ssd:Connectors />
-- 		<ssd:Connections />
-- 	</ssd:System>
-- </ssd:SystemStructureDescription>
--
-- status:  [correct] ok
-- endResult
