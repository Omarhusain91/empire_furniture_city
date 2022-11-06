// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basics.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class BasicsCollectionReference
    implements
        BasicsQuery,
        FirestoreCollectionReference<Basics, BasicsQuerySnapshot> {
  factory BasicsCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$BasicsCollectionReference;

  static Basics fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return _$BasicsFromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Basics value,
    SetOptions? options,
  ) {
    return _$BasicsToJson(value);
  }

  @override
  CollectionReference<Basics> get reference;

  @override
  BasicsDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<BasicsDocumentReference> add(Basics value);
}

class _$BasicsCollectionReference extends _$BasicsQuery
    implements BasicsCollectionReference {
  factory _$BasicsCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$BasicsCollectionReference._(
      firestore.collection('Inventory').withConverter(
            fromFirestore: BasicsCollectionReference.fromFirestore,
            toFirestore: BasicsCollectionReference.toFirestore,
          ),
    );
  }

  _$BasicsCollectionReference._(
    CollectionReference<Basics> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  String get path => reference.path;

  @override
  CollectionReference<Basics> get reference =>
      super.reference as CollectionReference<Basics>;

  @override
  BasicsDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return BasicsDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<BasicsDocumentReference> add(Basics value) {
    return reference.add(value).then((ref) => BasicsDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$BasicsCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class BasicsDocumentReference
    extends FirestoreDocumentReference<Basics, BasicsDocumentSnapshot> {
  factory BasicsDocumentReference(DocumentReference<Basics> reference) =
      _$BasicsDocumentReference;

  DocumentReference<Basics> get reference;

  /// A reference to the [BasicsCollectionReference] containing this document.
  BasicsCollectionReference get parent {
    return _$BasicsCollectionReference(reference.firestore);
  }

  @override
  Stream<BasicsDocumentSnapshot> snapshots();

  @override
  Future<BasicsDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    List<String> categories,
  });

  Future<void> set(Basics value);
}

class _$BasicsDocumentReference
    extends FirestoreDocumentReference<Basics, BasicsDocumentSnapshot>
    implements BasicsDocumentReference {
  _$BasicsDocumentReference(this.reference);

  @override
  final DocumentReference<Basics> reference;

  /// A reference to the [BasicsCollectionReference] containing this document.
  BasicsCollectionReference get parent {
    return _$BasicsCollectionReference(reference.firestore);
  }

  @override
  Stream<BasicsDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return BasicsDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<BasicsDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return BasicsDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<void> delete() {
    return reference.delete();
  }

  Future<void> update({
    Object? categories = _sentinel,
  }) async {
    final json = {
      if (categories != _sentinel) "categories": categories as List<String>,
    };

    return reference.update(json);
  }

  Future<void> set(Basics value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is BasicsDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class BasicsDocumentSnapshot extends FirestoreDocumentSnapshot<Basics> {
  BasicsDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<Basics> snapshot;

  @override
  BasicsDocumentReference get reference {
    return BasicsDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Basics? data;
}

abstract class BasicsQuery
    implements QueryReference<Basics, BasicsQuerySnapshot> {
  @override
  BasicsQuery limit(int limit);

  @override
  BasicsQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  BasicsQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    BasicsDocumentSnapshot? startAtDocument,
    BasicsDocumentSnapshot? endAtDocument,
    BasicsDocumentSnapshot? endBeforeDocument,
    BasicsDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  BasicsQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  BasicsQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  BasicsQuery whereCategories({
    List<String>? isEqualTo,
    List<String>? isNotEqualTo,
    List<String>? isLessThan,
    List<String>? isLessThanOrEqualTo,
    List<String>? isGreaterThan,
    List<String>? isGreaterThanOrEqualTo,
    bool? isNull,
    String? arrayContains,
    List<String>? arrayContainsAny,
  });

  BasicsQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    BasicsDocumentSnapshot? startAtDocument,
    BasicsDocumentSnapshot? endAtDocument,
    BasicsDocumentSnapshot? endBeforeDocument,
    BasicsDocumentSnapshot? startAfterDocument,
  });

  BasicsQuery orderByCategories({
    bool descending = false,
    List<String> startAt,
    List<String> startAfter,
    List<String> endAt,
    List<String> endBefore,
    BasicsDocumentSnapshot? startAtDocument,
    BasicsDocumentSnapshot? endAtDocument,
    BasicsDocumentSnapshot? endBeforeDocument,
    BasicsDocumentSnapshot? startAfterDocument,
  });
}

class _$BasicsQuery extends QueryReference<Basics, BasicsQuerySnapshot>
    implements BasicsQuery {
  _$BasicsQuery(
    this._collection, {
    required Query<Basics> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  BasicsQuerySnapshot _decodeSnapshot(
    QuerySnapshot<Basics> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return BasicsQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<BasicsDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: BasicsDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return BasicsQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<BasicsQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<BasicsQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  BasicsQuery limit(int limit) {
    return _$BasicsQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  BasicsQuery limitToLast(int limit) {
    return _$BasicsQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  BasicsQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    BasicsDocumentSnapshot? startAtDocument,
    BasicsDocumentSnapshot? endAtDocument,
    BasicsDocumentSnapshot? endBeforeDocument,
    BasicsDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$BasicsQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  BasicsQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$BasicsQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  BasicsQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$BasicsQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  BasicsQuery whereCategories({
    List<String>? isEqualTo,
    List<String>? isNotEqualTo,
    List<String>? isLessThan,
    List<String>? isLessThanOrEqualTo,
    List<String>? isGreaterThan,
    List<String>? isGreaterThanOrEqualTo,
    bool? isNull,
    String? arrayContains,
    List<String>? arrayContainsAny,
  }) {
    return _$BasicsQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$BasicsFieldMap["categories"]!,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
      ),
      $queryCursor: $queryCursor,
    );
  }

  BasicsQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    BasicsDocumentSnapshot? startAtDocument,
    BasicsDocumentSnapshot? endAtDocument,
    BasicsDocumentSnapshot? endBeforeDocument,
    BasicsDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$BasicsQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  BasicsQuery orderByCategories({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    BasicsDocumentSnapshot? startAtDocument,
    BasicsDocumentSnapshot? endAtDocument,
    BasicsDocumentSnapshot? endBeforeDocument,
    BasicsDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor
        .orderBy(_$BasicsFieldMap["categories"]!, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$BasicsQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$BasicsQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class BasicsQuerySnapshot
    extends FirestoreQuerySnapshot<Basics, BasicsQueryDocumentSnapshot> {
  BasicsQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<Basics> snapshot;

  @override
  final List<BasicsQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<BasicsDocumentSnapshot>> docChanges;
}

class BasicsQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot<Basics>
    implements BasicsDocumentSnapshot {
  BasicsQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<Basics> snapshot;

  @override
  BasicsDocumentReference get reference {
    return BasicsDocumentReference(snapshot.reference);
  }

  @override
  final Basics data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
const _$BasicsFieldMap = <String, String> {
  'categories': 'categories'
};
Basics _$BasicsFromJson(Map<String, dynamic> json) => Basics(
      (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
      Map<String, String>.from(json['colors'] as Map),
    );

Map<String, dynamic> _$BasicsToJson(Basics instance) => <String, dynamic>{
      'categories': instance.categories,
      'colors': instance.colors,
    };
