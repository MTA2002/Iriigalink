import 'dart:async';

import 'package:flutter/material.dart';
import 'package:irrigalink/services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  List? _chats;
  StreamSubscription<List>? _streamSubscription;

  List? get chats => _chats;

  ChatProvider() {
    _chats = [];
    _listenToChatsStream();
  }

  void _listenToChatsStream() {
    _streamSubscription?.cancel();
    _streamSubscription =
        ChatService.getChattedUsersStream().listen((List<dynamic> data) {
      setChat(data);
    });
  }

  void setChat(List chat) {
    _chats = chat;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
