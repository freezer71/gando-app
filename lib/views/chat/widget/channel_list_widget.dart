
import 'package:flutter/material.dart';
import 'package:gando/views/chat/widget/profile_image_widget.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


class ChannelListWidget extends StatelessWidget {
  final Channel channel;

  const ChannelListWidget({
    Key? key,
    required this.channel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = channel.extraData['name'].toString();
    final urlImage = channel.extraData['image'].toString();

    final hasMessage = channel.state!.messages.isNotEmpty;
    final lastMessage = hasMessage ? channel.state!.messages.last.text.toString() : '';
    final lastMessageAt = _formatDateTime(channel.lastMessageAt!);

    return buildChannel(
      context,
      channel: channel,
      name: name,
      urlImage: urlImage,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
    );
  }

  Widget buildChannel(
    BuildContext context, {
    required Channel channel,
    required String name,
    required String urlImage,
    required String lastMessage,
    required String lastMessageAt,
  }) =>
      ListTile(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => ChatPageMobile(channel: channel),
          // ));
        },
        leading: ProfileImageWidget(imageUrl: urlImage),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Expanded(child: Text(lastMessage)),
            Text(lastMessageAt),
          ],
        ),
      );

  String _formatDateTime(DateTime lastMessageAt) {
    if (lastMessageAt == null) return '';

    final isRecently = lastMessageAt.difference(DateTime.now()).inDays == 0;
    final dateFormat = isRecently ? DateFormat.jm() : DateFormat.MMMd();

    return dateFormat.format(lastMessageAt);
  }
}
