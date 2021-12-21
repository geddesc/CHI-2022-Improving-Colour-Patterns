import 'package:flutter/material.dart';
import 'package:observationStudyScaffold/components/approve_button.dart';
import 'package:observationStudyScaffold/components/study_header.dart';
import 'package:observationStudyScaffold/components/study_subtitle.dart';
import 'package:observationStudyScaffold/pages/custom_route.dart';
import 'package:observationStudyScaffold/study_src/StudyData/colour_task_data.dart';
import 'package:observationStudyScaffold/study_src/StudyData/provider_data.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  final Function onNext;
  SplashPage({this.onNext});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    //var colourTaskData = context.watch<ColourTaskData>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      // minWidth: 250,
                      // maxWidth: 500,
                      maxHeight: 500,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 250,
                              maxWidth: 500,
                              //maxHeight: 500,
                            ),
                            child: StudyHeader(
                                header:
                                    "Using Colour Patterns to Assist People with Colour Vision Deficiency."),
                          ),
                          //Spacer(),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 250,
                              maxWidth: 500,
                              //maxHeight: 500,
                            ),
                                                      child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: StudySubTitle(
                                  title:
                                      "This research project is concerned with evaluating the potential effectiveness of varying types of colour patterns in assisting individuals with Colour Vision Deficiency (CVD - commonly referred to as colour blindness) to more greatly distinguish and intrepret colours. This study involves the completion of 3 computer based performance tasks, and the completion of both a pre and post study questionnaire. Through the tasks you will be asked to select colours from amongst distractors, order colours to fufill a gradient, and sort colours into a specific named term. The tasks will be repeated with each of the 3 colour patterns being explored (CVD participants), as well as without any assistance (no patterns - for both CVD and non-CVD participants)."),
                            ),
                          ),
                          //Spacer(),
                          //Expanded(
                          Center(
                            child: Provider<ColourTaskData>(
                              create: (context) => colourTaskData,
                              child: ApproveButton(
                                onPressed: () {
                                  colourTaskData.startingStudyTime =
                                      DateTime.now().millisecondsSinceEpoch;
                                  Navigator.of(context).pushReplacement(
                                      CustomRoute(builder: (context) {
                                    return widget.onNext();
                                  }));
                                },
                              ),
                            ),
                          ),
                          //),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
