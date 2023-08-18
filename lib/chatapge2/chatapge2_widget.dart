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
import 'chatapge2_model.dart';
export 'chatapge2_model.dart';

class Chatapge2Widget extends StatefulWidget {
  const Chatapge2Widget({
    Key? key,
    required this.character,
    required this.chatReference,
    required this.characterProfile,
    required this.characterName,
    required this.prompt,
    required this.chat,
  }) : super(key: key);

  final DocumentReference? character;
  final DocumentReference? chatReference;
  final String? characterProfile;
  final String? characterName;
  final String? prompt;
  final ChatsRecord? chat;

  @override
  _Chatapge2WidgetState createState() => _Chatapge2WidgetState();
}

class _Chatapge2WidgetState extends State<Chatapge2Widget>
    with TickerProviderStateMixin {
  late Chatapge2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'textOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ShakeEffect(
          curve: Curves.easeIn,
          delay: 0.ms,
          duration: 1000.ms,
          hz: 10,
          offset: Offset(0.0, 0.0),
          rotation: 0.087,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Chatapge2Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'chatapge2'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CHATAPGE2_PAGE_chatapge2_ON_INIT_STATE');
      logFirebaseEvent('chatapge2_scroll_to');
      await _model.listViewController?.animateTo(
        _model.listViewController!.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.ease,
      );
      logFirebaseEvent('chatapge2_scroll_to');
      await _model.columnController?.animateTo(
        _model.columnController!.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.ease,
      );
      if (widget.chat?.userMessageCount == 0) {
        logFirebaseEvent('chatapge2_bottom_sheet');
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () =>
                  FocusScope.of(context).requestFocus(_model.unfocusNode),
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: CollectPhotoWidget(
                  characterImage: widget.characterProfile!,
                ),
              ),
            );
          },
        ).then((value) => setState(() {}));
      }
    });

    _model.fullNameController ??= TextEditingController();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
    final lottieAnimationController = AnimationController(vsync: this);
    return FutureBuilder<ChatsRecord>(
      future: ChatsRecord.getDocumentOnce(widget.chatReference!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final chatapge2ChatsRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFABC0D1),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Lottie.network(
                        'https://lottie.host/1fe9dc8b-ffc6-4623-97bc-0ac46ebdb7b8/FFKuouyTVc.json',
                        width: 300.0,
                        height: 500.0,
                        fit: BoxFit.cover,
                        controller: lottieAnimationController,
                        onLoaded: (composition) => lottieAnimationController
                            .duration = composition.duration,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 60.0,
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Color(0xFF101417),
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'CHATAPGE2_arrow_back_rounded_ICN_ON_TAP');
                                    logFirebaseEvent('IconButton_navigate_to');

                                    context.pushNamed('AllChatsPage');
                                  },
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          widget.characterName!,
                                          style: TextStyle(
                                            color: Color(0xFF101417),
                                            fontSize: 22.0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            '호감도',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 26.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            formatNumber(
                                              chatapge2ChatsRecord.loveNumber,
                                              formatType: FormatType.percent,
                                            ),
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 26.0,
                                            ),
                                          ).animateOnActionTrigger(
                                            animationsMap[
                                                'textOnActionTriggerAnimation']!,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 4.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Stack(
                                            children: [
                                              LinearPercentIndicator(
                                                percent: chatapge2ChatsRecord
                                                    .loveNumber,
                                                width: 300.0,
                                                lineHeight: 18.0,
                                                animation: true,
                                                progressColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                backgroundColor:
                                                    Color(0xFFE9E9E9),
                                                barRadius:
                                                    Radius.circular(10.0),
                                                padding: EdgeInsets.zero,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/Frame_108.png',
                                                  width: 300.0,
                                                  height: 18.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 0.0, 10.0),
                              child: StreamBuilder<List<CharacterImageRecord>>(
                                stream: queryCharacterImageRecord(
                                  parent: widget.character,
                                  queryBuilder: (characterImageRecord) =>
                                      characterImageRecord
                                          .orderBy('imageCount'),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<CharacterImageRecord>
                                      rowCharacterImageRecordList =
                                      snapshot.data!;
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller: _model.rowController1,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                          rowCharacterImageRecordList.length,
                                          (rowIndex) {
                                        final rowCharacterImageRecord =
                                            rowCharacterImageRecordList[
                                                rowIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 10.0, 0.0),
                                          child: Container(
                                            width: 60.0,
                                            height: 90.0,
                                            child: Stack(
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
                                                        'CHATAPGE2_PAGE_Image_ishqvp5e_ON_TAP');
                                                    logFirebaseEvent(
                                                        'Image_expand_image');
                                                    await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child:
                                                            FlutterFlowExpandedImageView(
                                                          image: Image.network(
                                                            rowCharacterImageRecord
                                                                        .imageCount <=
                                                                    (chatapge2ChatsRecord
                                                                            .loveNumber *
                                                                        10)
                                                                ? rowCharacterImageRecord
                                                                    .chatImage
                                                                : 'https://i.ibb.co/r7Bct8L/Frame-21.png',
                                                            fit: BoxFit.contain,
                                                          ),
                                                          allowRotation: false,
                                                          tag: rowCharacterImageRecord
                                                                      .imageCount <=
                                                                  (chatapge2ChatsRecord
                                                                          .loveNumber *
                                                                      10)
                                                              ? rowCharacterImageRecord
                                                                  .chatImage
                                                              : 'https://i.ibb.co/r7Bct8L/Frame-21.png',
                                                          useHeroAnimation:
                                                              true,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Hero(
                                                    tag: rowCharacterImageRecord
                                                                .imageCount <=
                                                            (chatapge2ChatsRecord
                                                                    .loveNumber *
                                                                10)
                                                        ? rowCharacterImageRecord
                                                            .chatImage
                                                        : 'https://i.ibb.co/r7Bct8L/Frame-21.png',
                                                    transitionOnUserGestures:
                                                        true,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        rowCharacterImageRecord
                                                                    .imageCount <=
                                                                (chatapge2ChatsRecord
                                                                        .loveNumber *
                                                                    10)
                                                            ? rowCharacterImageRecord
                                                                .chatImage
                                                            : 'https://i.ibb.co/r7Bct8L/Frame-21.png',
                                                        width: 60.0,
                                                        height: 90.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    4.0,
                                                                    4.0,
                                                                    4.0,
                                                                    4.0),
                                                        child: Text(
                                                          rowCharacterImageRecord
                                                              .type,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'NIXGON',
                                                            color: Color(
                                                                0xFFEB0021),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, 1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    4.0,
                                                                    4.0,
                                                                    4.0,
                                                                    4.0),
                                                        child: Text(
                                                          '${rowCharacterImageRecord.imageCount.toString()}/10',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 40.0)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: _model.columnController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 10.0),
                                        child: StreamBuilder<
                                            List<ChatMessagesRecord>>(
                                          stream: queryChatMessagesRecord(
                                            queryBuilder:
                                                (chatMessagesRecord) =>
                                                    chatMessagesRecord
                                                        .where('chat',
                                                            isEqualTo: widget
                                                                .chatReference)
                                                        .orderBy('timestamp'),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<ChatMessagesRecord>
                                                listViewChatMessagesRecordList =
                                                snapshot.data!;
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  listViewChatMessagesRecordList
                                                      .length,
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewChatMessagesRecord =
                                                    listViewChatMessagesRecordList[
                                                        listViewIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (listViewChatMessagesRecord
                                                            .ai ==
                                                        true)
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                logFirebaseEvent(
                                                                    'CHATAPGE2_CircleImage_f2kw56yi_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'CircleImage_expand_image');
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .fade,
                                                                    child:
                                                                        FlutterFlowExpandedImageView(
                                                                      image: Image
                                                                          .network(
                                                                        widget
                                                                            .characterProfile!,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      allowRotation:
                                                                          false,
                                                                      tag: widget
                                                                          .characterProfile!,
                                                                      useHeroAnimation:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Hero(
                                                                tag: widget
                                                                    .characterProfile!,
                                                                transitionOnUserGestures:
                                                                    true,
                                                                child:
                                                                    Container(
                                                                  width: 45.0,
                                                                  height: 45.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .characterProfile!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    widget
                                                                        .characterName!,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'NIXGON',
                                                                          color:
                                                                              Color(0xFF637380),
                                                                          useGoogleFonts:
                                                                              false,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(24.0),
                                                                            bottomRight:
                                                                                Radius.circular(24.0),
                                                                            topLeft:
                                                                                Radius.circular(3.0),
                                                                            topRight:
                                                                                Radius.circular(24.0),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              12.0,
                                                                              16.0,
                                                                              12.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Wrap(
                                                                                    spacing: 0.0,
                                                                                    runSpacing: 0.0,
                                                                                    alignment: WrapAlignment.start,
                                                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                                                    direction: Axis.horizontal,
                                                                                    runAlignment: WrapAlignment.start,
                                                                                    verticalDirection: VerticalDirection.down,
                                                                                    clipBehavior: Clip.none,
                                                                                    children: [
                                                                                      Container(
                                                                                        constraints: BoxConstraints(
                                                                                          maxWidth: 200.0,
                                                                                          maxHeight: double.infinity,
                                                                                        ),
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        ),
                                                                                        child: Text(
                                                                                          listViewChatMessagesRecord.text,
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'NIXGON',
                                                                                            color: Color(0xFF202020),
                                                                                            fontWeight: FontWeight.w500,
                                                                                            height: 1.2,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        dateTimeFormat(
                                                                          'relative',
                                                                          listViewChatMessagesRecord
                                                                              .timestamp!,
                                                                          locale:
                                                                              FFLocalizations.of(context).languageCode,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'NIXGON',
                                                                              color: Color(0xFF687A88),
                                                                              fontSize: 10.0,
                                                                              useGoogleFonts: false,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (listViewChatMessagesRecord
                                                                        .imageNumber !=
                                                                    null)
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: StreamBuilder<
                                                                        List<
                                                                            CharacterImageRecord>>(
                                                                      stream:
                                                                          queryCharacterImageRecord(
                                                                        parent:
                                                                            widget.character,
                                                                        queryBuilder: (characterImageRecord) => characterImageRecord.where(
                                                                            'imageCount',
                                                                            isEqualTo:
                                                                                listViewChatMessagesRecord.imageNumber),
                                                                        singleRecord:
                                                                            true,
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        List<CharacterImageRecord>
                                                                            containerCharacterImageRecordList =
                                                                            snapshot.data!;
                                                                        // Return an empty Container when the item does not exist.
                                                                        if (snapshot
                                                                            .data!
                                                                            .isEmpty) {
                                                                          return Container();
                                                                        }
                                                                        final containerCharacterImageRecord = containerCharacterImageRecordList.isNotEmpty
                                                                            ? containerCharacterImageRecordList.first
                                                                            : null;
                                                                        return Container(
                                                                          width:
                                                                              215.0,
                                                                          height:
                                                                              150.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(24.0),
                                                                              bottomRight: Radius.circular(24.0),
                                                                              topLeft: Radius.circular(3.0),
                                                                              topRight: Radius.circular(24.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Visibility(
                                                                            visible:
                                                                                listViewChatMessagesRecord.imageNumber != null,
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                logFirebaseEvent('CHATAPGE2_PAGE_Image_fpsqglxs_ON_TAP');
                                                                                logFirebaseEvent('Image_expand_image');
                                                                                await Navigator.push(
                                                                                  context,
                                                                                  PageTransition(
                                                                                    type: PageTransitionType.fade,
                                                                                    child: FlutterFlowExpandedImageView(
                                                                                      image: Image.network(
                                                                                        containerCharacterImageRecord!.chatImage,
                                                                                        fit: BoxFit.contain,
                                                                                      ),
                                                                                      allowRotation: false,
                                                                                      tag: containerCharacterImageRecord!.chatImage,
                                                                                      useHeroAnimation: true,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Hero(
                                                                                tag: containerCharacterImageRecord!.chatImage,
                                                                                transitionOnUserGestures: true,
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    containerCharacterImageRecord!.chatImage,
                                                                                    width: 300.0,
                                                                                    height: 200.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    if (listViewChatMessagesRecord
                                                            .ai ==
                                                        false)
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      dateTimeFormat(
                                                                        'relative',
                                                                        listViewChatMessagesRecord
                                                                            .timestamp!,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'NIXGON',
                                                                            color:
                                                                                Color(0xFF687A88),
                                                                            fontSize:
                                                                                10.0,
                                                                            useGoogleFonts:
                                                                                false,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Wrap(
                                                                    spacing:
                                                                        0.0,
                                                                    runSpacing:
                                                                        0.0,
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        WrapCrossAlignment
                                                                            .start,
                                                                    direction: Axis
                                                                        .vertical,
                                                                    runAlignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    verticalDirection:
                                                                        VerticalDirection
                                                                            .down,
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          constraints:
                                                                              BoxConstraints(
                                                                            maxWidth:
                                                                                MediaQuery.sizeOf(context).width * 3.0,
                                                                            maxHeight:
                                                                                double.infinity,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFFFDE500),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(24.0),
                                                                              bottomRight: Radius.circular(24.0),
                                                                              topLeft: Radius.circular(24.0),
                                                                              topRight: Radius.circular(3.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16.0,
                                                                                12.0,
                                                                                16.0,
                                                                                12.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Wrap(
                                                                                      spacing: 0.0,
                                                                                      runSpacing: 0.0,
                                                                                      alignment: WrapAlignment.start,
                                                                                      crossAxisAlignment: WrapCrossAlignment.start,
                                                                                      direction: Axis.horizontal,
                                                                                      runAlignment: WrapAlignment.start,
                                                                                      verticalDirection: VerticalDirection.down,
                                                                                      clipBehavior: Clip.none,
                                                                                      children: [
                                                                                        Container(
                                                                                          constraints: BoxConstraints(
                                                                                            maxWidth: 200.0,
                                                                                            maxHeight: double.infinity,
                                                                                          ),
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Text(
                                                                                            listViewChatMessagesRecord.text,
                                                                                            textAlign: TextAlign.start,
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'NIXGON',
                                                                                              color: Color(0xFF202020),
                                                                                              height: 1.2,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
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
                                                  ],
                                                );
                                              },
                                              controller:
                                                  _model.listViewController,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  maxWidth: 570.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3.0,
                                      color: Color(0x33000000),
                                      offset: Offset(0.0, -1.0),
                                    )
                                  ],
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'CHATAPGE2_PAGE_Row_21zidakh_ON_TAP');
                                    logFirebaseEvent('Row_scroll_to');
                                    await _model.listViewController?.animateTo(
                                      _model.listViewController!.position
                                          .maxScrollExtent,
                                      duration: Duration(milliseconds: 1),
                                      curve: Curves.ease,
                                    );
                                    logFirebaseEvent('Row_scroll_to');
                                    await _model.columnController?.animateTo(
                                      _model.columnController!.position
                                          .maxScrollExtent,
                                      duration: Duration(milliseconds: 1),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 0.0, 8.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onLongPress: () async {
                                            logFirebaseEvent(
                                                'CHATAPGE2_PAGE_add_ICN_ON_LONG_PRESS');
                                            logFirebaseEvent(
                                                'IconButton_navigate_to');

                                            context.pushNamed(
                                              'photoUpload',
                                              queryParameters: {
                                                'character': serializeParam(
                                                  widget.character,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 8.0,
                                            borderWidth: 1.0,
                                            buttonSize: 44.0,
                                            icon: Icon(
                                              Icons.add,
                                              color: Color(0xFF57636C),
                                              size: 24.0,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 5.0, 8.0, 5.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.fullNameController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily: 'NIXGON',
                                                          color:
                                                              Color(0xFF57636C),
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: false,
                                                        ),
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF57636C),
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFFF8F8F8),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                filled: true,
                                                fillColor: Color(0xFFF8F8F8),
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(12.0, 8.0,
                                                            20.0, 8.0),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'NIXGON',
                                                        color:
                                                            Color(0xFF111417),
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: false,
                                                      ),
                                              maxLines: 5,
                                              minLines: 1,
                                              validator: _model
                                                  .fullNameControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        controller: _model.rowController2,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 8.0, 8.0, 8.0),
                                                child: FlutterFlowIconButton(
                                                  borderColor:
                                                      Color(0xFFFFE302),
                                                  borderRadius: 30.0,
                                                  borderWidth: 3.0,
                                                  buttonSize: 45.0,
                                                  fillColor: Color(0xFFFFE302),
                                                  icon: Icon(
                                                    Icons.arrow_upward_sharp,
                                                    color: Colors.black,
                                                    size: 30.0,
                                                  ),
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'CHATAPGE2_arrow_upward_sharp_ICN_ON_TAP');
                                                    // createUserMessage
                                                    logFirebaseEvent(
                                                        'IconButton_createUserMessage');

                                                    var chatMessagesRecordReference1 =
                                                        ChatMessagesRecord
                                                            .collection
                                                            .doc();
                                                    await chatMessagesRecordReference1
                                                        .set({
                                                      ...createChatMessagesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        chat: widget
                                                            .chatReference,
                                                        text: _model
                                                            .fullNameController
                                                            .text,
                                                        ai: false,
                                                        nextPrompt:
                                                            '${widget.prompt} \\n상대방 : ${_model.fullNameController.text} \\n남사친 :',
                                                        image: '',
                                                      ),
                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                    });
                                                    _model.createUserMessage =
                                                        ChatMessagesRecord
                                                            .getDocumentFromData({
                                                      ...createChatMessagesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        chat: widget
                                                            .chatReference,
                                                        text: _model
                                                            .fullNameController
                                                            .text,
                                                        ai: false,
                                                        nextPrompt:
                                                            '${widget.prompt} \\n상대방 : ${_model.fullNameController.text} \\n남사친 :',
                                                        image: '',
                                                      ),
                                                      'timestamp':
                                                          DateTime.now(),
                                                    }, chatMessagesRecordReference1);
                                                    logFirebaseEvent(
                                                        'IconButton_backend_call');
                                                    _model.apiResult94f =
                                                        await ClovaCall.call(
                                                      text: _model
                                                          .createUserMessage
                                                          ?.nextPrompt,
                                                    );
                                                    logFirebaseEvent(
                                                        'IconButton_scroll_to');
                                                    await _model
                                                        .listViewController
                                                        ?.animateTo(
                                                      _model
                                                          .listViewController!
                                                          .position
                                                          .maxScrollExtent,
                                                      duration: Duration(
                                                          milliseconds: 1),
                                                      curve: Curves.ease,
                                                    );
                                                    logFirebaseEvent(
                                                        'IconButton_scroll_to');
                                                    await _model
                                                        .columnController
                                                        ?.animateTo(
                                                      _model
                                                          .columnController!
                                                          .position
                                                          .maxScrollExtent,
                                                      duration: Duration(
                                                          milliseconds: 1),
                                                      curve: Curves.ease,
                                                    );
                                                    logFirebaseEvent(
                                                        'IconButton_clear_text_fields_pin_codes');
                                                    setState(() {
                                                      _model.fullNameController
                                                          ?.clear();
                                                    });
                                                    if ((_model.apiResult94f
                                                            ?.succeeded ??
                                                        true)) {
                                                      // createAIMessage
                                                      logFirebaseEvent(
                                                          'IconButton_createAIMessage');

                                                      var chatMessagesRecordReference2 =
                                                          ChatMessagesRecord
                                                              .collection
                                                              .doc();
                                                      await chatMessagesRecordReference2
                                                          .set({
                                                        ...createChatMessagesRecordData(
                                                          user:
                                                              currentUserReference,
                                                          chat: widget
                                                              .chatReference,
                                                          text: getJsonField(
                                                            (_model.apiResult94f
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.result.outputText''',
                                                          ).toString(),
                                                          ai: true,
                                                          nextPrompt:
                                                              '${_model.createUserMessage?.nextPrompt}${getJsonField(
                                                            (_model.apiResult94f
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.result.outputText''',
                                                          ).toString()}',
                                                          image: '',
                                                          loveNumber: (String
                                                                      aIresponse,
                                                                  double
                                                                      randomNumber) {
                                                            return randomNumber *
                                                                (aIresponse
                                                                    .split(' ')
                                                                    .length);
                                                          }(
                                                              getJsonField(
                                                                (_model.apiResult94f
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$.result.outputText''',
                                                              ).toString(),
                                                              random_data
                                                                  .randomDouble(
                                                                      0.005,
                                                                      0.01)),
                                                          imageNumber: 0,
                                                        ),
                                                        'timestamp': FieldValue
                                                            .serverTimestamp(),
                                                      });
                                                      _model.createAIMessage =
                                                          ChatMessagesRecord
                                                              .getDocumentFromData({
                                                        ...createChatMessagesRecordData(
                                                          user:
                                                              currentUserReference,
                                                          chat: widget
                                                              .chatReference,
                                                          text: getJsonField(
                                                            (_model.apiResult94f
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.result.outputText''',
                                                          ).toString(),
                                                          ai: true,
                                                          nextPrompt:
                                                              '${_model.createUserMessage?.nextPrompt}${getJsonField(
                                                            (_model.apiResult94f
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.result.outputText''',
                                                          ).toString()}',
                                                          image: '',
                                                          loveNumber: (String
                                                                      aIresponse,
                                                                  double
                                                                      randomNumber) {
                                                            return randomNumber *
                                                                (aIresponse
                                                                    .split(' ')
                                                                    .length);
                                                          }(
                                                              getJsonField(
                                                                (_model.apiResult94f
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$.result.outputText''',
                                                              ).toString(),
                                                              random_data
                                                                  .randomDouble(
                                                                      0.005,
                                                                      0.01)),
                                                          imageNumber: 0,
                                                        ),
                                                        'timestamp':
                                                            DateTime.now(),
                                                      }, chatMessagesRecordReference2);
                                                      logFirebaseEvent(
                                                          'IconButton_wait__delay');
                                                      await Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  2000));
                                                      if (functions
                                                              .floor(
                                                                  chatapge2ChatsRecord
                                                                      .loveNumber)
                                                              .toString() !=
                                                          (((_model.createAIMessage!
                                                                              .loveNumber *
                                                                          10 +
                                                                      chatapge2ChatsRecord
                                                                              .loveNumber *
                                                                          10)
                                                                  .floor()))
                                                              .toString()) {
                                                        logFirebaseEvent(
                                                            'IconButton_backend_call');

                                                        await _model
                                                            .createAIMessage!
                                                            .reference
                                                            .update(
                                                                createChatMessagesRecordData(
                                                          imageNumber: ((_model
                                                                          .createAIMessage!
                                                                          .loveNumber *
                                                                      10 +
                                                                  chatapge2ChatsRecord
                                                                          .loveNumber *
                                                                      10)
                                                              .floor()),
                                                        ));
                                                        logFirebaseEvent(
                                                            'IconButton_lottie_animation');
                                                        await lottieAnimationController
                                                            .forward();
                                                        lottieAnimationController
                                                            .reset();
                                                      }
                                                      // updateChat
                                                      logFirebaseEvent(
                                                          'IconButton_updateChat');

                                                      await widget
                                                          .chatReference!
                                                          .update({
                                                        ...createChatsRecordData(
                                                          lastMessage: _model
                                                              .createAIMessage
                                                              ?.text,
                                                          prompt: _model
                                                              .createAIMessage
                                                              ?.nextPrompt,
                                                        ),
                                                        'last_message_time':
                                                            FieldValue
                                                                .serverTimestamp(),
                                                        'love_number': FieldValue
                                                            .increment(_model
                                                                .createAIMessage!
                                                                .loveNumber),
                                                        'user_message_count':
                                                            FieldValue
                                                                .increment(1),
                                                      });
                                                    } else {
                                                      logFirebaseEvent(
                                                          'IconButton_show_snack_bar');
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'error',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    }

                                                    logFirebaseEvent(
                                                        'IconButton_scroll_to');
                                                    await _model
                                                        .listViewController
                                                        ?.animateTo(
                                                      _model
                                                          .listViewController!
                                                          .position
                                                          .maxScrollExtent,
                                                      duration: Duration(
                                                          milliseconds: 1),
                                                      curve: Curves.ease,
                                                    );
                                                    logFirebaseEvent(
                                                        'IconButton_scroll_to');
                                                    await _model
                                                        .columnController
                                                        ?.animateTo(
                                                      _model
                                                          .columnController!
                                                          .position
                                                          .maxScrollExtent,
                                                      duration: Duration(
                                                          milliseconds: 1),
                                                      curve: Curves.ease,
                                                    );
                                                    logFirebaseEvent(
                                                        'IconButton_widget_animation');
                                                    if (animationsMap[
                                                            'textOnActionTriggerAnimation'] !=
                                                        null) {
                                                      await animationsMap[
                                                              'textOnActionTriggerAnimation']!
                                                          .controller
                                                          .forward(from: 0.0);
                                                    }

                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
