// enum TypeMessageSystem {
//   createRoom("createRoom"),
//   joinRoom("joinRoom"),
//   leftRoom("leftRoom"),
//   removedFromRoom("removedFromRoom"),
//   becomeFriend("becomeFriend"),
//   callCancelled("callCancelled");

//   const TypeMessageSystem(this.content);

//   final String content;
// }

class MessageSystem {
  static String convertMessageSystem(String content) {
    switch (content) {
      case "createRoom":
        {
          return "created room";
        }
      case "joinRoom":
        {
          return "joined room";
        }
      case "removedFromRoom":
        {
          return "removed room";
        }
      case "leftRoom":
        {
          return "left room";
        }
      case "becomeFriend":
        {
          return "become friend";
        }
      case "callCancelled":
        {
          return "callCancelled";
        }
      default:
        {
          return "";
        }
    }
  }
}
