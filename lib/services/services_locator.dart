import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'auth_services.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthenticationServices>(
    () => AuthenticationServices(auth: FirebaseAuth.instance),
  );

  
}

