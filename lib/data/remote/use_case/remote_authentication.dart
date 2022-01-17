import '../http/http.dart';
import '../../remote/dto/dtos.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromEntity(params).toJson();
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

class AuthenticationParams {
  final String email;
  final String password;

  AuthenticationParams({required this.email, required this.password});

  Map toJson() => {"email": email, "password": password};
}
