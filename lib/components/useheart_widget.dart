import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'useheart_model.dart';
export 'useheart_model.dart';

class UseheartWidget extends StatefulWidget {
  const UseheartWidget({
    Key? key,
    required this.heartCount,
  }) : super(key: key);

  final int? heartCount;

  @override
  _UseheartWidgetState createState() => _UseheartWidgetState();
}

class _UseheartWidgetState extends State<UseheartWidget> {
  late UseheartModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UseheartModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: 200.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(0.0, -3.0),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '하트 💖${widget.heartCount?.toString()}개를 사용합니다',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'NIXGON',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 32.0,
                    useGoogleFonts: false,
                  ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('USEHEART_COMP_확인_BTN_ON_TAP');
                  if (valueOrDefault(currentUserDocument?.heart, 0) >=
                      widget.heartCount!) {
                    logFirebaseEvent('Button_backend_call');

                    await currentUserReference!.update({
                      'heart': FieldValue.increment(-(widget.heartCount!)),
                    });
                    // success
                    logFirebaseEvent('Button_success');
                    Navigator.pop(context, true);
                  } else {
                    logFirebaseEvent('Button_show_snack_bar');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '하트가 부족해요. 하트를 충전해주세요',
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        duration: Duration(milliseconds: 4000),
                        backgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        action: SnackBarAction(
                          label: '하트 충전',
                          textColor: FlutterFlowTheme.of(context).primary,
                          onPressed: () async {
                            context.pushNamed('setting');
                          },
                        ),
                      ),
                    );
                    // fail
                    logFirebaseEvent('Button_fail');
                    Navigator.pop(context, false);
                  }
                },
                text: '확인',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: TextStyle(
                    fontFamily: 'NIXGON',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                  ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
