import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData(
      {required String path, required Map<String, dynamic> job}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    reference.set(job);
  }

  Stream<Iterable<T>> collectionStream<T>(
      {required String path,
      required T Function(Map<String, dynamic> data) builder}) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) => snapshot.docs
        .map(
          (doc) => builder(doc.data()),
        )
        .toList());
  }
}
