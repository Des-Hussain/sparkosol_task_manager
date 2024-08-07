import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sparkosol_task_manager/app/app.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: SparkosolTaskManager()));
}
