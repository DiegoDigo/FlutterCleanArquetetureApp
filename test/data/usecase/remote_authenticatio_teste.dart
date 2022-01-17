import 'package:clean_flutter_app/data/remote/http/http.dart';
import 'package:clean_flutter_app/data/remote/use_case/remote_authentication.dart';
import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_authenticatio_teste.mocks.dart';

@GenerateMocks([HttpClient])
void main() {
  late HttpClient httpClient;
  late String url;
  late String email;
  late String password;
  late RemoteAuthentication sut;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    email = faker.internet.email();
    password = faker.internet.password();
  });

  test('Should call httpClient with correct values', () async {
    final params = AuthenticationParams(email: email, password: password);
    await sut.auth(params);
    verify(httpClient.request(url: url, method: 'post', body: params.toJson()))
        .called(1);
  });
}
