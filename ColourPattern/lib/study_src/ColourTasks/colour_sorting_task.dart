import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:observationStudyScaffold/models/cvd_type.dart';
import 'package:observationStudyScaffold/pages/ineligible_page.dart';
import 'package:observationStudyScaffold/study_src/ColourDictionary/colour_sorting_list.dart';
import 'package:observationStudyScaffold/study_src/ColourPatterns/colour_namer.dart';
import 'package:observationStudyScaffold/study_src/StudyData/colour_sort_task_model.dart';
import 'package:observationStudyScaffold/study_src/StudyData/colour_task_data.dart';
import 'package:observationStudyScaffold/study_src/StudyData/provider_data.dart';
import 'package:observationStudyScaffold/theme/design_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColourSortingTask extends StatefulWidget {
  final Function onNext;
  final CvdType cvdType;
  final Widget Function(BuildContext context, double constraints, Color color)
      technique;
  final int patternMethod;

  ColourSortingTask({
    @required Key key,
    @required this.onNext,
    @required this.cvdType,
    @required this.technique,
    @required this.patternMethod,
  }) : super(key: key);
  @override
  _ColourSortingTaskState createState() => _ColourSortingTaskState();
}

class _ColourSortingTaskState extends State<ColourSortingTask> {
  bool skip = false;
  bool ineligible = false;
  @override
  Widget build(BuildContext context) {
    //var colourTaskData = context.watch<ColourTaskData>();
    return Provider<ColourTaskData>(
        create: (context) => colourTaskData,
        builder: (context, child) {
          var cvdString = colourTaskData.preStudyData.cvdType;
          var device = colourTaskData.preStudyData.deviceCode == 0;
          int ageGroup = colourTaskData.preStudyData.ageGroup;
          bool alreadyParticipated =
              colourTaskData.preStudyData.alreadyParticipated;
          CvdType cvd;
          int patternNum;

          if (cvdString == "Protan") {
            patternNum = widget.patternMethod;
            cvd = CvdType.protan;
          } else if (cvdString == "Deutan") {
            patternNum = widget.patternMethod;
            cvd = CvdType.deutan;
          } else if (cvdString == "Tritan") {
            patternNum = widget.patternMethod;
            cvd = CvdType.tritan;
          } else if (cvdString == "None") {
            patternNum = 0;
            if (widget.patternMethod == 3) {
              skip = true;
            }
            cvd = CvdType.normal;
          } else if (cvdString == "Monochromacy") {
            patternNum = widget.patternMethod;
            cvd = CvdType.monochromat;
          }

          if (ageGroup == 0 || alreadyParticipated) {
            ineligible = true;
          }

          if (skip) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              setState(() {
                widget.onNext();
              });
            });
          }
          if (ineligible) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => IneligiblePage()));
            });
          }

          return (skip || ineligible)
              ? Container()
              : ColourSortingTask2(
                  key: widget.key,
                  onNext: widget.onNext,
                  cvdType: cvd,
                  technique: widget.technique,
                  patternMethod: patternNum,
                  isMobile: device,
                );
        });
  }
}

class ColourSortingTask2 extends StatefulWidget {
  final Function onNext;
  final CvdType cvdType;
  final Widget Function(BuildContext context, double constraints, Color color)
      technique;
  final int patternMethod;
  final bool isMobile;

  ColourSortingTask2({
    @required Key key,
    @required this.onNext,
    @required this.cvdType,
    @required this.technique,
    @required this.patternMethod,
    @required this.isMobile,
  }) : super(key: key);
  @override
  _ColourSortingTaskState2 createState() => _ColourSortingTaskState2();
}

