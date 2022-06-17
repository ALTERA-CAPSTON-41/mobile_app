import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/services/queue_services.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class QueueViewModel extends BaseViewModels {
  List<QueueModel>? _queueModel;
  List<QueueModel>? get queueModel => _queueModel;

  Future<void> getAllQueue() async {
    try {
      setState(RequestState.LOADING);
      _queueModel = await queueServices.getAllQueue();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> createQueue(QueueModel queue) async {
    try {
      setState(RequestState.LOADING);
      await queueServices.createQueue(queue);
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }

  Future<void> doneQueue(QueueModel queue) async {
    try {
      setState(RequestState.LOADING);
      await queueServices.doneQueue(queue);
      getAllQueue();
      setState(RequestState.LOADED);
    } catch (e) {
      setState(RequestState.ERROR);
      errMsgChange = e.toString();
    }
  }
}
