import 'package:flutter_boilerplate/core/services/local_storage_service.dart';
import 'package:flutter_boilerplate/core/utils/resources.dart';
import 'package:flutter_boilerplate/domain/usecases/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase implements BaseUseCase<bool, NoParams> {
  final LocalStorageService _localStorageService;

  LogoutUseCase(this._localStorageService);

  @override
  Future<Resource<bool>> call(NoParams params) async {
    try {
      await _localStorageService.clearUserData();
      return Resource.success(true);
    } catch (e) {
      return Resource.error('Gagal logout: ${e.toString()}');
    }
  }
}
