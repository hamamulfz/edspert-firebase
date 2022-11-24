import 'package:flutter/material.dart';
import 'package:new_package/new_package.dart';

class OutsideWidgetCall extends StatelessWidget {
  const OutsideWidgetCall({super.key});

  @override
  Widget build(BuildContext context) {
    return BlankUI(
      body: Icon(Icons.smart_button),
    );
  }
}
