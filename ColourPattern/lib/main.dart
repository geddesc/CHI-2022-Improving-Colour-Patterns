// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:observationStudyScaffold/pages/splash_page.dart';
import 'package:observationStudyScaffold/pages/study_complete_page.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_mix_introduction.dart';
import 'package:observationStudyScaffold/study_src/ColourTasks/colour_selection_task_intro.dart';
//import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_iconizer_widget.dart';
//import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_iconizer_widget.dart';
import 'package:observationStudyScaffold/study_src/StudyData/colour_task_data.dart';
import 'package:observationStudyScaffold/study_src/StudyData/provider_data.dart';
import 'package:observationStudyScaffold/study_src/Survey/consent_form.dart';
import 'package:observationStudyScaffold/study_src/Survey/post_study_questionnaire.dart';
import 'package:observationStudyScaffold/study_src/Survey/pre_study_questionnaire.dart';
import 'package:observationStudyScaffold/study_src/generate_user_trials.dart';
import 'package:observationStudyScaffold/study_src/task.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    StudyScaffold(),
  );
}

class StudyScaffold extends StatefulWidget {
  @override
  _StudyScaffoldState createState() => _StudyScaffoldState();
}

class _StudyScaffoldState extends State<StudyScaffold> {
  List<Widget Function(Function() onNext)> test = [
    // (onNext) => StrugglePage(
    //       onNext: onNext,
    //       taskId: 0,
    //       technique: 0,
    //     ),
    (onNext) => PostStudyQuestionnaire(
          onNext: onNext,
        ),
    (onNext) => ColourMixIntroduction(onNext: onNext),
    (onNext) => ColourSelectionTaskIntro(onNext: onNext),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    //colourTaskData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
      create: (context) => colourTaskData,
      child: SplashPage(
        onNext: () {
          return ConsentForm(onNext: () {
            return PreStudyQuestionnaire(
              onNext: (int treatment) {
                return Task(
                  list: GenerateUserTrials(treatment).taskList,
                  completionWidget: StudyCompletePage(),
                );
              },
            );
          });
        },
      ),
      // child: Task(
      //   //list: test,
      //   list: GenerateUserTrials().taskList,
      //   completionWidget: StudyCompletePage(),
      // ),
    ));
  }
}
