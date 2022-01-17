import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_authenticatio_teste.mocks.dart';



class RemoteAuthentication{
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async{
    await httpClient.request(url: url);
  }

}


abstract class HttpClient {
  Future<void> request({required String url});
}


@GenerateMocks([HttpClient])
void main() {
  test('Should call httpClient with correct URL', () async {
    final httpClient = MockHttpClient();
    final url = faker.internet.httpsUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    await sut.auth();
    verify(httpClient.request(url: url)).called(1);
  });
}