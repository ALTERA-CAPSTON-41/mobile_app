import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/medical_record.dart';
import 'package:capston_project/services/medical_record_service.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class MedicalRecordViewModel extends BaseViewModels {
  List<MedicalRecordModel>? _medicalRec;
  List<MedicalRecordModel>? get medicalRec => _medicalRec;

  Future<void> getMedicalRecByNik({required String nik}) async {
    try {
      setState(RequestState.LOADING);
      _medicalRec = await medicalRecordService.getMedicalRecord(nik: nik);
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> createMedicalRecord(MedicalRecordModel medical) async {
    try {
      setState(RequestState.LOADING);

      await medicalRecordService.createMeidcalRecord(medical);

      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }
}
