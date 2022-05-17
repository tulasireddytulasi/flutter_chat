import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:karkinos_test/models/questionnaires_model_db.dart';
import 'package:karkinos_test/models/sections_model_db.dart';
import 'package:karkinos_test/providers/chat_bot_provider.dart';
import 'package:karkinos_test/utils/constants.dart';
import 'package:karkinos_test/views/dashboard/dashboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(applicationDocumentDir.path);
  Hive.registerAdapter(SectionsModelDBAdapter());
  Hive.registerAdapter(QuestionnairesModelDBAdapter());
  await Hive.openBox<SectionsModelDB>(sectionBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ChatBotProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Dashboard(),
      ),
    );
  }
}
