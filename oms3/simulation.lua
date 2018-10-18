-- status: correct
-- teardown_command: rm -rf simulation/
-- linux: yes
-- mingw: no
-- win: no
-- mac: no

oms3_setCommandLineOption("--suppressPath=true")
oms3_setTempDirectory("./simulation/")

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

status = oms3_addSystem("test.co_sim", oms_system_wc)
printStatus(status, 0)

status = oms3_addSubModel("test.co_sim.A", "../FMUs/source.fmu")
printStatus(status, 0)

status = oms3_addSubModel("test.co_sim.B", "../FMUs/source.fmu")
printStatus(status, 0)

status = oms3_instantiate("test")
printStatus(status, 0)

status = oms3_initialize("test")
printStatus(status, 0)

status = oms3_terminate("test")
printStatus(status, 0)

status = oms3_delete("test")
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
-- endResult
