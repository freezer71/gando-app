import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = StreamChat.of(context).client.state.currentUser;
    // final urlImage = user!.extraData['image'].toString();

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        child: CircleAvatar(
          // backgroundImage: NetworkImage(urlImage),
        ),
      ),
    );
  }
}
