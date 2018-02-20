-- name: HelloWorld_cs_Fit
-- status: correct
-- teardown_command: rm HelloWorld_cs_Fit.log

-- Uncomment below if script shall be executed by a standard Lua interpreter (see README.md)
-- require("package")
-- OMSimulatorLua = package.loadlib("../../install/linux/lib/libOMSimulatorLua.so", "luaopen_OMSimulatorLua")
-- OMSimulatorLua()
-- OMFitLua = package.loadlib("../../install/linux/lib/libOMFitLua.so", "luaopen_OMFitLua")
-- OMFitLua()

setLogFile("HelloWorld_cs_Fit.log")

version = getVersion()
-- print(version)

model = newModel()
setTempDirectory(".")
setTolerance(model, 1e-5);

-- instantiate FMU
instantiateFMU(model, "../FMUs/HelloWorld_cs.fmu", "HelloWorld")

-- create fitmodel for model
fitmodel = omsfit_newFitModel(model);
-- omsfit_describe(fitmodel)

-- Data generated from simulating HelloWorld.mo for 1.0s with Euler and 0.1s step size
kNumSeries = 1;
kNumObservations = 11;
data_time = {0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1};
inputvars = {};
measurementvars = {"HelloWorld.x"};
data_x = {1, 0.9, 0.8100000000000001, 0.7290000000000001, 0.6561, 0.5904900000000001, 0.5314410000000001, 0.4782969000000001, 0.43046721, 0.387420489, 0.3486784401};

omsfit_initialize(fitmodel, kNumSeries, data_time, inputvars, measurementvars)
-- omsfit_describe(fitmodel)

omsfit_addParameter(fitmodel, "HelloWorld.x_start", 0.5);
omsfit_addParameter(fitmodel, "HelloWorld.a", -0.5);
omsfit_addMeasurement(fitmodel, 0, "HelloWorld.x", data_x);
-- omsfit_describe(fitmodel)

omsfit_setOptions_max_num_iterations(fitmodel, 25)
omsfit_solve(fitmodel, "")

status, fitmodelstate = omsfit_getState(fitmodel);
-- print(status, fitmodelstate)

status, startvalue1, estimatedvalue1 = omsfit_getParameter(fitmodel, "HelloWorld.a")
status, startvalue2, estimatedvalue2 = omsfit_getParameter(fitmodel, "HelloWorld.x_start")
-- print("HelloWorld.a startvalue=" .. startvalue1 .. ", estimatedvalue=" .. estimatedvalue1)
-- print("HelloWorld.x_start startvalue=" .. startvalue2 .. ", estimatedvalue=" .. estimatedvalue2)
is_OK1 = estimatedvalue1 > -1.1 and estimatedvalue1 < -0.9
is_OK2 = estimatedvalue2 > 0.9 and estimatedvalue2 < 1.1
print("HelloWorld.a estimation is OK: " .. tostring(is_OK1))
print("HelloWorld.x_start estimation is OK: " .. tostring(is_OK2))

omsfit_freeFitModel(fitmodel)
terminate(model)
unload(model)

-- Result:
-- HelloWorld.a estimation is OK: true
-- HelloWorld.x_start estimation is OK: true
-- info: Logging information has been saved to "HelloWorld_cs_Fit.log"
-- endResult
