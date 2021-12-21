import 'package:flutter/foundation.dart';

class PreStudyQuestionnaireData {
  bool alreadyParticipated;
  String cvdType;
  int ageGroup;
  int deviceCode;
  bool usingMouse;
  String environment;
  String lighting;
  int brightness;
  bool recoloring;
  String nativeLanguage;
  String otherStr;

  PreStudyQuestionnaireData({
    @required this.alreadyParticipated,
    @required this.cvdType,
    @required this.ageGroup,
    @required this.deviceCode,
    @required this.usingMouse,
    @required this.environment,
    @required this.lighting,
    @required this.brightness,
    @required this.recoloring,
    @required this.nativeLanguage,
    @required this.otherStr,
  });
}
