## status: correct
## teardown_command: rm -rf simulation/ test_init.dot test_sim.dot
## linux: yes
## mingw: yes
## win: yes
## mac: yes

from OMSimulator import OMSimulator
session=OMSimulator()

session.oms3_setCommandLineOption("--suppressPath=true")

def printStatus(status, expected):
  cmp = ""
  if status == expected:
    cmp = "correct"
  else:
    cmp = "wrong"
  
  if 0 == status:
    status = "ok"
  elif 1 == status:
    status = "warning"
  elif 3 == status:
    status = "error"
  print("status:  [", cmp, "] ",status)

session.oms3_setCommandLineOption("--suppressPath=true")
session.oms3_setTempDirectory("./simulation/")

status = session.oms3_newModel("test")
printStatus(status, 0)

status = session.oms3_addSystem("test.co_sim", session.oms_system_wc)
printStatus(status, 0)

status = session.oms3_addSubModel("test.co_sim.A", "../FMUs/source.fmu")
printStatus(status, 0)

status = session.oms3_addSubModel("test.co_sim.B", "../FMUs/source.fmu")
printStatus(status, 0)

session.oms3_exportDependencyGraphs("test.co_sim", "test_init.dot", "test_sim.dot")

status = session.oms3_instantiate("test")
printStatus(status, 0)

status, v = session.oms3_getReal("test.co_sim.A.A")
printStatus(status, 0)
print("test.co_sim.A.A: ", v)

status = session.oms3_setReal("test.co_sim.A.A", v + 1.0)
printStatus(status, 0)

status, v = session.oms3_getReal("test.co_sim.A.A")
printStatus(status, 0)
print("test.co_sim.A.A: ", v)

status = session.oms3_initialize("test")
printStatus(status, 0)

status, v = session.oms3_getReal("test.co_sim.A.y")
printStatus(status, 0)
print("test.co_sim.A.y: ", v)

status = session.oms3_simulate("test")
printStatus(status, 0)

status, v = session.oms3_getReal("test.co_sim.A.y")
printStatus(status, 0)
print("test.co_sim.A.y: ", v)

status = session.oms3_terminate("test")
printStatus(status, 0)

status = session.oms3_delete("test")
printStatus(status, 0)