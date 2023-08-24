import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/collect_photo_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class Chatapge2Model extends FlutterFlowModel {
  ///  Local state fields for this page.

  bool showImage = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Row widget.
  ScrollController? rowController1;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // State field(s) for fullName widget.
  TextEditingController? fullNameController;
  String? Function(BuildContext, String?)? fullNameControllerValidator;
  // State field(s) for Row widget.
  ScrollController? rowController2;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  ChatMessagesRecord? createUserMessage;
  // Stores action output result for [Backend Call - API (clova)] action in IconButton widget.
  ApiCallResponse? apiResult94f;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  ChatMessagesRecord? createAIMessage;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    rowController1 = ScrollController();
    columnController = ScrollController();
    listViewController = ScrollController();
    rowController2 = ScrollController();
  }

  void dispose() {
    unfocusNode.dispose();
    rowController1?.dispose();
    columnController?.dispose();
    listViewController?.dispose();
    fullNameController?.dispose();
    rowController2?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
