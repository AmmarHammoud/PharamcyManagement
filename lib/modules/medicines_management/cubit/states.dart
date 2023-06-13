abstract class MedicinesManagementStates {}

class MedicinesManagementInitialState extends MedicinesManagementStates {}

//get medicines
class GetTotalMedicinesLoadingState extends MedicinesManagementStates {}

class GetTotalMedicinesSuccessState extends MedicinesManagementStates {}

class GetTotalMedicinesErrorState extends MedicinesManagementStates {}

//delete medicine
class DeleteMedicineLoadingState extends MedicinesManagementStates {}

class DeleteMedicineSuccessState extends MedicinesManagementStates {}

class DeleteMedicineErrorState extends MedicinesManagementStates {}

//update medicine
class UpdateMedicineInformationLoadingState extends MedicinesManagementStates{}

class UpdateMedicineInformationSuccessState extends MedicinesManagementStates{}

class UpdateMedicineInformationErrorState extends MedicinesManagementStates{}

//change date
class ChangingDate extends MedicinesManagementStates{}

class ChangedDate extends MedicinesManagementStates{}