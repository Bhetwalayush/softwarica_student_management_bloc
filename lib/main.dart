import 'package:flutter/cupertino.dart';
import 'package:softwarica_student_management_bloc/app/app.dart';
import 'package:softwarica_student_management_bloc/app/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(
    App(),
  );
}
