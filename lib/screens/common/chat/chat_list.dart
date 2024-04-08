import 'package:flutter/material.dart';
import 'package:irrigalink/models/distributor_model.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/services/chat_provider.dart';
import 'package:irrigalink/services/distributor_provider.dart';
import 'package:irrigalink/services/farmer_provider.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Provider.of<ChatProvider>(context).chats!.length,
      itemBuilder: (context, index) {
        var chatt = Provider.of<ChatProvider>(context).chats![index];

        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(chatt.user.profilePicture),
              ),
              title: Text(chatt.user.name),
              subtitle: Text(chatt.chat.message),
              trailing: Text(
                "${chatt.chat.timestamp.hour}:${chatt.chat.timestamp.minute}",
              ),
              onTap: () {
                if (chatt.fromFarmer) {
                  Farmer farmer =
                      Provider.of<FarmerProvider>(context, listen: false)
                          .farmer!;
                  Navigator.of(context).pushNamed('/chat_detail',
                      arguments: [farmer, chatt.user]);
                } else {
                  Distributor distributor =
                      Provider.of<DistributorProvider>(context, listen: false)
                          .distributor!;

                  Navigator.of(context).pushNamed('/chat_detail',
                      arguments: [distributor, chatt.user]);
                }
              },
            ),
            const SizedBox(
              height: 3,
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            )
          ],
        );
      },
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:irrigalink/models/chat_model.dart';
import 'package:irrigalink/models/distributor_model.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/services/chat_provider.dart';
import 'package:irrigalink/services/chat_service.dart';
import 'package:irrigalink/services/distributor_provider.dart';
import 'package:irrigalink/services/farmer_provider.dart';
import 'package:provider/provider.dart'; // Import your chat service file

class ChatList extends StatefulWidget {
  final List<Chat> chatList;
  const ChatList({Key? key, required this.chatList}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
      stream: Provider.of<ChatProvider>(context).chatsStream, // Using the ChatProvider stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No users found.'),
          );
        } else {
          List<dynamic> chats = snapshot.data!;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              var chatt = chats[index];

              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(chatt.user.profilePicture),
                    ),
                    title: Text(chatt.user.name),
                    subtitle: Text(chatt.chat.message),
                    trailing: Text(
                      "${chatt.chat.timestamp.toDate().hour}:${chatt.chat.timestamp.toDate().minute}",
                    ),
                    onTap: () {
                      if (chatt.fromFarmer) {
                        Farmer farmer =
                            Provider.of<FarmerProvider>(context, listen: false)
                                .farmer!;
                        Navigator.of(context).pushNamed('/chat_detail',
                            arguments: [farmer, chatt.user]);
                      } else {
                        Distributor distributor =
                            Provider.of<DistributorProvider>(context,
                                    listen: false)
                                .distributor!;

                        Navigator.of(context).pushNamed('/chat_detail',
                            arguments: [distributor, chatt.user]);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}

*/