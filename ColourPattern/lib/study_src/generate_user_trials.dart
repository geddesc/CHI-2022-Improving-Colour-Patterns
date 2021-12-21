import 'dart:math';
import 'package:flutter/material.dart';
import 'package:observationStudyScaffold/models/colour_name.dart';
import 'package:observationStudyScaffold/models/cvd_type.dart';
import 'package:observationStudyScaffold/pages/splash_page.dart';
import 'package:observationStudyScaffold/pages/struggle_page.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_iconizer.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_iconizer_tutorial.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_meters_introduction.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_meters_tutorial.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_meters_widget.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_mix_introduction.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_mix_tutorial.dart';
// import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_mix_widget.dart';
import 'package:observationStudyScaffold/study_src/ColourTasks/colour_selection_task.dart';
import 'package:observationStudyScaffold/study_src/ColourTasks/colour_selection_task_intro.dart';
import 'package:observationStudyScaffold/study_src/ColourTasks/colour_selection_task_tutorial.dart';
import 'package:observationStudyScaffold/study_src/ColourTasks/colour_sorting_task.dart';
import 'package:observationStudyScaffold/study_src/ColourTasks/colour_sorting_task_intro.dart';
import 'package:observationStudyScaffold/study_src/ColourTasks/colour_transition_task.dart';
import 'package:observationStudyScaffold/study_src/ColourTasks/colour_transition_task_intro.dart';
import 'package:observationStudyScaffold/study_src/Survey/consent_form.dart';
import 'package:observationStudyScaffold/study_src/Survey/post_study_questionnaire.dart';
import 'package:observationStudyScaffold/study_src/Survey/pre_study_questionnaire.dart';

import 'ColourPatterns/colour_mixer_widget.dart';

class GenerateUserTrials {
  int treatment;
  CvdType typeOfCVD = CvdType.protan;
  List<Widget Function(Function() onNext)> taskList;

  GenerateUserTrials(this.treatment) {
    // Random rand = Random();
    // treatment = rand.nextInt(4);
    List<Widget Function(BuildContext, double, Color)> techniqueList;
    List<int> patternMethod;
    //treatment = 3;
    if (treatment == 0) {
      // 1 2 4 3
      techniqueList = [
        (context, constraints, color) => Container(),
        (context, constraints, color) =>
            ColourMixerWidget(color: color, square: constraints),
        (context, constraints, color) =>
            ColourMetersWidget(color: color, square: constraints),
        (context, constraints, color) => ColourIconizer(color).getImage(),
      ];
      patternMethod = [0, 1, 3, 2];
    } else if (treatment == 1) {
      // 2 3 1 4
      techniqueList = [
        (context, constraints, color) =>
            ColourMixerWidget(color: color, square: constraints),
        (context, constraints, color) => ColourIconizer(color).getImage(),
        (context, constraints, color) => Container(),
        (context, constraints, color) =>
            ColourMetersWidget(color: color, square: constraints),
      ];
      patternMethod = [1, 2, 0, 3];
    } else if (treatment == 2) {
      // 3 4 2 1
      techniqueList = [
        (context, constraints, color) => ColourIconizer(color).getImage(),
        (context, constraints, color) =>
            ColourMetersWidget(color: color, square: constraints),
        (context, constraints, color) =>
            ColourMixerWidget(color: color, square: constraints),
        (context, constraints, color) => Container(),
      ];
      patternMethod = [2, 3, 1, 0];
    } else {
      // 4 1 3 2
      techniqueList = [
        (context, constraints, color) =>
            ColourMetersWidget(color: color, square: constraints),
        (context, constraints, color) => Container(),
        (context, constraints, color) => ColourIconizer(color).getImage(),
        (context, constraints, color) =>
            ColourMixerWidget(color: color, square: constraints),
      ];
      patternMethod = [3, 0, 2, 1];
    }
    var splashPageList = addSplashPage();
    var consentForm = addConsentFormPage();
    var preStudyQuestionnaire = addPreStudyQuestionnairePage();
    var colourSelectionList = addSelectionTask(techniqueList, patternMethod);
    // var colourTransitionList = addTransitionTask(techniqueList, patternMethod);
    //var colourSortingList = addSortingTask(techniqueList, patternMethod);
    //var postStudyQuestionnaire = addPostStudyQuestionnairePage();
    taskList = [
      //...splashPageList,
      //...consentForm,
      //...preStudyQuestionnaire,
      ...colourSelectionList,
      // ...colourTransitionList,
      //...colourSortingList,
      //...postStudyQuestionnaire,
    ];
  }

