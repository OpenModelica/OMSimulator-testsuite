## status: correct
## teardown_command: rm PI_Controller.log  PI_Controller.mat PI_Controller*.dot

from OMSimulator import OMSimulator
session = OMSimulator()

session.setLogFile("PI_Controller.log")
session.setTempDirectory("./PI_Controller_tmp")

model = session.newModel()

# instantiate FMUs
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Add.fmu", "addP")
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Gain.fmu", "P")
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Add3.fmu", "addI")
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Continuous.Integrator.fmu", "I")
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Add.fmu", "addPI")
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Gain.fmu", "gainPI")
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Nonlinear.Limiter.fmu", "limiter")
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Add.fmu", "addSat")
session.instantiateFMU(model, "../FMUs/Modelica.Blocks.Math.Gain.fmu", "gainTrack")

# add connections
session.addConnection(model, "addP.y", "P.u")
session.addConnection(model, "addI.y", "I.u")
session.addConnection(model, "P.y", "addPI.u1")
session.addConnection(model, "I.y", "addPI.u2")
session.addConnection(model, "addPI.y", "gainPI.u")
session.addConnection(model, "gainPI.y", "limiter.u")
session.addConnection(model, "gainPI.y", "addSat.u2")
session.addConnection(model, "limiter.y", "addSat.u1")
session.addConnection(model, "addSat.y", "gainTrack.u")
session.addConnection(model, "gainTrack.y", "addI.u3")

# parameters
k = 100.0
yMax = 12.0
yMin = -yMax
wp = 1.0
Ni = 0.1
xi_start = 0.0

# set parameters
session.setReal(model, "addP.k1", wp)
session.setReal(model, "addP.k2", -1.0)
session.setReal(model, "addI.k2", -1.0)
session.setReal(model, "I.y_start", xi_start)
session.setReal(model, "gainPI.k", k)
session.setReal(model, "limiter.uMax", yMax)
session.setReal(model, "addSat.k2", -1.0)
session.setReal(model, "gainTrack.k", 1.0/(k*Ni))

# simulation settings
session.setStopTime(model, 4.0)
session.setCommunicationInterval(model, 1e-4)

session.exportCompositeStructure(model, "PI_Controller")
session.exportDependencyGraph(model, "PI_Controller")
#gvpr -c "N[$.degree==0]{delete(root, $)}" PI_Controller_simulation.dot | dot -Tpdf -o PI_Controller_simulation.pdf
#gvpr -c "N[$.degree==0]{delete(root, $)}" PI_Controller_initialization.dot | dot -Tpdf -o PI_Controller_initialization.pdf
#dot -Gsplines=none PI_Controller.dot | neato -n -Gsplines=ortho -Tpdf -oPI_Controller.pdf

# instantiate lookup table
session.instantiateTable(model, "setpoint.csv", "setpoint")
session.instantiateTable(model, "drivetrain.csv", "driveTrain")

# add connections
session.addConnection(model, "setpoint.speed", "addP.u1")
session.addConnection(model, "setpoint.speed", "addI.u1")

session.addConnection(model, "driveTrain.w", "addP.u2")
session.addConnection(model, "driveTrain.w", "addI.u2")

# simulation settings
session.setResultFile(model, "PI_Controller.mat")

# simulation
print("info:    Initialization")
session.initialize(model)
print("info:      limiter.u: " + str(session.getReal(model, "limiter.u")))
print("info:      limiter.y: " + str(session.getReal(model, "limiter.y")))

print("info:    Simulation")
session.simulate(model)
print("info:      limiter.u: " + str(session.getReal(model, "limiter.u")))
print("info:      limiter.y: " + str(session.getReal(model, "limiter.y")))

session.terminate(model)
session.unload(model)

vars = ["limiter.u", "limiter.y"]
for var in vars:
  if (1 == session.compareSimulationResults("PI_Controller.mat", "../ReferenceFiles/PI_Controller.mat", var, 1e-2, 1e-4)):
    print("info:    " + var + " is equal")
  else:
    print("error:   " + var + " is not equal")

## Result:
## info:    Initialization
## info:      limiter.u: 0.0
## info:      limiter.y: 0.0
## info:    Simulation
## info:      limiter.u: -10.0145088937
## info:      limiter.y: -10.0145088937
## info:    limiter.u is equal
## info:    limiter.y is equal
## info:    Logging information has been saved to "PI_Controller.log"
## endResult
