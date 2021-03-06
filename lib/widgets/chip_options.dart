import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:karkinos_test/providers/chat_bot_provider.dart';
import 'package:karkinos_test/utils/colors.dart';
import 'package:karkinos_test/utils/constants.dart';
import 'package:provider/provider.dart';

class ChipOptions extends StatefulWidget {
  const ChipOptions(
      {Key? key,
      required this.chipOptions,
      required this.nextQuestionIds,
      required this.isLastQuestion})
      : super(key: key);
  final List<String> chipOptions;
  final List<String> nextQuestionIds;
  final bool isLastQuestion;

  @override
  _ChipOptionsState createState() => _ChipOptionsState();
}

class _ChipOptionsState extends State<ChipOptions> {
  bool isTapped = true;
  Map thankYou = {
    "question_id": "thank_you",
    "question": "Thank you for taking assessment.",
    "options": null,
    "selectedOptionsIndex": [],
    "answer": null,
    "option_key": null,
    "type": null,
    "next_question_id": null,
    "last_question": null
  };
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBotProvider>(builder: (context, provider, child) {
      return Container(
        // If the chipOptions Length is greater than 4
        // we should show in grid view
        alignment: Alignment.topRight,
        child: widget.chipOptions.length > 4
            ? Wrap(
                runSpacing: 1,
                spacing: 1,
                alignment: WrapAlignment.end,
                children: chipOptionList(
                    chipOptions: widget.chipOptions,
                    nextQuestionIds: widget.nextQuestionIds,
                    isLastQuestion: widget.isLastQuestion),
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: chipOptionList(
                    chipOptions: widget.chipOptions,
                    nextQuestionIds: widget.nextQuestionIds,
                    isLastQuestion: widget.isLastQuestion),
              ),
      );
    });
  }

  List<Widget> chipOptionList(
      {required List<String> chipOptions,
      required List<String> nextQuestionIds,
      required bool isLastQuestion}) {
    ChatBotProvider chatBotProvider =
        Provider.of<ChatBotProvider>(context, listen: false);
    return List<Widget>.generate(chipOptions.length, (int index) {
      return Container(
        alignment: chipOptions.length > 4 ? null : Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            if (isTapped) {
              // isTapped = false;
              log(chipOptions[index]);
              log(isLastQuestion.toString());
              // if (nextQuestionIds.isNotEmpty) {
              log("List: ${chatBotProvider.displayQuestionsMapList}\n\n");
              chatBotProvider.displayQuestionsMapList[0]
                  ["selectedOptionsIndex"] = [index];
              chatBotProvider.displayQuestionsMapList[0]["answer"] =
                  chipOptions[index];
              log("List: ${chatBotProvider.displayQuestionsMapList}\n\n");
              Map map = {};
              // log("Data5: ${chatBotProvider.questionnairesMap}");
              if (isLastQuestion) {
                log("isLastQuestion: $isLastQuestion");
                chatBotProvider.addDisplayQuestionsMapList(maps: thankYou);
              } else {
                if (nextQuestionIds.isNotEmpty) {
                  log(nextQuestionIds[index]);
                  log("Data5: ${chatBotProvider.questionnairesMap[nextQuestionIds[index]]}\n");
                  map =
                      chatBotProvider.questionnairesMap[nextQuestionIds[index]];
                  log("isLastQuestion 7: $isLastQuestion");
                  chatBotProvider.addDisplayQuestionsMapList(maps: map);
                }
              }
              //  }
            }
          },
          child: Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: LIGHT_PINK_1,
              border: Border.all(width: 1, color: LIGHT_PINK_1),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Text(
              chipOptions[index],
              style: const TextStyle(
                  fontSize: 14, color: BLACK4, fontFamily: MONTSERRAT_REGULAR),
            ),
          ),
        ),
      );
    });
  }
}
