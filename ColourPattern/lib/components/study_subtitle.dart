import 'package:flutter/material.dart';
import 'package:observationStudyScaffold/theme/design_theme.dart';

/// Used for titles and subtitles throughout the
/// application
class StudySubTitle extends StatelessWidget {
  final String title;
  StudySubTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.left,
    );
  }
}
