import 'package:firebase_auth/firebase_auth.dart';
import 'package:gando/services/phone/otp_service.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:gando/services/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

///Dependency injection
Future<void> init() async {
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<OtpService>(() => OtpService());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}
