import 'package:chat_app_api/src/api/user_api.dart';

import 'api/auth_api.dart';
import 'models/user.dart';

class ChatAppApi {
  ChatAppApi({AuthApi? authApi, UserApi? userApi})
      : _authApi = authApi ?? AuthApi(),
        _userApi = userApi ?? UserApi();

  AuthApi _authApi;
  UserApi _userApi;

  Future<User> verifyUser(String bearerToken) async {
    try {
      final user = await _authApi.verify(bearerToken);
      return user;
    } catch (e) {
      return User.empty;
    }
  }

  Future<void> forgotPassword(String email) {
    return _authApi.forgotPassword(email);
  }

  Future<void> resetPassword(String token, String password) {
    return _authApi.resetPassword(token, password);
  }

  Future<User> getSelfProfile(String bearerToken) async {
    try {
      final user = await _userApi.getSelfProfile(bearerToken);
      return user;
    } catch (e) {
      return User.empty;
    }
  }

  Future<User> updateSelfProfile(User user, String bearerToken) async {
    try {
      final resUser = await _userApi.updateProfile(user, bearerToken);
      return resUser;
    } catch (e) {
      return User.empty;
    }
  }

  Future<void> verifyEmail(String bearerToken) async {
    await _userApi.verifyEmail(bearerToken);
  }
}

const bearerToken =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjU4NWI5MGI1OWM2YjM2ZDNjOTBkZjBlOTEwNDQ1M2U2MmY4ODdmNzciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY29mZmVlLWNoYXQtODRjZDUiLCJhdWQiOiJjb2ZmZWUtY2hhdC04NGNkNSIsImF1dGhfdGltZSI6MTY2NTE1NzY2MiwidXNlcl9pZCI6IkZRaHRJSWNkWUdNOE5xdm9PWm4weVJRWTFmOTIiLCJzdWIiOiJGUWh0SUljZFlHTThOcXZvT1puMHlSUVkxZjkyIiwiaWF0IjoxNjY1MTU3NjYyLCJleHAiOjE2NjUxNjEyNjIsImVtYWlsIjoiMTIzQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyIxMjNAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.Fc9KieTRpqqqmcGIknioQdkopELYQAzOWeLQHZ9Ix8EDOQZTpodxfKeC4IZSlB3NAJ1keUALWtiEYwExN-Rvj-7Lj-5P2KIMOxXxPXuOM4NSVD7FaXAcw8cPymnBjBuAm_POgS2BOVijT7gX3wome9f23Vvj4gQvBc-KNbHAwr0TetOLMv8QHvEHduDtpKR4qAIPxnTaaRrowdIe19ttsxGoyk3_9gf-GSZgc21GMW9_T7vDQXnRAj5E5Bqxa2TovIxXDgKpflQh30LY5MNbOp5X9EBXMpcyIQ7Ra-H9xgqBkyXJ616bwmYz6FCn2K9LisWyrG-RAD4NSfWOdH3dWQ';

const token = '63379d57b2ff860d5eeb8985';
const password = '11111111';

Future<void> main() async {
  final chapAppApi = ChatAppApi();
  //final user = User(uid: '7gCQSmURZSMlgpQmHfuoj2zf4NH2', fullname: '1111');
  await chapAppApi.verifyEmail(bearerToken);
}
