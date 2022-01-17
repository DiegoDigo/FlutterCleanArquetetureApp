import 'package:clean_flutter_app/data/remote/use_case/remote_authentication.dart';

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  Map toJson() => {"email": email, "password": password};

  factory RemoteAuthenticationParams.fromEntity(AuthenticationParams entity) =>
      RemoteAuthenticationParams(email: entity.email, password: entity.password);
}
