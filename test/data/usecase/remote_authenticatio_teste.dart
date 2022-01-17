import 'package:clean_flutter_app/data/remote/http/http.dart';
import 'package:clean_flutter_app/data/remote/use_case/remote_authentication.dart';
import 'package:clean_flutter_app/domain/helper/help.dart';
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
  late AuthenticationParams params;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    email = faker.internet.email();
    password = faker.internet.password();
    params = AuthenticationParams(email: email, password: password);
  });

  test('Should call httpClient with correct values', () async {
    final params = AuthenticationParams(email: email, password: password);
    await sut.auth(params);
    verify(httpClient.request(url: url, method: 'post', body: params.toJson()))
        .called(1);
  });

  test('Should throw unexpected if HttpClient return 400 ', () {
    when(httpClient.request(url: url, method: "post", body: params.toJson()))
        .thenThrow(HttpError.badRequest);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw unexpected if HttpClient return 404 ', () {
    when(httpClient.request(url: url, method: "post", body: params.toJson()))
        .thenThrow(HttpError.notFound);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw unexpected if HttpClient return 500 ', () {
    when(httpClient.request(url: url, method: "post", body: params.toJson()))
        .thenThrow(HttpError.serverError);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient return 401 ', () {
    when(httpClient.request(url: url, method: "post", body: params.toJson()))
        .thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });
}
