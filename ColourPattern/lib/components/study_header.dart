import 'package:flutter/material.dart';
import 'package:observationStudyScaffold/theme/design_theme.dart';

class StudyHeader extends StatelessWidget {
  final String header;

  StudyHeader({
    @required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: DesignTheme.mediumPadding),
      child: Text(
          header,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
    );
  }
}
