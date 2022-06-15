import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/doctor.dart';
import 'package:capston_project/services/doctor_service.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class DoctorViewModel extends BaseViewModels {
  List<DoctorModel>? _doctor;
  List<DoctorModel>? get doctor => _doctor;

  Future<void> getAllDoctor() async {
    try {
      setState(RequestState.LOADING);
      _doctor = await doctorService.getAllDoctor();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> createDoctor(DoctorModel doctor) async {
    try {
      setState(RequestState.LOADING);

      await doctorService.createDoctor(doctor);
      await getAllDoctor();

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    try {
      setState(RequestState.LOADING);

      await doctorService.updateDoctor(doctor);
      await getAllDoctor();

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> deleteDoctor(String id) async {
    try {
      setState(RequestState.LOADING);

      await doctorService.deleteDoctor(id);
      await getAllDoctor();

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }
}
