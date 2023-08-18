import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CharacterRecord extends FirestoreRecord {
  CharacterRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "profile_image" field.
  String? _profileImage;
  String get profileImage => _profileImage ?? '';
  bool hasProfileImage() => _profileImage != null;

  // "sangtae_message" field.
  String? _sangtaeMessage;
  String get sangtaeMessage => _sangtaeMessage ?? '';
  bool hasSangtaeMessage() => _sangtaeMessage != null;

  // "intro_message_1" field.
  String? _introMessage1;
  String get introMessage1 => _introMessage1 ?? '';
  bool hasIntroMessage1() => _introMessage1 != null;

  // "intro_message_2" field.
  String? _introMessage2;
  String get introMessage2 => _introMessage2 ?? '';
  bool hasIntroMessage2() => _introMessage2 != null;

  // "intor_image_1" field.
  String? _intorImage1;
  String get intorImage1 => _intorImage1 ?? '';
  bool hasIntorImage1() => _intorImage1 != null;

  // "song" field.
  String? _song;
  String get song => _song ?? '';
  bool hasSong() => _song != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  bool hasOrder() => _order != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "Age" field.
  int? _age;
  int get age => _age ?? 0;
  bool hasAge() => _age != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _profileImage = snapshotData['profile_image'] as String?;
    _sangtaeMessage = snapshotData['sangtae_message'] as String?;
    _introMessage1 = snapshotData['intro_message_1'] as String?;
    _introMessage2 = snapshotData['intro_message_2'] as String?;
    _intorImage1 = snapshotData['intor_image_1'] as String?;
    _song = snapshotData['song'] as String?;
    _uid = snapshotData['uid'] as String?;
    _order = castToType<int>(snapshotData['order']);
    _description = snapshotData['description'] as String?;
    _age = castToType<int>(snapshotData['Age']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('character');

  static Stream<CharacterRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CharacterRecord.fromSnapshot(s));

  static Future<CharacterRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CharacterRecord.fromSnapshot(s));

  static CharacterRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CharacterRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CharacterRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CharacterRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CharacterRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CharacterRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCharacterRecordData({
  String? name,
  String? profileImage,
  String? sangtaeMessage,
  String? introMessage1,
  String? introMessage2,
  String? intorImage1,
  String? song,
  String? uid,
  int? order,
  String? description,
  int? age,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'profile_image': profileImage,
      'sangtae_message': sangtaeMessage,
      'intro_message_1': introMessage1,
      'intro_message_2': introMessage2,
      'intor_image_1': intorImage1,
      'song': song,
      'uid': uid,
      'order': order,
      'description': description,
      'Age': age,
    }.withoutNulls,
  );

  return firestoreData;
}

class CharacterRecordDocumentEquality implements Equality<CharacterRecord> {
  const CharacterRecordDocumentEquality();

  @override
  bool equals(CharacterRecord? e1, CharacterRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.profileImage == e2?.profileImage &&
        e1?.sangtaeMessage == e2?.sangtaeMessage &&
        e1?.introMessage1 == e2?.introMessage1 &&
        e1?.introMessage2 == e2?.introMessage2 &&
        e1?.intorImage1 == e2?.intorImage1 &&
        e1?.song == e2?.song &&
        e1?.uid == e2?.uid &&
        e1?.order == e2?.order &&
        e1?.description == e2?.description &&
        e1?.age == e2?.age;
  }

  @override
  int hash(CharacterRecord? e) => const ListEquality().hash([
        e?.name,
        e?.profileImage,
        e?.sangtaeMessage,
        e?.introMessage1,
        e?.introMessage2,
        e?.intorImage1,
        e?.song,
        e?.uid,
        e?.order,
        e?.description,
        e?.age
      ]);

  @override
  bool isValidKey(Object? o) => o is CharacterRecord;
}
