import 'package:flutter/material.dart';
import 'package:observationStudyScaffold/study_src/StudyData/colour_selection_task_model.dart';
import 'package:observationStudyScaffold/study_src/StudyData/colour_sort_task_model.dart';
import 'package:observationStudyScaffold/study_src/StudyData/colour_task_data.dart';
import 'package:observationStudyScaffold/study_src/StudyData/colour_transition_task_model.dart';
import 'package:observationStudyScaffold/study_src/StudyData/post_study_questionnaire_data.dart';
import 'package:observationStudyScaffold/study_src/StudyData/pre_study_questionnaire_data.dart';
import 'package:observationStudyScaffold/study_src/StudyData/provider_data.dart';
import 'package:observationStudyScaffold/study_src/StudyData/struggle_feedback_model.dart';
import 'package:observationStudyScaffold/theme/design_theme.dart';
import 'package:provider/provider.dart';

class StudyCompletePage extends StatelessWidget {
  final Function onPressed;

  StudyCompletePage({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Provider<ColourTaskData>(
        create: (context) => colourTaskData,
        builder: (context, child) {

          var appBar = AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Study Complete',
              style: TextStyle(
                fontSize: DesignTheme.headerFontSize,
                color: Colors.black,
              ),
            ),
          );

          return Scaffold(
            appBar: appBar,
            body: Center(
              child: Text(
                  "Congratulations, You have completed the study! Thank you for participating!"),
            ),
          );
        });
  }
}
