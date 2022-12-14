import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamApi {
  final apiKey = "nckhskf6fx8h";

  static Future login({required String idUser}) async {
    final userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2h5LW1vZGUtMiJ9.i5a9iT5rz5diTiaMjlADnt1hoz0GqrSdmUJbYn6WKhA";

    /// Create a new instance of [StreamChatClient] passing the apikey obtained from
    /// your project dashboard.
    final client = StreamChatClient(
      's2dxdhpxd94g',
      logLevel: Level.INFO,
    );

    final channel = client.channel(
      'messaging',
      id: 'flutterdevs',
      extraData: {
        'name': 'Flutter devs',
      },
    );

    await channel.watch();

    /// Set the current user and connect the websocket.
    /// In a production scenario, this should be done using a backend to generate
    /// a user token using our server SDK.
    /// Please see the following for more information:
    /// https://getstream.io/chat/docs/ios_user_setup_and_tokens/
    await client.connectUser(
      User(id: 'super-band-9'),
      userToken,
    );
  }
}
