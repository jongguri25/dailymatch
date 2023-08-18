import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MatchRecord extends FirestoreRecord {
  MatchRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "character" field.
  DocumentReference? _character;
  DocumentReference? get character => _character;
  bool hasCharacter() => _character != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "isMatch" field.
  bool? _isMatch;
  bool get isMatch => _isMatch ?? false;
  bool hasIsMatch() => _isMatch != null;

  // "updatedDate" field.
  DateTime? _updatedDate;
  DateTime? get updatedDate => _updatedDate;
  bool hasUpdatedDate() => _updatedDate != null;

  void _initializeFields() {
    _character = snapshotData['character'] as DocumentReference?;
    _user = snapshotData['user'] as DocumentReference?;
    _isMatch = snapshotData['isMatch'] as bool?;
    _updatedDate = snapshotData['updatedDate'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('match');

  static Stream<MatchRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MatchRecord.fromSnapshot(s));

  static Future<MatchRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MatchRecord.fromSnapshot(s));

  static MatchRecord fromSnapshot(DocumentSnapshot snapshot) => MatchRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MatchRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MatchRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MatchRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MatchRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMatchRecordData({
  DocumentReference? character,
  DocumentReference? user,
  bool? isMatch,
  DateTime? updatedDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'character': character,
      'user': user,
      'isMatch': isMatch,
      'updatedDate': updatedDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class MatchRecordDocumentEquality implements Equality<MatchRecord> {
  const MatchRecordDocumentEquality();

  @override
  bool equals(MatchRecord? e1, MatchRecord? e2) {
    return e1?.character == e2?.character &&
        e1?.user == e2?.user &&
        e1?.isMatch == e2?.isMatch &&
        e1?.updatedDate == e2?.updatedDate;
  }

  @override
  int hash(MatchRecord? e) => const ListEquality()
      .hash([e?.character, e?.user, e?.isMatch, e?.updatedDate]);

  @override
  bool isValidKey(Object? o) => o is MatchRecord;
}