  List<Widget Function(Function() onNext)> addSplashPage() {
    List<Widget Function(Function() onNext)> splashPage = [];
    splashPage.add(
      (onNext) => SplashPage(
        onNext: onNext,
      ),
    );
    return splashPage;
  }

  List<Widget Function(Function() onNext)> addConsentFormPage() {
    List<Widget Function(Function() onNext)> consentForm = [];
    consentForm.add(
      (onNext) => ConsentForm(
        onNext: onNext,
      ),
    );
    return consentForm;
  }

  List<Widget Function(Function() onNext)> addPreStudyQuestionnairePage() {
    List<Widget Function(Function() onNext)> preStudyQuestionnaire = [];
    preStudyQuestionnaire.add(
      (onNext) => PreStudyQuestionnaire(
        onNext: onNext,
        //treatment: treatment,
      ),
    );
    return preStudyQuestionnaire;
  }

  List<Widget Function(Function() onNext)> addPostStudyQuestionnairePage() {
    List<Widget Function(Function() onNext)> postStudyQuestionnaire = [];
    postStudyQuestionnaire.add(
      (onNext) => PostStudyQuestionnaire(
        onNext: onNext,
      ),
    );
    return postStudyQuestionnaire;
  }

  List<Widget Function(Function() onNext)> addSelectionTask(
      List<Widget Function(BuildContext, double, Color)> techniqueList,
      List<int> patternMethod) {
    //List sizes = [4, 20, 80, 320];
    List sizes = [4, 20, 80];
    List<num> numberOfReps = [3, 2];
    List<List<int>> numTargetColours = [
      [1, 0, 1, 0, 1, 0],
      [0, 1, 2, 0, 1, 2, 0, 1, 2],
      [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3]
    ];

    List<List<List<int>>> finalRandomColourTargetList = [];

    // numTargetColours[0].shuffle();
    // numTargetColours[1].shuffle();
    // numTargetColours[2].shuffle();
    int numberOfRepsSel = 3;
    for (var t = 0; t < techniqueList.length; t++) {
      List<List<int>> techniqueTargetNum = [];
      for (var i = 0; i < sizes.length; i++) {
        List<int> tempList = [...numTargetColours[i]];
        // TODO: Shuffle once
        tempList.shuffle();
        // print("current size: ${sizes[i]}");
        // print("randomized list of target colour nums: $tempList");
        techniqueTargetNum.add(tempList);
        // for (var j = 0; j < numberOfRepsSel; j++) {

        // }
      }
      finalRandomColourTargetList.add(techniqueTargetNum);
    }
    //print("Final list: $finalRandomColourTargetList");

    List<Widget Function(Function() onNext)> selectionList = [];
    List<ColourName> cols = [
      ColourName.red,
      ColourName.orange,
      ColourName.yellow,
      ColourName.green,
      ColourName.teal,
      ColourName.blue,
      ColourName.purple,
      ColourName.pink,
      ColourName.brown,
      ColourName.grey,
    ];

    for (var t = 0; t < techniqueList.length; t++) {
      selectionList.add(
        (onNext) => ColourSelectionTaskIntro(
            onNext: onNext, patternMethod: patternMethod[t]),
      );
      if (patternMethod[t] == 1) {
        selectionList.add(
          //(onNext) => ColourMixTutorial(onNext: onNext),
          (onNext) => ColourMixIntroduction(onNext: onNext),
        );
      } else if (patternMethod[t] == 2) {
        selectionList.add(
          (onNext) => ColourIconizerTutorial(onNext: onNext),
        );
      } else if (patternMethod[t] == 3) {
        selectionList.add(
          //(onNext) => ColourMetersTutorial(onNext: onNext),
          (onNext) => ColourMetersIntroduction(onNext: onNext),
        );
      }
      //Add technique tutorial
      for (var a = 0; a < 10; a++) {
        if (patternMethod[t] == 0) break;
        selectionList.add(
          (onNext) => ColourSelectionTaskTutorial(
            onNext: onNext,
            colourname: cols[a],
            key: UniqueKey(),
            numberOfColours: 20,
            technique: techniqueList[t],
            patternMethod: patternMethod[t],
            colourPairNumber: a,
            typeOfCVD: CvdType.protan,
          ),
        );
      }

      for (var i = 0; i < sizes.length; i++) {
        // List<int> tempList = numTargetColours[i];
        // // TODO: Shuffle once
        // tempList.shuffle();
        // print("current size: ${sizes[i]}");
        // print("randomized list of target colour nums: $tempList");
        for (var j = 0; j < numberOfRepsSel; j++) {
          //print("${tempList[j]}");
          selectionList.add(
            (onNext) => ColourSelectionTask(
              key: UniqueKey(),
              numberOfColours: sizes[i],
              onNext: onNext,
              typeOfCVD: CvdType.protan,
              technique: techniqueList[t],
              patternMethod: patternMethod[t],
              colourPairNumber: j,
              numTargetColours: finalRandomColourTargetList[t][i][j],//tempList[j],
            ),
          );
        }
      }
      selectionList.add((onNext) => StrugglePage(
            onNext: onNext,
            taskId: 0,
            technique: patternMethod[t],
          ));

      selectionList.add(
        (onNext) => ColourTransitionTaskIntro(
            onNext: onNext, patternMethod: patternMethod[t]),
      );
      // Add transition task
      for (var i = 0; i < 2; i++) {
        for (var j = 0; j < numberOfReps[i]; j++) {
          selectionList.add(
            (onNext) => ColourTransitionTask(
              key: UniqueKey(),
              onNext: onNext,
              cvdType: typeOfCVD,
              technique: techniqueList[t],
              isChroma: i == 1,
              colourNumber: j,
              patternMethod: patternMethod[t],
              secondaryColourNumber: 2,
            ),
          );
        }
      }
      //Add sorting task
      selectionList.add((onNext) => StrugglePage(
            onNext: onNext,
            taskId: 1,
            technique: patternMethod[t],
          ));
      selectionList.add(
        (onNext) => ColourSortingTaskIntro(
            onNext: onNext, patternMethod: patternMethod[t]),
      );
      selectionList.add(
        (onNext) => ColourSortingTask(
            key: UniqueKey(),
            onNext: onNext,
            cvdType: typeOfCVD,
            technique: techniqueList[t],
            patternMethod: patternMethod[t]),
      );
      selectionList.add((onNext) => StrugglePage(
            onNext: onNext,
            taskId: 2,
            technique: patternMethod[t],
          ));
    }

    selectionList.add((onNext) => PostStudyQuestionnaire(
          onNext: onNext,
        ));

    return selectionList;
  }

