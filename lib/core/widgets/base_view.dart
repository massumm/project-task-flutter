import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseView<T> extends GetView<T>{
  const BaseView({super.key});
  PreferredSizeWidget? appBar(BuildContext context) => null;

  Widget? floatingActionButton(BuildContext context) => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: body(context),
        ),
      ),
      floatingActionButton: floatingActionButton(context),
    );
  }
  Widget body(BuildContext context);

}