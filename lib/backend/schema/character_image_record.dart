import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CharacterImageRecord extends FirestoreRecord {
  CharacterImageRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "character" field.
  DocumentReference? _character;
  DocumentReference? get character => _character;
  bool hasCharacter() => _character != null;

  // "chatImage" field.
  String? _chatImage;
  String get chatImage => _chatImage ?? '';
  bool hasChatImage() => _chatImage != null;

  // "imageCount" field.
  int? _imageCount;
  int get imageCount => _imageCount ?? 0;
  bool hasImageCount() => _imageCount != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "heart" field.
  int? _heart;
  int get heart => _heart ?? 0;
  bool hasHeart() => _heart != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _character = snapshotData['character'] as DocumentReference?;
    _chatImage = snapshotData['chatImage'] as String?;
    _imageCount = castToType<int>(snapshotData['imageCount']);
    _type = snapshotData['type'] as String?;
    _heart = castToType<int>(snapshotData['heart']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('characterImage')
          : FirebaseFirestore.instance.collectionGroup('characterImage');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('characterImage').doc();

  static Stream<CharacterImageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CharacterImageRecord.fromSnapshot(s));

  static Future<CharacterImageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CharacterImageRecord.fromSnapshot(s));

  static CharacterImageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CharacterImageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CharacterImageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CharacterImageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CharacterImageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CharacterImageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCharacterImageRecordData({
  DocumentReference? character,
  String? chatImage,
  int? imageCount,
  String? type,
  int? heart,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'character': character,
      'chatImage': chatImage,
      'imageCount': imageCount,
      'type': type,
      'heart': heart,
    }.withoutNulls,
  );

  return firestoreData;
}

class CharacterImageRecordDocumentEquality
    implements Equality<CharacterImageRecord> {
  const CharacterImageRecordDocumentEquality();

  @override
  bool equals(CharacterImageRecord? e1, CharacterImageRecord? e2) {
    return e1?.character == e2?.character &&
        e1?.chatImage == e2?.chatImage &&
        e1?.imageCount == e2?.imageCount &&
        e1?.type == e2?.type &&
        e1?.heart == e2?.heart;
  }

  @override
  int hash(CharacterImageRecord? e) => const ListEquality()
      .hash([e?.character, e?.chatImage, e?.imageCount, e?.type, e?.heart]);

  @override
  bool isValidKey(Object? o) => o is CharacterImageRecord;
}
