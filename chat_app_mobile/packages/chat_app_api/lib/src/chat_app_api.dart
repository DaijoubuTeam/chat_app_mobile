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
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjU4NWI5MGI1OWM2YjM2ZDNjOTBkZjBlOTEwNDQ1M2U2MmY4ODdmNzciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY29mZmVlLWNoYXQtODRjZDUiLCJhdWQiOiJjb2ZmZWUtY2hhdC04NGNkNSIsImF1dGhfdGltZSI6MTY2NDU4OTcxNiwidXNlcl9pZCI6IjdnQ1FTbVVSWlNNbGdwUW1IZnVvajJ6ZjROSDIiLCJzdWIiOiI3Z0NRU21VUlpTTWxncFFtSGZ1b2oyemY0TkgyIiwiaWF0IjoxNjY0NTg5NzE3LCJleHAiOjE2NjQ1OTMzMTcsImVtYWlsIjoiZGluaGxvY2t0MDJAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiZGluaGxvY2t0MDJAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.JreaQ6DdieigQlR2F2xUgeyMhhn2OErVMGtCjsLSXgcxfmCWC-0bEsZUc2fPtcO739ekae6IpfbjBTn1__OTwfV0Zhi4UIasslRpFlzPLxYXj3Lk3qH5Kl-wEYUWw0zxSxyUr3kmsgGKN4HpF4N1EHysG7vIK3zh9xeqXH_txB7PjMJ497-42KTCc4q3IQX3o6e3qlO2t7GGOgIgdTB_XlMT-3hYrHyPtJHmhq02mC6rPD_xOXnGvlp4ZA3VUQGehlV9_OxLVEt0U2mqg4smc3EB5yOWPARZHtumPsAaMWj8ymgLX623b9gTtQc8pcsCdGdflvyFTBzVXpuO8pkKOw';

const token = '63379d57b2ff860d5eeb8985';
const password = '11111111';

Future<void> main() async {
  final chapAppApi = UserApi();
  final user = User(uid: '7gCQSmURZSMlgpQmHfuoj2zf4NH2', fullname: '1111');
  chapAppApi.verifyEmail(bearerToken);
}
