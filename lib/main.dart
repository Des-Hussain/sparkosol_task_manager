import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkosol_task_manager/app/app.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(ProviderScope(child: SparkosolTaskManager()));
}
