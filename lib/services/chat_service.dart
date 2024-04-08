import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irrigalink/models/chat_model.dart';
import 'package:irrigalink/models/distributor_model.dart';
import 'package:irrigalink/models/farmer_model.dart';
import 'package:irrigalink/services/distributorService.dart';
import 'package:irrigalink/services/farmer_service.dart';

class ChatService {
  static final CollectionReference _chats =
      FirebaseFirestore.instance.collection('chats');
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<List<Chat>> getChatStream(String senderId, String receiverId) {
    List sorted = [senderId, receiverId];
    sorted.sort();
    return _chats
        .where('chatRoomId', isEqualTo: sorted)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Chat.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  static Future<void> sendMessage(
      String senderId, String receiverId, String message) async {
    List chatRoomId = [senderId, receiverId];
    chatRoomId.sort();
    await _chats.add({
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Stream<List<dynamic>> getChattedUsersStream() async* {
    FirebaseAuth auth = FirebaseAuth.instance;

    while (true) {
      await Future.delayed(const Duration(microseconds: 1));

      if (auth.currentUser != null) {
        var userId = auth.currentUser!.phoneNumber;
        String? userPhoneNumber = auth.currentUser!.phoneNumber;

        CollectionReference farmers =
            FirebaseFirestore.instance.collection('farmers');
        QuerySnapshot<Object?> farmerQuery = await farmers
            .where("phone_number", isEqualTo: userPhoneNumber)
            .get();

        if (farmerQuery.docs.isEmpty) {
          yield await getChattedFarmers(userId!);
        } else {
          yield await getChattedDistributors(userId!);
        }
      } else {
        yield [];
      }
    }
  }

  // static Stream<List<dynamic>> getChattedUsersStream() {
  //   FirebaseAuth auth = FirebaseAuth.instance;

  //   return StreamController<List<dynamic>>.broadcast(
  //     onListen: () async {
  //       if (auth.currentUser != null) {
  //         var userId = auth.currentUser!.phoneNumber;
  //         String? userPhoneNumber = auth.currentUser!.phoneNumber;

  //         CollectionReference farmers =
  //             FirebaseFirestore.instance.collection('farmers');
  //         StreamSubscription<QuerySnapshot<Object?>> subscription;

  //         subscription = farmers
  //             .where("phone_number", isEqualTo: userPhoneNumber)
  //             .snapshots()
  //             .listen((QuerySnapshot<Object?> farmerQuery) async {
  //           if (farmerQuery.docs.isEmpty) {
  //             List<dynamic> userList = await getChattedFarmers(userId!);
  //             _controller.add(userList);
  //           } else {
  //             List<dynamic> userList = await getChattedDistributors(userId!);
  //             _controller.add(userList);
  //           }
  //         });

  //         _controller.onCancel = () => subscription.cancel();
  //       } else {
  //         _controller.add([]);
  //       }
  //     },
  //   ).stream;
  // }

  static Future<List<ChatUser>> getChattedFarmers(String distributorId) async {
    try {
      QuerySnapshot<Object?> querySnapshot =
          await _chats.where('chatRoomId', arrayContains: distributorId).get();
      Set<String> uniqueFarmers = Set<String>();

      for (var doc in querySnapshot.docs) {
        List<dynamic> chatRoomId = doc['chatRoomId'];
        uniqueFarmers.add(
            chatRoomId[0] == distributorId ? chatRoomId[1] : chatRoomId[0]);
      }
      List<String> farmersIds = uniqueFarmers.toList();

      // Fetch farmer details for each ID
      List<Farmer> farmers = await FarmerService.getFarmersByIds(farmersIds);
      List<ChatUser> chatFarmers = [];
      for (var farmer in farmers) {
        var sorted = [farmer.phoneNumber, _auth.currentUser!.phoneNumber];
        sorted.sort();
        QuerySnapshot<Object?> query = await _chats
            .where('chatRoomId', isEqualTo: sorted)
            .orderBy('timestamp', descending: true)
            .get();
        Chat chat =
            Chat.fromMap(query.docs.first.data() as Map<String, dynamic>);
        chat.timestamp = chat.timestamp.toDate();
        chatFarmers.add(ChatUser(chat: chat, user: farmer, fromFarmer: false));
      }
      return chatFarmers;
    } catch (e) {
      print("Error getting chatted farmers: $e");
      return [];
    }
  }

  static Future<List<ChatUser>> getChattedDistributors(String farmerId) async {
    try {
      QuerySnapshot<Object?> querySnapshot =
          await _chats.where('chatRoomId', arrayContains: farmerId).get();

      Set<String> uniqueDistributors = Set<String>();

      querySnapshot.docs.forEach((doc) {
        List<dynamic> chatRoomId = doc['chatRoomId'];
        uniqueDistributors
            .add(chatRoomId[0] == farmerId ? chatRoomId[1] : chatRoomId[0]);
      });

      List<String> distributorsIds = uniqueDistributors.toList();

      // Fetch distributor details for each ID
      List<Distributor> distributors =
          await DistributorService.getDistributorsByIds(distributorsIds);
      List<ChatUser> chatDistributors = [];
      for (var distributor in distributors) {
        var sorted = [distributor.phoneNumber, _auth.currentUser!.phoneNumber];
        sorted.sort();
        QuerySnapshot<Object?> query = await _chats
            .where('chatRoomId', isEqualTo: sorted)
            .orderBy('timestamp', descending: true)
            .get();
        Chat chat =
            Chat.fromMap(query.docs.first.data() as Map<String, dynamic>);
        chat.timestamp = chat.timestamp.toDate();

        chatDistributors
            .add(ChatUser(chat: chat, user: distributor, fromFarmer: true));
      }
      return chatDistributors;
    } catch (e) {
      print("Error getting chatted distributors: $e");
      return [];
    }
  }
  // static Future<List<ChatUser>> getChattedFarmers(String distributorId) async {
  //   try {
  //     QuerySnapshot<Object?> querySnapshot =
  //         await _chats.where('chatRoomId', arrayContains: distributorId).get();
  //     Set<String> uniqueFarmers = Set<String>();

  //     for (var doc in querySnapshot.docs) {
  //       List<dynamic> chatRoomId = doc['chatRoomId'];
  //       uniqueFarmers.add(
  //           chatRoomId[0] == distributorId ? chatRoomId[1] : chatRoomId[0]);
  //     }
  //     List<String> farmersIds = uniqueFarmers.toList();

  //     // Fetch farmer details for each ID
  //     List<Farmer> farmers = await FarmerService.getFarmersByIds(farmersIds);
  //     List<ChatUser> chatFarmer = [];
  //     for (var farmer in farmers) {
  //       var sorted = [farmer.phoneNumber, _auth.currentUser!.phoneNumber];
  //       sorted.sort();
  //       QuerySnapshot<Object?> query = await _chats
  //           .where('chatRoomId', isEqualTo: sorted)
  //           .orderBy('timestamp', descending: true)
  //           .get();
  //       Chat chat =
  //           Chat.fromMap(query.docs.first.data() as Map<String, dynamic>);
  //       chatFarmer.add(ChatUser(chat: chat, user: farmer, fromFarmer: false));
  //     }
  //     return chatFarmer;
  //   } catch (e) {
  //     print("Error getting chatted farmers: $e");
  //     return [];
  //   }
  // }

  // static Future<List<ChatUser>> getChattedDistributors(String farmerId) async {
  //   try {
  //     QuerySnapshot<Object?> querySnapshot =
  //         await _chats.where('chatRoomId', arrayContains: farmerId).get();

  //     Set<String> uniqueDistributors = Set<String>();

  //     querySnapshot.docs.forEach((doc) {
  //       List<dynamic> chatRoomId = doc['chatRoomId'];
  //       uniqueDistributors
  //           .add(chatRoomId[0] == farmerId ? chatRoomId[1] : chatRoomId[0]);
  //     });

  //     List<String> distributorsIds = uniqueDistributors.toList();

  //     // Fetch distributor details for each ID
  //     List<Distributor> distributors =
  //         await DistributorService.getDistributorsByIds(distributorsIds);
  //     List<ChatUser> chatDist = [];
  //     for (var distributor in distributors) {
  //       var sorted = [distributor.phoneNumber, _auth.currentUser!.phoneNumber];
  //       sorted.sort();
  //       QuerySnapshot<Object?> query = await _chats
  //           .where('chatRoomId', isEqualTo: sorted)
  //           .orderBy('timestamp', descending: true)
  //           .get();
  //       Chat chat =
  //           Chat.fromMap(query.docs.first.data() as Map<String, dynamic>);
  //       chatDist.add(ChatUser(chat: chat, user: distributor, fromFarmer: true));
  //     }
  //     return chatDist;
  //   } catch (e) {
  //     print("Error getting chatted distributors: $e");
  //     return [];
  //   }
  // }

  // static Future<List<ChatUser>> getChatUsers() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   var userId = auth.currentUser!.phoneNumber;

  //   String? userPhoneNumber = auth.currentUser!.phoneNumber;
  //   CollectionReference farmers =
  //       FirebaseFirestore.instance.collection('farmers');
  //   var value =
  //       await farmers.where("phone_number", isEqualTo: userPhoneNumber).get();
  //   if (value.docs.isEmpty) {
  //     List<ChatUser> farmers = await getChattedFarmers(userId!);
  //     return farmers;
  //   } else {
  //     List<ChatUser> distributors = await getChattedDistributors(userId!);
  //     return distributors;
  //   }
  // }
}

class ChatUser {
  dynamic user;
  Chat chat;
  bool fromFarmer;
  ChatUser({required this.chat, required this.user, required this.fromFarmer});
}
