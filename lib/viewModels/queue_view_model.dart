import 'package:capston_project/common/enum_state.dart';
import 'package:capston_project/models/queue.dart';
import 'package:capston_project/services/queue_services.dart';
import 'package:capston_project/viewModels/base_view_model.dart';

class QueueViewModel extends BaseViewModels {
  QueueModel? _queueModel;
  QueueModel? get queueModel => _queueModel;

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
}
