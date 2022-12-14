
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_list_widget.dart';

class ChatsWidget extends StatelessWidget {
  const ChatsWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = StreamChannelListController(client: StreamChat.of(context).client);
    final idUser = StreamChat.of(context).client.state.currentUser!.id;


    return StreamChannelListView(
        controller: controller
    );
    //
    // ChannelListView(
    //   filter: {
    //     'members': {
    //       '\$in': [idUser],
    //     }
    //   },
    //   sort: const [SortOption('last_message_at')],
    //   pagination: PaginationParams(limit: 20),
    //   channelPreviewBuilder: (context, channel) =>
    //       ChannelListWidget(channel: channel),
    // );
  }
}
