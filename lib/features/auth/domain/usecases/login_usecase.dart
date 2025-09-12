import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/resources.dart';
import '../entities/user.dart';
import '../../../../core/utils/base_usecase.dart';
import 'package:injectable/injectable.dart';

class LoginParams {
  const LoginParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

@injectable
class LoginUseCase implements BaseUseCase<User, LoginParams> {
  LoginUseCase(this._localStorageService);
  final LocalStorageService _localStorageService;

  @override
  Future<Resource<User>> call(LoginParams params) async {
    try {
      // Simple validation
      if (params.email.isEmpty || params.password.isEmpty) {
        return Resource.error('Email dan password tidak boleh kosong');
      }

      // Simple authentication (in real app, this would be an API call)
      if (params.email.contains('@') && params.password.length >= 6) {
        final user = User(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: params.email,
          name: params.email.split('@')[0],
          isActive: true,
        );

        // Save to local storage
        await _localStorageService.setLoggedIn(true);
        await _localStorageService.setUserData(user.toJson());

        return Resource.success(user);
      } else {
        return Resource.error('Email atau password tidak valid');
      }
    } catch (e) {
      return Resource.error('Terjadi kesalahan: ${e.toString()}');
    }
  }
}
