import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsRecord extends FirestoreRecord {
  ChatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_a" field.
  DocumentReference? _userA;
  DocumentReference? get userA => _userA;
  bool hasUserA() => _userA != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "last_message_time" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "last_message_sent_by" field.
  DocumentReference? _lastMessageSentBy;
  DocumentReference? get lastMessageSentBy => _lastMessageSentBy;
  bool hasLastMessageSentBy() => _lastMessageSentBy != null;

  // "last_message_seen_by" field.
  List<DocumentReference>? _lastMessageSeenBy;
  List<DocumentReference> get lastMessageSeenBy =>
      _lastMessageSeenBy ?? const [];
  bool hasLastMessageSeenBy() => _lastMessageSeenBy != null;

  // "character" field.
  DocumentReference? _character;
  DocumentReference? get character => _character;
  bool hasCharacter() => _character != null;

  // "prompt" field.
  String? _prompt;
  String get prompt => _prompt ?? '';
  bool hasPrompt() => _prompt != null;

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "user_b" field.
  DocumentReference? _userB;
  DocumentReference? get userB => _userB;
  bool hasUserB() => _userB != null;

  // "user_message_count" field.
  int? _userMessageCount;
  int get userMessageCount => _userMessageCount ?? 0;
  bool hasUserMessageCount() => _userMessageCount != null;

  // "love_number" field.
  double? _loveNumber;
  double get loveNumber => _loveNumber ?? 0.0;
  bool hasLoveNumber() => _loveNumber != null;

  // "imageCount" field.
  int? _imageCount;
  int get imageCount => _imageCount ?? 0;
  bool hasImageCount() => _imageCount != null;

  void _initializeFields() {
    _userA = snapshotData['user_a'] as DocumentReference?;
    _lastMessage = snapshotData['last_message'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _lastMessageSentBy =
        snapshotData['last_message_sent_by'] as DocumentReference?;
    _lastMessageSeenBy = getDataList(snapshotData['last_message_seen_by']);
    _character = snapshotData['character'] as DocumentReference?;
    _prompt = snapshotData['prompt'] as String?;
    _users = getDataList(snapshotData['users']);
    _userB = snapshotData['user_b'] as DocumentReference?;
    _userMessageCount = castToType<int>(snapshotData['user_message_count']);
    _loveNumber = castToType<double>(snapshotData['love_number']);
    _imageCount = castToType<int>(snapshotData['imageCount']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chats');

  static Stream<ChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsRecord.fromSnapshot(s));

  static Future<ChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsRecord.fromSnapshot(s));

  static ChatsRecord fromSnapshot(DocumentSnapshot snapshot) => ChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsRecordData({
  DocumentReference? userA,
  String? lastMessage,
  DateTime? lastMessageTime,
  DocumentReference? lastMessageSentBy,
  DocumentReference? character,
  String? prompt,
  DocumentReference? userB,
  int? userMessageCount,
  double? loveNumber,
  int? imageCount,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_a': userA,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'last_message_sent_by': lastMessageSentBy,
      'character': character,
      'prompt': prompt,
      'user_b': userB,
      'user_message_count': userMessageCount,
      'love_number': loveNumber,
      'imageCount': imageCount,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsRecordDocumentEquality implements Equality<ChatsRecord> {
  const ChatsRecordDocumentEquality();

  @override
  bool equals(ChatsRecord? e1, ChatsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userA == e2?.userA &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        e1?.lastMessageSentBy == e2?.lastMessageSentBy &&
        listEquality.equals(e1?.lastMessageSeenBy, e2?.lastMessageSeenBy) &&
        e1?.character == e2?.character &&
        e1?.prompt == e2?.prompt &&
        listEquality.equals(e1?.users, e2?.users) &&
        e1?.userB == e2?.userB &&
        e1?.userMessageCount == e2?.userMessageCount &&
        e1?.loveNumber == e2?.loveNumber &&
        e1?.imageCount == e2?.imageCount;
  }

  @override
  int hash(ChatsRecord? e) => const ListEquality().hash([
        e?.userA,
        e?.lastMessage,
        e?.lastMessageTime,
        e?.lastMessageSentBy,
        e?.lastMessageSeenBy,
        e?.character,
        e?.prompt,
        e?.users,
        e?.userB,
        e?.userMessageCount,
        e?.loveNumber,
        e?.imageCount
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsRecord;
}
