-- status: correct
-- teardown_command: rm -rf pi_controller_tmp/
-- linux: yes
-- mingw: no
-- win: no
-- mac: no

oms3_setCommandLineOption("--suppressPath=true")
oms3_setTempDirectory("./pi_controller_tmp/")

oms3_newModel("PI_Controller")
oms3_addSystem("PI_Controller.co_sim", oms_system_wc)

-- instantiate FMUs
oms3_addSubModel("PI_Controller.co_sim.addP", "../FMUs/Modelica.Blocks.Math.Add.fmu")
oms3_addSubModel("PI_Controller.co_sim.P", "../FMUs/Modelica.Blocks.Math.Gain.fmu")
oms3_addSubModel("PI_Controller.co_sim.addI", "../FMUs/Modelica.Blocks.Math.Add3.fmu")
oms3_addSubModel("PI_Controller.co_sim.I", "../FMUs/Modelica.Blocks.Continuous.Integrator.fmu")
oms3_addSubModel("PI_Controller.co_sim.addPI", "../FMUs/Modelica.Blocks.Math.Add.fmu")
oms3_addSubModel("PI_Controller.co_sim.gainPI", "../FMUs/Modelica.Blocks.Math.Gain.fmu")
oms3_addSubModel("PI_Controller.co_sim.limiter", "../FMUs/Modelica.Blocks.Nonlinear.Limiter.fmu")
oms3_addSubModel("PI_Controller.co_sim.addSat", "../FMUs/Modelica.Blocks.Math.Add.fmu")
oms3_addSubModel("PI_Controller.co_sim.gainTrack", "../FMUs/Modelica.Blocks.Math.Gain.fmu")

-- add connections
oms3_addConnection("PI_Controller.co_sim.addP.y", "PI_Controller.co_sim.P.u")
oms3_addConnection("PI_Controller.co_sim.addI.y", "PI_Controller.co_sim.I.u")
oms3_addConnection("PI_Controller.co_sim.P.y", "PI_Controller.co_sim.addPI.u1")
oms3_addConnection("PI_Controller.co_sim.I.y", "PI_Controller.co_sim.addPI.u2")
oms3_addConnection("PI_Controller.co_sim.addPI.y", "PI_Controller.co_sim.gainPI.u")
oms3_addConnection("PI_Controller.co_sim.gainPI.y", "PI_Controller.co_sim.limiter.u")
oms3_addConnection("PI_Controller.co_sim.gainPI.y", "PI_Controller.co_sim.addSat.u2")
oms3_addConnection("PI_Controller.co_sim.limiter.y", "PI_Controller.co_sim.addSat.u1")
oms3_addConnection("PI_Controller.co_sim.addSat.y", "PI_Controller.co_sim.gainTrack.u")
oms3_addConnection("PI_Controller.co_sim.gainTrack.y", "PI_Controller.co_sim.addI.u3")

-- instantiate lookup table
oms3_addSubModel("PI_Controller.co_sim.setpoint", "setpoint.csv")
oms3_addSubModel("PI_Controller.co_sim.driveTrain", "drivetrain.csv")

-- add connections
oms3_addConnection("PI_Controller.co_sim.setpoint.speed", "PI_Controller.co_sim.addP.u1")
oms3_addConnection("PI_Controller.co_sim.setpoint.speed", "PI_Controller.co_sim.addI.u1")
oms3_addConnection("PI_Controller.co_sim.driveTrain.w", "PI_Controller.co_sim.addP.u2")
oms3_addConnection("PI_Controller.co_sim.driveTrain.w", "PI_Controller.co_sim.addI.u2")

oms3_exportDependencyGraphs("PI_Controller.co_sim", "a.dot", "b.dot")

oms3_instantiate("PI_Controller")
oms3_initialize("PI_Controller")
oms3_simulate("PI_Controller")
oms3_terminate("PI_Controller")

oms3_delete("PI_Controller")

-- Result:
-- info:    Set temp directory to    <suppressed>
-- info:    Set working directory to <suppressed>
-- info:    Set temp directory to    <suppressed>
-- info:    New model "PI_Controller" with corresponding temp directory <suppressed>
-- info:    Result file: PI_Controller_res.mat (bufferSize=10)
-- info:    Parameter PI_Controller.co_sim.limiter._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.limiter._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Variable PI_Controller.co_sim.limiter.limitsAtInit will not be stored in the result file, because the signal type is not supported
-- info:    Variable PI_Controller.co_sim.limiter.strict will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainTrack._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.gainPI._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addSat._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addPI._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addP._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.addI._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.P._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._block_jacobian_check will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._block_solver_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._block_solver_profiling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._cs_experimental_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._cs_solver will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._enforce_bounds will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._iteration_variable_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._log_level will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_active_bounds_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_brent_ignore_error will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_jacobian_calculation_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_jacobian_update_mode will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_solver_check_jac_cond will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_solver_exit_criterion will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_solver_max_iter will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_solver_max_iter_no_jacobian will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_solver_use_last_integrator_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._nle_solver_use_nominals_as_fallback will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._rescale_after_singular_jac will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._rescale_each_step will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._residual_equation_scaling will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._runtime_log_to_file will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._use_Brent_in_1d will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._use_jacobian_equilibration will not be stored in the result file, because the signal type is not supported
-- info:    Parameter PI_Controller.co_sim.I._use_newton_for_brent will not be stored in the result file, because the signal type is not supported
-- info:    Variable PI_Controller.co_sim.I.initType will not be stored in the result file, because the signal type is not supported
-- endResult
