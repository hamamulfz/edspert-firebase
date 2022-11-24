import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/storage_controller.dart';

class StorageView extends GetView<StorageController> {
  const StorageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StorageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StorageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
