import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_01/app/home/model/job.dart';
import 'package:test_01/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});

  final String uid;

  Future<void> createJob(Job job) =>
      _setData(path: APIPath.job(uid, 'job_abc'), job: job.toMap());

  Future<void> _setData(
      {required String path, required Map<String, dynamic> job}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    reference.set(job);
  }
}
