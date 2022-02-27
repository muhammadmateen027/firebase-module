import 'package:assignment/app/app.dart';
import 'package:assignment/bootstrap.dart';
import 'package:authentication_repository/authentication_repository.dart';

Future<void> main() async {
  await bootstrap(
    () async {
      final authenticationRepository = AuthenticationRepository();

      return App(
        authenticationRepository: authenticationRepository,
        user: await authenticationRepository.user.first,
      );
    },
  );
}
