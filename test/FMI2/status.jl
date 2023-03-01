using FMIImport, FMICore, FMIZoo

myFMU = fmi2Load("Feedthrough", "ModelicaReferenceFMUs", "0.0.20")
# myFMU = fmi2Load("SpringPendulum1D", ENV["EXPORTINGTOOL"], ENV["EXPORTINGVERSION"])
myFMU.executionConfig.assertOnWarning = true

comp = fmi2Instantiate!(myFMU; loggingOn=true)
@test comp != 0

FMIImport.fmi2GetStatus(comp, FMICore.fmi2StatusKindTerminated)

@test fmi2EnterInitializationMode(comp) == 0
@test fmi2ExitInitializationMode(comp) == 0

@test fmi2SetupExperiment(comp, 0.0) == 0
