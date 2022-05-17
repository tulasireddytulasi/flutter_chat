import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:karkinos_test/models/sections_model_db.dart';
import 'package:karkinos_test/utils/constants.dart';

class QuestionsWidget extends StatefulWidget {
  QuestionsWidget({Key? key, required this.questionsData}) : super(key: key);

  final List<Map<String, dynamic>> questionsData;

  @override
  _QuestionsWidgetState createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  Box<SectionsModelDB> questionsData =
      Hive.box<SectionsModelDB>(sectionBoxName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.questionsData.length,
        itemBuilder: (_, questionIndex) {
          return Container(
            margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
            child: Text(
              "${questionIndex + 1}. " +
                  (widget.questionsData[questionIndex]["question"] ?? ""),
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
