import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:karkinos_test/models/questionnaires_model_db.dart';
import 'package:karkinos_test/providers/chat_bot_provider.dart';
import 'package:karkinos_test/widgets/chip_options.dart';
import 'package:karkinos_test/widgets/custom_chip.dart';
import 'package:karkinos_test/widgets/question_widget.dart';
import 'package:provider/provider.dart';

class AskKarkinos extends StatefulWidget {
  const AskKarkinos({Key? key}) : super(key: key);

  @override
  State<AskKarkinos> createState() => _AskKarkinosState();
}

class _AskKarkinosState extends State<AskKarkinos> {
  // Box<SectionsModelDB> questionsData =
  //     Hive.box<SectionsModelDB>(sectionBoxName);

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ChatBotProvider chatBotProvider =
        Provider.of<ChatBotProvider>(context, listen: false);
    await chatBotProvider.addSectionsData(context: context);

    log("QQQ2: ${chatBotProvider.questionsData.getAt(0)?.questionnaires.length}");
    List<QuestionnairesModelDB> map = [];
    map = chatBotProvider.questionsData.getAt(0)?.questionnaires
        as List<QuestionnairesModelDB>;
    log("QQQ3: ${map.elementAt(0)}");
    chatBotProvider.setMapData(questionsModelList: map);

    /// Adds only first Question Map Object
    chatBotProvider.setDisplayQuestionsMapList(
        maps: chatBotProvider.questionnairesMap);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBotProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Ask Karkinos"),
          leading: IconButton(
            onPressed: () {
              provider.clearAllData();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (provider.displayQuestionsMapList.isNotEmpty)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      child: ListView.builder(
                        // shrinkWrap: true,
                        reverse: true,
                        //  physics: const NeverScrollableScrollPhysics(),
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: provider.displayQuestionsMapList.length,
                        itemBuilder: (_, questionIndex) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10),
                                QuestionWidget(
                                  question: provider.displayQuestionsMapList[
                                          questionIndex]["question"] ??
                                      "",
                                  time: DateTime.now(),
                                ),
                                const SizedBox(height: 10),
                                questionIndex == 0
                                    ? ChipOptions(
                                        chipOptions:
                                            provider.displayQuestionsMapList[
                                                    questionIndex]["options"] ??
                                                [],
                                        nextQuestionIds:
                                            provider.displayQuestionsMapList[
                                                        questionIndex]
                                                    ["next_question_id"] ??
                                                [],
                                        isLastQuestion:
                                            provider.displayQuestionsMapList[
                                                        questionIndex]
                                                    ["last_question"] ??
                                                false)
                                    : Container(
                                        alignment: Alignment.topRight,
                                        child: CustomChip(
                                            answer: provider
                                                    .displayQuestionsMapList[
                                                questionIndex]["answer"]),
                                      ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                if (provider.displayQuestionsMapList.isEmpty)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        "No Questions Data",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