class _ColourSortingTaskState2 extends State<ColourSortingTask2> {
  final keyIsFirstLoaded = 'is_first_loaded';
  List<List<String>> taskColourNames = [
    [
      "red",
      "orange",
      "yellow",
      "green",
      "teal",
    ],
    [
      "blue",
      "purple",
      "pink",
      "grey",
      "brown",
    ],
  ];
  List<Color> colourList = [];
  List<Color> begColourList = [];
  Map<String, List<Color>> colourNameLists = {};
  Stopwatch myStopWatch;
  Map<Color, String> answerColourSort = {Colors.pink: "pink", Colors.pinkAccent: "pink", Colors.red: "red", Colors.redAccent: "red", Colors.deepOrange: "orange", Colors.deepOrangeAccent: "orange", Colors.orange: "orange", Colors.orangeAccent: "orange", Colors.yellow: "yellow", Colors.yellowAccent: "yellow", Colors.lightGreen: "green", Colors.lightGreenAccent: "green", Colors.green: "green", Colors.greenAccent: "green", Colors.teal: "teal", Colors.tealAccent: "teal", Colors.lightBlue: "blue", Colors.lightBlueAccent: "blue", Colors.blue: "blue", Colors.blueAccent: "blue", Colors.purple: "purple", Colors.purpleAccent: "purple", Colors.deepPurple: "purple", Colors.deepPurpleAccent: "purple", Colors.blueGrey: "grey", Colors.grey: "grey", Colors.brown: "brown",};
  int startTime;
  int endTime;

