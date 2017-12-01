## status: correct
## teardown_command: rm omsllog.txt DualMassOscillator_cs.mat

from OMSimulator import OMSimulator
session = OMSimulator()

session.setLogFile("omsllog.txt")

model = session.newModel()
session.setTempDirectory(".")

# instantiate FMUs
session.instantiateFMU(model, "../FMUs/DualMassOscillator.System1_cs.fmu", "System1")
session.instantiateFMU(model, "../FMUs/DualMassOscillator.System2_cs.fmu", "System2")

# add connections
session.addConnection(model, "System1.F", "System2.F")
session.addConnection(model, "System1.s", "System2.s")
session.addConnection(model, "System1.v", "System2.v")
session.addConnection(model, "System1.a", "System2.a")

session.setResultFile(model, "DualMassOscillator_cs.mat")

session.setStopTime(model, 0.1)
session.setCommunicationInterval(model, 1e-5)

session.initialize(model)
session.simulate(model)

tcur = session.getCurrentTime(model)
vars = ["System1.mass1.s", "System2.mass2.s"]
for var in vars:
  print('{0} at {1}: {2}'.format(var, tcur, session.getReal(model, var)))

session.terminate(model)

session.unload(model)

## Result:
## System1.mass1.s at 0.1: -0.441287624966
## System2.mass2.s at 0.1: -0.296093118317
## info:    1 warnings
## info:    0 errors
## info:    Logging information has been saved to "omsllog.txt"
## endResult
