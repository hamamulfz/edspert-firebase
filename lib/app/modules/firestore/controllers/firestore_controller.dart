import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/chat_item.dart';

class FirestoreController extends GetxController {
  //TODO: Implement FirestoreController
// final ChatRepository _chatRepository;

  final ImagePicker _picker = ImagePicker();
  TextEditingController msgController = TextEditingController();
  final _messages = <ChatItem>[];
  final _isLoadingMessages = false.obs;
  final _selectedFile = Rx<XFile?>(null);

  List<ChatItem> get messages => _messages;
  bool get isLoadingMessages => _isLoadingMessages.value;
  XFile? get selectedFile => _selectedFile.value;

  // Future<void> get retrieveMessages async {
  //   _isLoadingMessages.value = true;
  //   final values = await _chatRepository.messages;
  //   await Future.delayed(const Duration(seconds: 2));
  //   _messages.value = values;
  //   _isLoadingMessages.value = false;
  // }

  @override
  onInit() {
    super.onInit();
    readData();
  }

  Future<void> openCamera() async {
    final cameraFile = await _picker.pickImage(source: ImageSource.camera);
    _selectedFile.value = cameraFile;
  }

  int get messageLength => _messages.length;

  final count = 0.obs;

  void increment() => count.value++;

  final String collectionName = "chats";

  sendChat() {
    if (msgController.text.isEmpty) {
      print("kosong");
      return;
    }
    final payload = {"message": msgController.text};
    print(payload);
    final screeningDb = FirebaseFirestore.instance.collection(collectionName);
    screeningDb.add(payload);
    msgController.text = "";
    // print(prof.toJson());
    // screeningDb.set(prof.toJson());
  }

  CollectionReference getCollection() {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  readData() async {
    final chatDb =
        await FirebaseFirestore.instance.collection(collectionName).get();
    _messages.clear();
    print(chatDb.docs);
    chatDb.docs.asMap().forEach((key, element) {
      var newChat = ChatItem(
        content: element['message'],
        id: 1,
        name: key != 1 ? "User Lain" : "Sender",
        dateTime: DateTime.now(),
      );
      if (newChat.name == "Sender") {
        newChat.isSender = true;
      }

      _messages.add(newChat);
    });

    update();
  }

  clear() async {
    final chatDb = await FirebaseFirestore.instance
        .collection(collectionName)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
    readData();

    update();
  }

  updateData(data) async {
    final chatDb =
        await FirebaseFirestore.instance.collection(collectionName).get();

    // print(prof.toJson());
    // screeningDb.set(prof.toJson());
  }

  delete(data) {
    final screeningDb =
        FirebaseFirestore.instance.collection(collectionName).get();

    // print(prof.toJson());
    // screeningDb.set(prof.toJson());
  }

  pickImage(source) async {
    final img = await ImagePicker().pickImage(
      source: source!,
      maxHeight: 500,
      maxWidth: 500,
    );
    if (img != null) {
      final userId = Random().nextInt(100);
      final refImg =
          FirebaseStorage.instance.ref("$collectionName/$userId.jpg");
      final file = File(img.path);
      final uploaded = await refImg.putFile(file);
      final url = await uploaded.ref.getDownloadURL();
      print(url);

      final data = FirebaseFirestore.instance.collection(collectionName);
      data.add(
        {
          "image": url,
          "message": msgController.text,
        },
      );
      msgController.text = "";
      update();
    }
  }
}