  @override
  void initState() {
    super.initState();
    taskColourNames.forEach((colourNames) {
      colourNames.forEach((colourName) {
        colourNameLists[colourName] = [];
      });
    });
    int len = colourSortList.length;
    Random ran = Random();
    // for (var i = 0; i < 25; i++) {
    //   int index = ran.nextInt(len);
    //   colourList.add(colourSortList[index]);
    // }
    colourList = [Colors.pink, Colors.pinkAccent, Colors.red, Colors.redAccent, Colors.deepOrange, Colors.deepOrangeAccent, Colors.orange, Colors.orangeAccent, Colors.yellow, Colors.yellowAccent, Colors.lightGreen, Colors.lightGreenAccent, Colors.green, Colors.greenAccent, Colors.teal, Colors.tealAccent, Colors.lightBlue, Colors.lightBlueAccent, Colors.blue, Colors.blueAccent, Colors.purple, Colors.purpleAccent, Colors.deepPurple, Colors.deepPurpleAccent, Colors.blueGrey, Colors.brown, Colors.grey];
    colourList.shuffle();
    colourList.forEach((colour) {
      begColourList.add(colour);
    });
    myStopWatch = Stopwatch()..start();
    startTime = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    //var colourTaskData = context.watch<ColourTaskData>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    if ((height < 500 || widget.isMobile) && height < width) {
      Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    }
    return Provider<ColourTaskData>(
        create: (context) => colourTaskData,
        builder: (context, child) {
          AppBar appBar = AppBar(
            elevation: 0,
            centerTitle: true,
            title: FittedBox(
              child: Text(
                "Sort each colour to the correct term",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: DesignTheme.headerFontSize,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          );

          return Scaffold(
            appBar: appBar,
            backgroundColor: Colors.grey[700],
            body: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenMin =
                      (constraints.maxHeight > constraints.maxWidth)
                          ? constraints.maxWidth
                          : constraints.maxHeight;
                  return Container(
                    height: screenMin,
                    width: screenMin,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: FittedBox(
                            child: Text(
                              "${colourList.length} Colours left to sort",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: LayoutBuilder(
                                  builder: (context, constrainers) {
                                    final theSize = (constraints.maxHeight >
                                            constraints.maxWidth)
                                        ? constraints.maxWidth
                                        : constraints.maxHeight;
                                    return Container(
                                      height: theSize,
                                      width: theSize,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          for (var i = 0;
                                              i < taskColourNames.length;
                                              i++)
                                            Expanded(
                                              child: Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  for (var j = 0;
                                                      j <
                                                          taskColourNames[i]
                                                              .length;
                                                      j++)
                                                    Expanded(
                                                      child: LayoutBuilder(
                                                        builder: (context,
                                                            contraints) {
                                                          final size = (constraints
                                                                      .maxHeight >
                                                                  constraints
                                                                      .maxWidth)
                                                              ? constraints
                                                                  .maxWidth
                                                              : constraints
                                                                  .maxHeight;
                                                          return _buildColourTargets(
                                                              taskColourNames[i]
                                                                  [j],
                                                              size);
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Spacer(),
                              Flexible(
                                flex: 1,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final size = (constraints.maxHeight >
                                            constraints.maxWidth)
                                        ? constraints.maxWidth
                                        : constraints.maxHeight;
                                    return _buildColourSwatch(colourList, size);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _buildCompleteButton(colourTaskData, height, width),
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Rotate to Portrait"),
            content:  Text(
                "This task is very difficult to complete on a mobile phone in lanscape mode, please rotate to portrait mode before attempting the task."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
               RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(DesignTheme.defaultRadiusVal),
                ),
                color: DesignTheme.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(DesignTheme.smallPadding),
                  child: FittedBox(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildColourBox(int index, double size) {
    return Container(
      color: (colourList.length >= index + 1) ? colourList[index] : Colors.grey,
      height: size,
      width: size,
      child: (colourList.length <= index)
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                color: Colors.grey,
              ),
              child: Center(
                child: Text(
                  "DONE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          : (widget.cvdType == CvdType.normal)
              ? Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
              )
              : Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: widget.technique(
                    context,
                    size,
                    colourList[index],
                  ),
                ),
    );
  }

  Widget _buildColourSwatch(List<Color> colourList, double size) {
    return (colourList.length <= 0)
        ? _buildColourBox(0, size)
        : Draggable(
            data: "SORT",
            child: _buildColourBox(0, size),
            feedback: _buildColourBox(0, size),
            childWhenDragging: _buildColourBox(1, size),
          );
  }

  void saveStudyData(var colourTaskData, var height, var width) {
    myStopWatch.stop();
    endTime = DateTime.now().millisecondsSinceEpoch;
    int totalCorrectScore = 0;
    int totalIncorrectScore = 0;
    Map<String, List<String>> correctColours = {
      'red': [],
      'orange': [],
      'yellow': [],
      'green': [],
      'teal': [],
      'blue': [],
      'purple': [],
      'pink': [],
      'grey': [],
      'brown': [],
    };
    List<Map<String, String>> incorrectColours = [];
    //List<String> colours = [];

    colourNameLists.forEach((colourName, colourList) {
      int i = 0;
      colourList.forEach((colour) {
        //String name = ColourNamer(colour).getName();
        String name = answerColourSort[colour];
        if (name == colourName) {
          totalCorrectScore++;

          correctColours[colourName].add(colourList[i].toString());
        } else {
          totalIncorrectScore++;
          incorrectColours.add({
            'Colour Code': colourList[i].toString(),
            'Guessed Colour Name': colourName,
            'Actual Colour Name': name,
          });
        }
        i++;
      });
    });

    String patternTechnique = "None";
    if (widget.patternMethod == 0) {
      patternTechnique = "None";
    } else if (widget.patternMethod == 1) {
      patternTechnique = "ColourMix";
    } else if (widget.patternMethod == 2) {
      patternTechnique = "ColourIconizer";
    } else if (widget.patternMethod == 3) {
      patternTechnique = "ColourMeters";
    }

    colourTaskData.addResultsColSortTask(ColourSortTaskModel(
      accuracy: totalCorrectScore / (totalIncorrectScore + totalCorrectScore),
      completionTime: myStopWatch.elapsed,
      numCorrect: totalCorrectScore,
      numIncorrect: totalIncorrectScore,
      technique: patternTechnique,
      size: "Large", //TODO: CHnage this later.
      correctColours: correctColours.toString().replaceAll(",", ";"),
      incorrectColours: incorrectColours.toString().replaceAll(",", ";"),
      colours: begColourList.toString().replaceAll(",", ";"),
      endTime: endTime,
      startTime: startTime,
      screenHeight: height,
      screenWidth: width,
      //colourSet: widget.
    ));
  }

  Widget _buildCompleteButton(var colourTaskData, var height, var width) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTheme.defaultRadiusVal),
      ),
      color: (colourList.length == 0) ? DesignTheme.primaryColor : Colors.grey,
      onPressed: (colourList.length == 0)
          ? () {
              saveStudyData(colourTaskData, height, width);
              widget.onNext();
            }
          : () {},
      child: Padding(
        padding: EdgeInsets.all(DesignTheme.mediumPadding),
        child: FittedBox(
          child: Text(
            'Continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: DesignTheme.titleFontSize,
            ),
          ),
        ),
      ),
    );
  }

  void addColourSwatch(String colourName) {
    colourNameLists[colourName].add(colourList.removeAt(0));
    setState(() {});
  }

  Widget _buildColourTargets(String colourName, double size) {
    return DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            color: Colors.grey,
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                colourName,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
      onWillAccept: (data) {
        if(data == 'SORT') {
          return true;
        } else {
          return false;
        }
      } ,
      onAccept: (str) {
        if(str == 'SORT') {
          return addColourSwatch(colourName);
        } 
      } 
    );
  }
}
