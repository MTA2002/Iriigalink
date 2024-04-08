import 'package:flutter/material.dart';
import 'package:irrigalink/models/chat_model.dart';
import 'package:irrigalink/services/chat_service.dart';

class ChatDetails extends StatefulWidget {
  final dynamic currentUser;
  final dynamic otherUser;

  const ChatDetails(
      {Key? key, required this.currentUser, required this.otherUser})
      : super(key: key);

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.otherUser.name,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(80, 255, 251, 251),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Chat>>(
              stream: ChatService.getChatStream(
                  widget.currentUser.phoneNumber, widget.otherUser.phoneNumber),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return buildChatBubble(snapshot.data![index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChatBubble(Chat chat) {
    bool isCurrentUser = chat.senderId == widget.currentUser.phoneNumber;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          chat.message,
          style: TextStyle(
            fontSize: 14,
            color: isCurrentUser ? Colors.white : Colors.black,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  void sendMessage() async {
    String message = _messageController.text.trim();
    _messageController.clear();

    if (message.isNotEmpty) {
      await ChatService.sendMessage(widget.currentUser.phoneNumber,
          widget.otherUser.phoneNumber, message);
    }
  }
}
