import 'package:flutter/material.dart';

abstract class Dispatcher {
  void dispatch(BuildContext context, String params);

  void dispatchAction(BuildContext context, VoidCallback callback);
}
