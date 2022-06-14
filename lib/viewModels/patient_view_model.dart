import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/patient.dart';
import 'package:capston_project/services/patient_service.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class PatientViewModel extends BaseViewModels {
  List<PatientModel>? _patient;
  get patient => _patient;

  Future<void> getAllPatient() async {
    try {
      setState(RequestState.LOADING);
      _patient = await patientService.getAllPatient();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> createPatient(PatientModel patient) async {
    try {
      setState(RequestState.LOADING);

      await patientService.createPatient(patient);
      await getAllPatient();

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> updatePatient(PatientModel patient) async {
    try {
      setState(RequestState.LOADING);

      await patientService.updatePatient(patient);
      await getAllPatient();

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      setState(RequestState.LOADING);

      await patientService.deletePatient(id);
      await getAllPatient();

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }
}
