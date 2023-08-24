import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/match_success_widget.dart';
import '/components/no_more_card_widget.dart';
import '/components/useheart_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'all_characters_model.dart';
export 'all_characters_model.dart';

class AllCharactersWidget extends StatefulWidget {
  const AllCharactersWidget({Key? key}) : super(key: key);

  @override
  _AllCharactersWidgetState createState() => _AllCharactersWidgetState();
}

class _AllCharactersWidgetState extends State<AllCharactersWidget> {
  late AllCharactersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllCharactersModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'AllCharacters'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('ALL_CHARACTERS_AllCharacters_ON_INIT_STA');
      if (dateTimeFormat(
            'yMd',
            currentUserDocument?.updatedDate,
            locale: FFLocalizations.of(context).languageCode,
          ) !=
          dateTimeFormat(
            'yMd',
            getCurrentTimestamp,
            locale: FFLocalizations.of(context).languageCode,
          )) {
        logFirebaseEvent('AllCharacters_backend_call');

        await currentUserReference!.update({
          ...createUsersRecordData(
            updatedDate: getCurrentTimestamp,
            dailyCharacterMet: 0,
          ),
          'characterMet': FieldValue.increment(3),
        });
      }
    });

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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: AuthUserStreamWidget(
            builder: (context) => Text(
              'DailyMatch  (💖:${valueOrDefault(currentUserDocument?.heart, 0).toString()})',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'NIXGON',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 24.0,
                    useGoogleFonts: false,
                  ),
            ),
          ),
          actions: [
            Visibility(
              visible: responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 0.0, 5.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => Text(
                        dateTimeFormat(
                          'yMd',
                          currentUserDocument!.updatedDate!,
                          locale: FFLocalizations.of(context).languageCode,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'NIXGON',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 22.0,
                              useGoogleFonts: false,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 5.0),
                    child: Text(
                      '오늘의 매치',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'NIXGON',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 22.0,
                            useGoogleFonts: false,
                          ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
                child: AuthUserStreamWidget(
                  builder: (context) => StreamBuilder<List<CharacterRecord>>(
                    stream: queryCharacterRecord(
                      queryBuilder: (characterRecord) => characterRecord
                          .where('order',
                              isLessThanOrEqualTo: valueOrDefault(
                                  currentUserDocument?.characterMet, 0))
                          .where('order',
                              isGreaterThan: valueOrDefault(
                                      currentUserDocument?.characterMet, 0) -
                                  3)
                          .orderBy('order'),
                    ),
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
                      List<CharacterRecord> gridViewCharacterRecordList =
                          snapshot.data!;
                      if (gridViewCharacterRecordList.isEmpty) {
                        return Center(
                          child: NoMoreCardWidget(),
                        );
                      }
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 2.0,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: gridViewCharacterRecordList.length,
                        itemBuilder: (context, gridViewIndex) {
                          final gridViewCharacterRecord =
                              gridViewCharacterRecordList[gridViewIndex];
                          return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                  tablet: false,
                                  tabletLandscape: false,
                                  desktop: false,
                                ))
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.32,
                                          height: 10.0,
                                          decoration: BoxDecoration(
                                            color: _model.profileNumber == 1
                                                ? Color(0xFF28E7AB)
                                                : Color(0xFFD4D4D4),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.32,
                                          height: 10.0,
                                          decoration: BoxDecoration(
                                            color: _model.profileNumber == 2
                                                ? Color(0xFF28E7AB)
                                                : Color(0xFFD4D4D4),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.32,
                                          height: 10.0,
                                          decoration: BoxDecoration(
                                            color: _model.profileNumber == 3
                                                ? Color(0xFF28E7AB)
                                                : Color(0xFFD4D4D4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Stack(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'ALL_CHARACTERS_Column_azo972b9_ON_TAP');
                                              logFirebaseEvent(
                                                  'Column_update_widget_state');
                                              setState(() {
                                                _model.profileNumber =
                                                    _model.profileNumber == 3
                                                        ? 2
                                                        : 1;
                                              });
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'ALL_CHARACTERS_Container_9w6t33dh_ON_TAP');
                                                    logFirebaseEvent(
                                                        'Container_update_widget_state');
                                                    setState(() {
                                                      _model.profileNumber =
                                                          _model.profileNumber ==
                                                                  3
                                                              ? 2
                                                              : 1;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.6,
                                                    decoration: BoxDecoration(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'ALL_CHARACTERS_Column_7pexqk8w_ON_TAP');
                                              logFirebaseEvent(
                                                  'Column_update_widget_state');
                                              setState(() {
                                                _model.profileNumber =
                                                    _model.profileNumber == 1
                                                        ? 2
                                                        : 3;
                                              });
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    logFirebaseEvent(
                                                        'ALL_CHARACTERS_Container_tmfbpkb1_ON_TAP');
                                                    logFirebaseEvent(
                                                        'Container_update_widget_state');
                                                    setState(() {
                                                      _model.profileNumber =
                                                          _model.profileNumber ==
                                                                  1
                                                              ? 2
                                                              : 3;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.6,
                                                    decoration: BoxDecoration(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topLeft: Radius.circular(0.0),
                                            topRight: Radius.circular(0.0),
                                          ),
                                          child: Image.network(
                                            gridViewCharacterRecord
                                                .profileImage,
                                            width: double.infinity,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.6,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 25.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                if ((currentUserDocument
                                                            ?.matchedCharacter
                                                            ?.toList() ??
                                                        [])
                                                    .contains(
                                                        gridViewCharacterRecord
                                                            .reference))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 20.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text: '매칭 완료',
                                                      options: FFButtonOptions(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    36.0,
                                                                    24.0,
                                                                    36.0,
                                                                    24.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        textStyle: TextStyle(
                                                          fontFamily: 'NIXGON',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 32.0,
                                                        ),
                                                        elevation: 3.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20.0, 0.0, 0.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        gridViewCharacterRecord
                                                            .name,
                                                        style: TextStyle(
                                                          fontFamily: 'NIXGON',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 36.0,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          gridViewCharacterRecord
                                                              .age
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'NIXGON',
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 32.0,
                                                          ),
                                                        ),
                                                      ),
                                                      if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.dailyCharacterMet,
                                                              0) !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            '💖10개',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'NIXGON',
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 26.0,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20.0, 0.0, 20.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Wrap(
                                                        spacing: 0.0,
                                                        runSpacing: 0.0,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                        direction:
                                                            Axis.horizontal,
                                                        runAlignment:
                                                            WrapAlignment.start,
                                                        verticalDirection:
                                                            VerticalDirection
                                                                .down,
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth: 300.0,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              gridViewCharacterRecord
                                                                  .sangtaeMessage,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (!(currentUserDocument?.matchedCharacter
                                            ?.toList() ??
                                        [])
                                    .contains(
                                        gridViewCharacterRecord.reference))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: Color(0xFFFF2E54),
                                            borderRadius: 100.0,
                                            borderWidth: 4.0,
                                            buttonSize: 70.0,
                                            icon: Icon(
                                              Icons.close_rounded,
                                              color: Color(0xFFFF2E54),
                                              size: 50.0,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  40.0, 0.0, 0.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: Color(0xFF28E7AB),
                                            borderRadius: 100.0,
                                            borderWidth: 4.0,
                                            buttonSize: 70.0,
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Color(0xFF28E7AB),
                                              size: 50.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'ALL_CHARACTERS_PAGE_favorite_ICN_ON_TAP');
                                              var _shouldSetState = false;
                                              if (valueOrDefault(
                                                      currentUserDocument
                                                          ?.dailyCharacterMet,
                                                      0) !=
                                                  0) {
                                                logFirebaseEvent(
                                                    'IconButton_bottom_sheet');
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () => FocusScope
                                                              .of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: UseheartWidget(
                                                          heartCount: 10,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) => setState(() =>
                                                    _model.useHeartBoolean =
                                                        value));

                                                _shouldSetState = true;
                                                if (!_model.useHeartBoolean!) {
                                                  if (_shouldSetState)
                                                    setState(() {});
                                                  return;
                                                }
                                              }
                                              logFirebaseEvent(
                                                  'IconButton_bottom_sheet');
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                enableDrag: false,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () => FocusScope.of(
                                                            context)
                                                        .requestFocus(
                                                            _model.unfocusNode),
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child: MatchSuccessWidget(
                                                        character:
                                                            gridViewCharacterRecord,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then(
                                                  (value) => setState(() {}));

                                              // updateMatchedUser
                                              logFirebaseEvent(
                                                  'IconButton_updateMatchedUser');

                                              await currentUserReference!
                                                  .update({
                                                'matchedCharacter':
                                                    FieldValue.arrayUnion([
                                                  gridViewCharacterRecord
                                                      .reference
                                                ]),
                                                'dailyCharacterMet':
                                                    FieldValue.increment(1),
                                              });
                                              // createMatch
                                              logFirebaseEvent(
                                                  'IconButton_createMatch');

                                              await MatchRecord.collection
                                                  .doc()
                                                  .set({
                                                ...createMatchRecordData(
                                                  character:
                                                      gridViewCharacterRecord
                                                          .reference,
                                                  user: currentUserReference,
                                                  isMatch: true,
                                                ),
                                                'updatedDate': FieldValue
                                                    .serverTimestamp(),
                                              });
                                              // createChat
                                              logFirebaseEvent(
                                                  'IconButton_createChat');

                                              var chatsRecordReference =
                                                  ChatsRecord.collection.doc();
                                              await chatsRecordReference.set({
                                                ...createChatsRecordData(
                                                  userA: currentUserReference,
                                                  character:
                                                      gridViewCharacterRecord
                                                          .reference,
                                                  lastMessage:
                                                      gridViewCharacterRecord
                                                          .introMessage2,
                                                  loveNumber: 0.1,
                                                  prompt:
                                                      '${gridViewCharacterRecord.description}${gridViewCharacterRecord.introMessage1}\\n남사친 : ${gridViewCharacterRecord.introMessage2}',
                                                  userMessageCount: 0,
                                                  imageCount: 1,
                                                ),
                                                'last_message_time': FieldValue
                                                    .serverTimestamp(),
                                              });
                                              _model.chatMadeIcon = ChatsRecord
                                                  .getDocumentFromData({
                                                ...createChatsRecordData(
                                                  userA: currentUserReference,
                                                  character:
                                                      gridViewCharacterRecord
                                                          .reference,
                                                  lastMessage:
                                                      gridViewCharacterRecord
                                                          .introMessage2,
                                                  loveNumber: 0.1,
                                                  prompt:
                                                      '${gridViewCharacterRecord.description}${gridViewCharacterRecord.introMessage1}\\n남사친 : ${gridViewCharacterRecord.introMessage2}',
                                                  userMessageCount: 0,
                                                  imageCount: 1,
                                                ),
                                                'last_message_time':
                                                    DateTime.now(),
                                              }, chatsRecordReference);
                                              _shouldSetState = true;
                                              // createMessage1
                                              logFirebaseEvent(
                                                  'IconButton_createMessage1');

                                              var chatMessagesRecordReference1 =
                                                  ChatMessagesRecord.collection
                                                      .doc();
                                              await chatMessagesRecordReference1
                                                  .set({
                                                ...createChatMessagesRecordData(
                                                  user: currentUserReference,
                                                  chat: _model
                                                      .chatMadeIcon?.reference,
                                                  text: gridViewCharacterRecord
                                                      .introMessage1,
                                                  ai: true,
                                                  nextPrompt: '',
                                                ),
                                                'timestamp': FieldValue
                                                    .serverTimestamp(),
                                              });
                                              _model.createMessage1Icon =
                                                  ChatMessagesRecord
                                                      .getDocumentFromData({
                                                ...createChatMessagesRecordData(
                                                  user: currentUserReference,
                                                  chat: _model
                                                      .chatMadeIcon?.reference,
                                                  text: gridViewCharacterRecord
                                                      .introMessage1,
                                                  ai: true,
                                                  nextPrompt: '',
                                                ),
                                                'timestamp': DateTime.now(),
                                              }, chatMessagesRecordReference1);
                                              _shouldSetState = true;
                                              // createMessage2
                                              logFirebaseEvent(
                                                  'IconButton_createMessage2');

                                              var chatMessagesRecordReference2 =
                                                  ChatMessagesRecord.collection
                                                      .doc();
                                              await chatMessagesRecordReference2
                                                  .set({
                                                ...createChatMessagesRecordData(
                                                  user: currentUserReference,
                                                  chat: _model
                                                      .chatMadeIcon?.reference,
                                                  text: gridViewCharacterRecord
                                                      .introMessage2,
                                                  ai: true,
                                                  nextPrompt:
                                                      '${gridViewCharacterRecord.description}${gridViewCharacterRecord.introMessage1}\\n남사친 : ${gridViewCharacterRecord.introMessage2}',
                                                  image: gridViewCharacterRecord
                                                      .profileImage,
                                                  imageNumber: 1,
                                                ),
                                                'timestamp': FieldValue
                                                    .serverTimestamp(),
                                              });
                                              _model.createMessage2Icon =
                                                  ChatMessagesRecord
                                                      .getDocumentFromData({
                                                ...createChatMessagesRecordData(
                                                  user: currentUserReference,
                                                  chat: _model
                                                      .chatMadeIcon?.reference,
                                                  text: gridViewCharacterRecord
                                                      .introMessage2,
                                                  ai: true,
                                                  nextPrompt:
                                                      '${gridViewCharacterRecord.description}${gridViewCharacterRecord.introMessage1}\\n남사친 : ${gridViewCharacterRecord.introMessage2}',
                                                  image: gridViewCharacterRecord
                                                      .profileImage,
                                                  imageNumber: 1,
                                                ),
                                                'timestamp': DateTime.now(),
                                              }, chatMessagesRecordReference2);
                                              _shouldSetState = true;
                                              logFirebaseEvent(
                                                  'IconButton_show_snack_bar');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '매치 성공! 채팅을 시작하세요',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 5000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                  action: SnackBarAction(
                                                    label: '채팅',
                                                    textColor: Colors.white,
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                        'chatapge2',
                                                        queryParameters: {
                                                          'character':
                                                              serializeParam(
                                                            gridViewCharacterRecord
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'chat':
                                                              serializeParam(
                                                            _model.chatMadeIcon,
                                                            ParamType.Document,
                                                          ),
                                                          'characterProfile':
                                                              serializeParam(
                                                            gridViewCharacterRecord
                                                                .profileImage,
                                                            ParamType.String,
                                                          ),
                                                          'characterName':
                                                              serializeParam(
                                                            gridViewCharacterRecord
                                                                .name,
                                                            ParamType.String,
                                                          ),
                                                          'prompt':
                                                              serializeParam(
                                                            _model.chatMadeIcon
                                                                ?.prompt,
                                                            ParamType.String,
                                                          ),
                                                          'chatReference':
                                                              serializeParam(
                                                            _model.chatMadeIcon
                                                                ?.reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          'chat': _model
                                                              .chatMadeIcon,
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                              // push_1message
                                              logFirebaseEvent(
                                                  'IconButton_push_1message');
                                              triggerPushNotification(
                                                notificationTitle: '남사친',
                                                notificationText: _model
                                                    .createMessage1Icon!.text,
                                                userRefs: [
                                                  currentUserReference!
                                                ],
                                                initialPageName: 'chatapge2',
                                                parameterData: {
                                                  'character':
                                                      gridViewCharacterRecord
                                                          .reference,
                                                  'chatReference': _model
                                                      .chatMadeIcon?.reference,
                                                  'characterProfile':
                                                      gridViewCharacterRecord
                                                          .profileImage,
                                                  'prompt': _model
                                                      .chatMadeIcon?.prompt,
                                                  'chat': _model.chatMadeIcon,
                                                  'characterName':
                                                      gridViewCharacterRecord
                                                          .name,
                                                },
                                              );
                                              logFirebaseEvent(
                                                  'IconButton_wait__delay');
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 2000));
                                              // push_2message
                                              logFirebaseEvent(
                                                  'IconButton_push_2message');
                                              triggerPushNotification(
                                                notificationTitle: '남사친',
                                                notificationText: _model
                                                    .createMessage2Icon!.text,
                                                userRefs: [
                                                  currentUserReference!
                                                ],
                                                initialPageName: 'chatapge2',
                                                parameterData: {
                                                  'character':
                                                      gridViewCharacterRecord
                                                          .reference,
                                                  'chatReference': _model
                                                      .chatMadeIcon?.reference,
                                                  'characterProfile':
                                                      gridViewCharacterRecord
                                                          .profileImage,
                                                  'prompt': _model
                                                      .chatMadeIcon?.prompt,
                                                  'chat': _model.chatMadeIcon,
                                                  'characterName':
                                                      gridViewCharacterRecord
                                                          .name,
                                                },
                                              );
                                              if (_shouldSetState)
                                                setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Text(
                                  valueOrDefault(
                                          currentUserDocument?.characterMet, 0)
                                      .toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
