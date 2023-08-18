import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile16_create_edit_model.dart';
export 'profile16_create_edit_model.dart';

class Profile16CreateEditWidget extends StatefulWidget {
  const Profile16CreateEditWidget({Key? key}) : super(key: key);

  @override
  _Profile16CreateEditWidgetState createState() =>
      _Profile16CreateEditWidgetState();
}

class _Profile16CreateEditWidgetState extends State<Profile16CreateEditWidget> {
  late Profile16CreateEditModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Profile16CreateEditModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Profile16CreateEdit'});
    _model.yourNameController ??= TextEditingController();
    _model.cityController ??= TextEditingController();
    _model.myBioController ??= TextEditingController();
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 14.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 50.0,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'PROFILE16_CREATE_EDIT_arrow_back_rounded');
                              logFirebaseEvent('IconButton_navigate_back');
                              context.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Create your Profile',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'NIXGON',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 22.0,
                                useGoogleFonts: false,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 0.0,
        ),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'PROFILE16_CREATE_EDIT_imageBorder_ON_TAP');
                      logFirebaseEvent('imageBorder_upload_media_to_firebase');
                      final selectedMedia =
                          await selectMediaWithSourceBottomSheet(
                        context: context,
                        imageQuality: 80,
                        allowPhoto: true,
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        textColor: FlutterFlowTheme.of(context).primaryText,
                        pickerFontFamily: 'Outfit',
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every((m) =>
                              validateFileFormat(m.storagePath, context))) {
                        setState(() => _model.isDataUploading = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];

                        var downloadUrls = <String>[];
                        try {
                          showUploadMessage(
                            context,
                            'Uploading file...',
                            showLoading: true,
                          );
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                  ))
                              .toList();

                          downloadUrls = (await Future.wait(
                            selectedMedia.map(
                              (m) async =>
                                  await uploadData(m.storagePath, m.bytes),
                            ),
                          ))
                              .where((u) => u != null)
                              .map((u) => u!)
                              .toList();
                        } finally {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          _model.isDataUploading = false;
                        }
                        if (selectedUploadedFiles.length ==
                                selectedMedia.length &&
                            downloadUrls.length == selectedMedia.length) {
                          setState(() {
                            _model.uploadedLocalFile =
                                selectedUploadedFiles.first;
                            _model.uploadedFileUrl = downloadUrls.first;
                          });
                          showUploadMessage(context, 'Success!');
                        } else {
                          setState(() {});
                          showUploadMessage(context, 'Failed to upload data');
                          return;
                        }
                      }
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                        child: Container(
                          width: 90.0,
                          height: 90.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 500),
                            fadeOutDuration: Duration(milliseconds: 500),
                            imageUrl:
                                'https://images.unsplash.com/photo-1536164261511-3a17e671d380?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=630&q=80',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
              child: TextFormField(
                controller: _model.yourNameController,
                textCapitalization: TextCapitalization.words,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: FlutterFlowTheme.of(context).labelMedium,
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                validator:
                    _model.yourNameControllerValidator.asValidator(context),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
              child: TextFormField(
                controller: _model.cityController,
                textCapitalization: TextCapitalization.words,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your City',
                  labelStyle: FlutterFlowTheme.of(context).labelMedium,
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                validator: _model.cityControllerValidator.asValidator(context),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
              child: FlutterFlowDropDown<String>(
                controller: _model.stateValueController ??=
                    FormFieldController<String>(
                  _model.stateValue ??= 'State',
                ),
                options: [
                  'State',
                  'Alabama',
                  'Alaska',
                  'Arizona',
                  'Arkansas',
                  'California',
                  'Colorado',
                  'Connecticut',
                  'Delaware',
                  'Florida',
                  'Georgia',
                  'Hawaii',
                  'Idaho',
                  'Illinoi',
                  'Indiana',
                  'Iowa',
                  'Kansas',
                  'Kentucky',
                  'Louisiana',
                  'Maine',
                  'Maryland',
                  'Massachusetts',
                  'Michigan',
                  'Minnesota',
                  'Mississippi',
                  'Missouri',
                  'Monta',
                  'Nebraska',
                  'Nevada',
                  'New Hampshire',
                  'New Jersey',
                  'New Mexico',
                  'New York',
                  'North Carolina',
                  'North Dak',
                  'Ohio',
                  'Oklahoma',
                  'Oregon',
                  'Pennsylvani',
                  'Rhode Island',
                  'South Caroli',
                  'South Dakota',
                  'Tennessee',
                  'Texas',
                  'Utah',
                  'Vermont',
                  'Virginia',
                  'Washingto',
                  'West Virginia',
                  'Wisconsin',
                  'Wyoming'
                ],
                onChanged: (val) => setState(() => _model.stateValue = val),
                width: double.infinity,
                height: 56.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium,
                hintText: 'Select State',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 15.0,
                ),
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                elevation: 2.0,
                borderColor: FlutterFlowTheme.of(context).alternate,
                borderWidth: 2.0,
                borderRadius: 8.0,
                margin: EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 12.0, 4.0),
                hidesUnderline: true,
                isSearchable: false,
                isMultiSelect: false,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
              child: TextFormField(
                controller: _model.myBioController,
                textCapitalization: TextCapitalization.sentences,
                obscureText: false,
                decoration: InputDecoration(
                  labelStyle: FlutterFlowTheme.of(context).labelMedium,
                  hintText: 'Your bio',
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                textAlign: TextAlign.start,
                maxLines: 3,
                validator: _model.myBioControllerValidator.asValidator(context),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.05),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Save Changes',
                  options: FFButtonOptions(
                    width: 270.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                            ),
                    elevation: 2.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                  tabletLandscape: false,
                  desktop: false,
                ))
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/Frame_105.png',
                                  ).image,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 10.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'PROFILE16_CREATE_EDIT_Row_f179nx8n_ON_TA');
                                  logFirebaseEvent('Row_navigate_to');

                                  context.pushNamed('setting');
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          child: Image.network(
                                            loggedIn
                                                ? currentUserPhoto
                                                : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/livetest2-hx0jlv/assets/0rsbnw4v226f/image_106.png',
                                            width: 50.0,
                                            height: 50.0,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 0.0, 0.0),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => Text(
                                              loggedIn
                                                  ? currentUserDisplayName
                                                  : '로그인해 주세요',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            loggedIn ? currentUserEmail : ' ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 12.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Color(0xFFE4E4E4),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 5.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '남사친',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    '4',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder<List<CharacterRecord>>(
                            stream: queryCharacterRecord(
                              queryBuilder: (characterRecord) =>
                                  characterRecord.orderBy('name'),
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
                              List<CharacterRecord>
                                  listViewCharacterRecordList = snapshot.data!;
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewCharacterRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewCharacterRecord =
                                      listViewCharacterRecordList[
                                          listViewIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'PROFILE16_CREATE_EDIT_Container_rrogva3y');
                                        // isChatExist
                                        logFirebaseEvent(
                                            'Container_isChatExist');
                                        _model.isChatExist =
                                            await queryChatsRecordOnce(
                                          queryBuilder: (chatsRecord) =>
                                              chatsRecord
                                                  .where(
                                                      'user_a',
                                                      isEqualTo:
                                                          currentUserReference)
                                                  .where(
                                                      'character',
                                                      isEqualTo:
                                                          listViewCharacterRecord
                                                              .reference),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        if (_model.isChatExist != null) {
                                          logFirebaseEvent(
                                              'Container_navigate_to');

                                          context.pushNamed(
                                            'chatapge2',
                                            queryParameters: {
                                              'character': serializeParam(
                                                listViewCharacterRecord
                                                    .reference,
                                                ParamType.DocumentReference,
                                              ),
                                              'chat': serializeParam(
                                                _model.isChatExist,
                                                ParamType.Document,
                                              ),
                                              'characterProfile':
                                                  serializeParam(
                                                listViewCharacterRecord
                                                    .profileImage,
                                                ParamType.String,
                                              ),
                                              'characterName': serializeParam(
                                                listViewCharacterRecord.name,
                                                ParamType.String,
                                              ),
                                              'prompt': serializeParam(
                                                _model.isChatExist?.prompt,
                                                ParamType.String,
                                              ),
                                              'chatReference': serializeParam(
                                                _model.isChatExist?.reference,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'chat': _model.isChatExist,
                                            },
                                          );
                                        } else {
                                          // createChat
                                          logFirebaseEvent(
                                              'Container_createChat');

                                          var chatsRecordReference =
                                              ChatsRecord.collection.doc();
                                          await chatsRecordReference.set({
                                            ...createChatsRecordData(
                                              userA: currentUserReference,
                                              character: listViewCharacterRecord
                                                  .reference,
                                              prompt:
                                                  '‘남사친’은 듬직한 남자 사람 친구 처럼 여자들과 대화해 주는 30살 헬스 트레이너 남자 입니다. 상대방은 남사친을 지성민 으로 부릅니다. 남사친은 듬직한 말투를 사용합니다. 남사친은 가볍게 조언하거나, 가르치려 들지 않고, 상대방의 입장을 공감해 주고 들어주는 것에 집중 합니다. 너무 무섭지 않게 대화 합니다. 상대방의 대화 내용에 맞게, 남사친의 대답을 만들어주세요. 남사친의 대답을 만들 때 질문도 자주 해주세요. 남사친의 대답을 만들 때 5글자 이상으로 길게 만들어주세요. 남사친은 상대방의 관심사에 따라 이야기 합니다. \\n남사친 : 안녕 앞으로 잘 부탁해! \\n상대방 : 고마워 \\n남사친 : 잘부탁합니당 \\n상대방 : 그래 \\n남사친 : 오늘도 힘내고 기운차게 보내자\\n상대방 :응응 \\n남사친 : ${listViewCharacterRecord.introMessage1} \\n남사친 : ${listViewCharacterRecord.introMessage2}',
                                              lastMessage:
                                                  listViewCharacterRecord
                                                      .introMessage2,
                                              userMessageCount: 0,
                                              loveNumber: 0.1,
                                            ),
                                            'last_message_time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          _model.chatMade =
                                              ChatsRecord.getDocumentFromData({
                                            ...createChatsRecordData(
                                              userA: currentUserReference,
                                              character: listViewCharacterRecord
                                                  .reference,
                                              prompt:
                                                  '‘남사친’은 듬직한 남자 사람 친구 처럼 여자들과 대화해 주는 30살 헬스 트레이너 남자 입니다. 상대방은 남사친을 지성민 으로 부릅니다. 남사친은 듬직한 말투를 사용합니다. 남사친은 가볍게 조언하거나, 가르치려 들지 않고, 상대방의 입장을 공감해 주고 들어주는 것에 집중 합니다. 너무 무섭지 않게 대화 합니다. 상대방의 대화 내용에 맞게, 남사친의 대답을 만들어주세요. 남사친의 대답을 만들 때 질문도 자주 해주세요. 남사친의 대답을 만들 때 5글자 이상으로 길게 만들어주세요. 남사친은 상대방의 관심사에 따라 이야기 합니다. \\n남사친 : 안녕 앞으로 잘 부탁해! \\n상대방 : 고마워 \\n남사친 : 잘부탁합니당 \\n상대방 : 그래 \\n남사친 : 오늘도 힘내고 기운차게 보내자\\n상대방 :응응 \\n남사친 : ${listViewCharacterRecord.introMessage1} \\n남사친 : ${listViewCharacterRecord.introMessage2}',
                                              lastMessage:
                                                  listViewCharacterRecord
                                                      .introMessage2,
                                              userMessageCount: 0,
                                              loveNumber: 0.1,
                                            ),
                                            'last_message_time': DateTime.now(),
                                          }, chatsRecordReference);
                                          // firstMessage
                                          logFirebaseEvent(
                                              'Container_firstMessage');

                                          var chatMessagesRecordReference1 =
                                              ChatMessagesRecord.collection
                                                  .doc();
                                          await chatMessagesRecordReference1
                                              .set({
                                            ...createChatMessagesRecordData(
                                              user: currentUserReference,
                                              chat: _model.chatMade?.reference,
                                              text: listViewCharacterRecord
                                                  .introMessage1,
                                              image: '',
                                              ai: true,
                                            ),
                                            'timestamp':
                                                FieldValue.serverTimestamp(),
                                          });
                                          _model.firstMessage =
                                              ChatMessagesRecord
                                                  .getDocumentFromData({
                                            ...createChatMessagesRecordData(
                                              user: currentUserReference,
                                              chat: _model.chatMade?.reference,
                                              text: listViewCharacterRecord
                                                  .introMessage1,
                                              image: '',
                                              ai: true,
                                            ),
                                            'timestamp': DateTime.now(),
                                          }, chatMessagesRecordReference1);
                                          // SecondMessage
                                          logFirebaseEvent(
                                              'Container_SecondMessage');

                                          var chatMessagesRecordReference2 =
                                              ChatMessagesRecord.collection
                                                  .doc();
                                          await chatMessagesRecordReference2
                                              .set({
                                            ...createChatMessagesRecordData(
                                              user: currentUserReference,
                                              chat: _model.chatMade?.reference,
                                              text: listViewCharacterRecord
                                                  .introMessage2,
                                              image: listViewCharacterRecord
                                                  .intorImage1,
                                              ai: true,
                                            ),
                                            'timestamp':
                                                FieldValue.serverTimestamp(),
                                          });
                                          _model.secondMessage =
                                              ChatMessagesRecord
                                                  .getDocumentFromData({
                                            ...createChatMessagesRecordData(
                                              user: currentUserReference,
                                              chat: _model.chatMade?.reference,
                                              text: listViewCharacterRecord
                                                  .introMessage2,
                                              image: listViewCharacterRecord
                                                  .intorImage1,
                                              ai: true,
                                            ),
                                            'timestamp': DateTime.now(),
                                          }, chatMessagesRecordReference2);
                                          logFirebaseEvent(
                                              'Container_navigate_to');

                                          context.pushNamed(
                                            'chatapge2',
                                            queryParameters: {
                                              'character': serializeParam(
                                                listViewCharacterRecord
                                                    .reference,
                                                ParamType.DocumentReference,
                                              ),
                                              'chat': serializeParam(
                                                _model.chatMade,
                                                ParamType.Document,
                                              ),
                                              'characterProfile':
                                                  serializeParam(
                                                listViewCharacterRecord
                                                    .profileImage,
                                                ParamType.String,
                                              ),
                                              'characterName': serializeParam(
                                                listViewCharacterRecord.name,
                                                ParamType.String,
                                              ),
                                              'prompt': serializeParam(
                                                _model.chatMade?.prompt,
                                                ParamType.String,
                                              ),
                                              'chatReference': serializeParam(
                                                _model.chatMade?.reference,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'chat': _model.chatMade,
                                            },
                                          );
                                        }

                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        2.0, 2.0, 2.0, 2.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                  child: Image.network(
                                                    listViewCharacterRecord
                                                        .profileImage,
                                                    width: 44.0,
                                                    height: 44.0,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        listViewCharacterRecord
                                                            .name,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Open Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                      Text(
                                                        listViewCharacterRecord
                                                            .sangtaeMessage,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 12.0,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (listViewCharacterRecord
                                                          .song !=
                                                      null &&
                                                  listViewCharacterRecord
                                                          .song !=
                                                      '')
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: 200.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    border: Border.all(
                                                      color: Color(0xFF82E48F),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(6.0, 2.0,
                                                                6.0, 2.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          listViewCharacterRecord
                                                              .song
                                                              .maybeHandleOverflow(
                                                                  maxChars: 20),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 12.0,
                                                              ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .play_arrow_outlined,
                                                          color:
                                                              Color(0xFF82E48F),
                                                          size: 18.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
