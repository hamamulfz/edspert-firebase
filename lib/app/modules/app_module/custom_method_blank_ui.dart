import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_package/blank_ui.dart';

class CustomMethodBlankUI extends BlankUI {
  CustomMethodBlankUI({super.key});

  @override
  Widget buildBody() {
    // TODO: implement buildBody
    return Text("Halo, ini blank UI di edit");
  }

  @override
  // TODO: implement appBar
  AppBar get appBar => AppBar(
    title: Text("New Title"),
    backgroundColor: Colors.red,
  );
}