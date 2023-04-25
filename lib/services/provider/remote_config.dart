import 'package:gando/config/constants.dart';

abstract class RemoteEndpoint {
  static String getUserById({required String id}) => "/user/getUserById?id=$id";
  static String uploadSingleFile = "$API_URL/file/upload";
  static String editPictureUser = "/user/editPicture";
  static String editNameAndDescriptionUser = "/user/editNameAndDesc";
  static String deleteUser = "/user/deleteUser";
  static String editPasswordUser = "/user/editPassword";
  static String initEditMailUser = "/user/initEditEmail";
  static String verifyMailUser = "/user/verifyEmail";
  static String editCoordonates = "/user/editCoordonates";
  static String editNotification = "/user/editNotification";
  static String verifyOwner = "verifyOwner";
  static String getMessageDetail({required String discussionId}) =>
      "/discussion/getMessageInDiscussion?discussionId=$discussionId";
  static String getListMessage({required String id}) =>
      "/discussion/discussionOfUser?userId=$id";
  static String sendMessage = "/discussion";
  static String onBoardingAccount = "/payment/on-boarding-account";
}
