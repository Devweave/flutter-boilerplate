import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/resources.dart';
import '../../../../core/utils/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase implements BaseUseCase<bool, NoParams> {
  final LocalStorageService _localStorageService;

  LogoutUseCase(this._localStorageService);

  @override
  Future<Resource<bool>> call(NoParams params) async {
    try {
      final success = await _localStorageService.clearUserData();
      if (success) {
        return Resource.success(true);
      } else {
        return Resource.error(
          'Gagal logout: Tidak dapat menghapus data pengguna',
        );
      }
    } catch (e) {
      return Resource.error('Gagal logout: ${e.toString()}');
    }
  }
}
