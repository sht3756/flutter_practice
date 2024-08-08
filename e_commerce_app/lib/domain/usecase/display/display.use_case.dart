import '../../repository/display.repository.dart';
import '../base/remote_use_case.dart';

class DisplayUseCase {
  final DisplayRepository _displayRepository;

  DisplayUseCase(this._displayRepository);

  Future execute<T>({required RemoteUseCase useCase}) async {
    return await useCase(_displayRepository);
  }
}