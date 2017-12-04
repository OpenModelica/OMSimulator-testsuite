## status: correct
## teardown_command: rm omsllog.txt RealNetwork1.mat

from OMSimulator import OMSimulator

oms = OMSimulator()

oms.setLogFile("omsllog.txt")

model = oms.newModel()
oms.setTempDirectory(".")

# instantiate FMUs
oms.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Add.fmu", "add")
oms.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Feedback.fmu", "feedback")
oms.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Gain.fmu", "gain")
oms.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Product.fmu", "product")
oms.instantiateFMU(model, "../FMUs/Modelica.Blocks.Sources.Clock.fmu", "clock")
oms.instantiateFMU(model, "../FMUs/Modelica.Blocks.Sources.Constant.fmu", "constant")
oms.instantiateFMU(model, "../FMUs/Modelica.Blocks.Sources.Sine.fmu", "sine")
oms.instantiateFMU(model, "../FMUs/Modelica.Blocks.Sources.Step.fmu", "step")

# add connections
oms.addConnection(model, "clock.y", "product.u1")
oms.addConnection(model, "constant.y", "add.u2")
oms.addConnection(model, "feedback.y", "add.u1")
oms.addConnection(model, "gain.y", "feedback.u1")
oms.addConnection(model, "product.y", "gain.u")
oms.addConnection(model, "sine.y", "feedback.u2")
oms.addConnection(model, "step.y", "product.u2")

# parameters
oms.setReal(model, "clock.offset", 0.0)
oms.setReal(model, "clock.startTime", 0.0)
oms.setReal(model, "step.height", 3.0)
oms.setReal(model, "step.offset", 1.0)
oms.setReal(model, "step.startTime", 3.0)
oms.setReal(model, "gain.k", 1e-1)
oms.setReal(model, "sine.amplitude", 1.0)
oms.setReal(model, "sine.freqHz", 1.0)
oms.setReal(model, "sine.phase", 0.0)
oms.setReal(model, "sine.offset", 0.0)
oms.setReal(model, "sine.startTime", 2.0)
oms.setReal(model, "constant.k", -3.0)
oms.setReal(model, "add.k1", 2.0)
oms.setReal(model, "add.k2", 1.0)

# simulation settings
oms.setResultFile(model, "RealNetwork1.mat")
oms.setStopTime(model, 10.0)

oms.initialize(model)
oms.simulate(model)
oms.terminate(model)

oms.unload(model)

signals = ["add.y", "feedback.y", "gain.y", "step.y"]
for signal in signals:
  if (1 == oms.compareSimulationResults("RealNetwork1.mat", "../ReferenceFiles/RealNetwork1.mat", signal, 1e-2, 1e-4)):
    print(signal + " is equal")
  else:
    print(signal + " is not equal")

## Result:
## add.y is equal
## feedback.y is equal
## gain.y is equal
## step.y is equal
## info:    Logging information has been saved to "omsllog.txt"
## endResult