  List<Widget Function(Function() onNext)> addTransitionTask(
      List<Widget Function(BuildContext, double, Color)> techniqueList,
      List<int> patternMethod) {
    //int numberOfReps = 3;
    List numberOfReps = [3, 2];
    List<Widget Function(Function() onNext)> transitionList = [];
    for (var t = 0; t < techniqueList.length; t++) {
      for (var i = 0; i < 2; i++) {
        for (var j = 0; j < numberOfReps[i]; j++) {
          transitionList.add(
            (onNext) => ColourTransitionTask(
              key: UniqueKey(),
              onNext: onNext,
              cvdType: typeOfCVD,
              technique: techniqueList[t],
              isChroma: i == 1,
              colourNumber: j,
              patternMethod: patternMethod[t],
              secondaryColourNumber: 2,
            ),
          );
        }
      }
    }
    return transitionList;
  }

  List<Widget Function(Function() onNext)> addSortingTask(
      List<Widget Function(BuildContext, double, Color)> techniqueList,
      List<int> patternMethod) {
    //int numberOfReps = 1;
    //int numberOfColours = 25;
    List<Widget Function(Function() onNext)> transitionList = [];
    for (var t = 0; t < techniqueList.length; t++) {
      transitionList.add(
        (onNext) => ColourSortingTask(
            key: UniqueKey(),
            onNext: onNext,
            cvdType: typeOfCVD,
            technique: techniqueList[t],
            patternMethod: patternMethod[t]),
      );
    }
    return transitionList;
  }
}
