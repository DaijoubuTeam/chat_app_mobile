import 'package:user_repository/src/models/user.dart' as user_model;
import 'package:chat_app_api/chat_app_api.dart' as chat_app_api;

class UserRepository {
  UserRepository(chat_app_api.ChatAppApi chatAppApi) : _chatAppApi = chatAppApi;

  final chat_app_api.ChatAppApi _chatAppApi;

  Future<user_model.User> getSelfProfile(String bearerToken) async {
    final apiUser = await _chatAppApi.getSelfProfile(bearerToken);
    return apiUser.toRepositoryUser();
  }

  Future<user_model.User> updateSelfProfile(
      user_model.User user, String bearerToken) async {
    final apiUser =
        await _chatAppApi.updateSelfProfile(user.toApiUser(), bearerToken);
    return apiUser.toRepositoryUser();
  }
}

extension on chat_app_api.User {
  user_model.User toRepositoryUser() {
    if (this == chat_app_api.User.empty) {
      return user_model.User.empty;
    }
    final user = user_model.User(
      uid: uid,
      username: username,
      fullname: fullname,
      avatar: avatar,
      phone: phone,
      about: about,
      email: email,
      isEmailVerified: isEmailVerified,
      isProfileFilled: isProfileFilled,
      friends: friends,
      friendRequests: friendRequests,
      bans: bans,
    );
    return user;
  }
}

extension on user_model.User {
  chat_app_api.User toApiUser() {
    if (this == user_model.User.empty) {
      return chat_app_api.User.empty;
    }
    final user = chat_app_api.User(
      uid: uid,
      username: username,
      fullname: fullname,
      avatar: avatar,
      phone: phone,
      about: about,
      email: email,
      isEmailVerified: isEmailVerified,
      isProfileFilled: isProfileFilled,
      friends: friends,
      friendRequests: friendRequests,
      bans: bans,
    );
    return user;
  }
}
