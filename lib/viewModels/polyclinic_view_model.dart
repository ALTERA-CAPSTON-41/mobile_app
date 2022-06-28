import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/polyclinic.dart';
import 'package:capston_project/services/polyclinic_service.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class PolyclinicViewModel extends BaseViewModels {
  List<Polyclinic>? _polyclinic;
  List<Polyclinic>? get polyclinic => _polyclinic;

  Future<void> getAllPolyclinic() async {
    try {
      setState(RequestState.LOADING);
      _polyclinic = await policyService.getAllPolyclinic();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> createPolyclinic(Polyclinic polyclinic) async {
    try {
      setState(RequestState.LOADING);
      await policyService.createPolyclinic(polyclinic);
      getAllPolyclinic();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> deletePolyclinic(String id) async {
    try {
      setState(RequestState.LOADING);
      await policyService.deletePolyclinic(id);
      getAllPolyclinic();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> updatePolyclinic(Polyclinic polyclinic) async {
    try {
      setState(RequestState.LOADING);
      await policyService.updatePolyclinic(polyclinic);
      getAllPolyclinic();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }
}
