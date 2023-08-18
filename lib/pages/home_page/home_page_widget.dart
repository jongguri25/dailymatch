import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'HomePage'});
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: StreamBuilder<List<CharacterRecord>>(
                  stream: queryCharacterRecord(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<CharacterRecord> swipeableStackCharacterRecordList =
                        snapshot.data!;
                    return FlutterFlowSwipeableStack(
                      topCardHeightFraction: 0.72,
                      middleCardHeightFraction: 0.68,
                      bottomCardHeightFraction: 0.75,
                      topCardWidthFraction: 0.9,
                      middleCardWidthFraction: 0.85,
                      bottomCardWidthFraction: 0.8,
                      onSwipeFn: (index) {},
                      onLeftSwipe: (index) async {
                        logFirebaseEvent(
                            'HOME_SwipeableStack_3f2278uc_ON_LEFT_SWI');
                        final swipeableStackCharacterRecord =
                            swipeableStackCharacterRecordList[index];
                        logFirebaseEvent('SwipeableStack_backend_call');

                        await MatchRecord.collection.doc().set({
                          ...createMatchRecordData(
                            character: swipeableStackCharacterRecordList[index]
                                ?.reference,
                            user: currentUserReference,
                            isMatch: false,
                          ),
                          'updatedDate': FieldValue.serverTimestamp(),
                        });
                      },
                      onRightSwipe: (index) async {
                        logFirebaseEvent(
                            'HOME_SwipeableStack_3f2278uc_ON_RIGHT_SW');
                        final swipeableStackCharacterRecord =
                            swipeableStackCharacterRecordList[index];
                        logFirebaseEvent('SwipeableStack_backend_call');

                        await MatchRecord.collection.doc().set({
                          ...createMatchRecordData(
                            character: swipeableStackCharacterRecordList[index]
                                ?.reference,
                            user: currentUserReference,
                            isMatch: true,
                          ),
                          'updatedDate': FieldValue.serverTimestamp(),
                        });
                      },
                      onUpSwipe: (index) {},
                      onDownSwipe: (index) {},
                      itemBuilder: (context, swipeableStackIndex) {
                        final swipeableStackCharacterRecord =
                            swipeableStackCharacterRecordList[
                                swipeableStackIndex];
                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      swipeableStackCharacterRecord
                                          .profileImage,
                                      width: double.infinity,
                                      height: 500.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 0.0, 20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          swipeableStackCharacterRecord.name,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'NIXGON',
                                                color: Colors.white,
                                                fontSize: 32.0,
                                                fontWeight: FontWeight.bold,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderColor: Color(0xFFFF2E54),
                                      borderRadius: 100.0,
                                      borderWidth: 1.0,
                                      buttonSize: 60.0,
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: Color(0xFFFF2E54),
                                        size: 40.0,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          40.0, 0.0, 0.0, 0.0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Color(0xFF28E7AB),
                                        borderRadius: 100.0,
                                        borderWidth: 1.0,
                                        buttonSize: 60.0,
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Color(0xFF28E7AB),
                                          size: 40.0,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
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
                      itemCount: swipeableStackCharacterRecordList.length,
                      controller: _model.swipeableStackController,
                      enableSwipeUp: false,
                      enableSwipeDown: false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
