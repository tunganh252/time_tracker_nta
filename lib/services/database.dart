import 'package:test_01/app/home/model/job.dart';
import 'package:test_01/services/api_path.dart';
import 'package:test_01/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Stream<List<Job>> jobsStream();

  Future<void> deleteJob(Job job);
}

String documentIDFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});

  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) =>
      _service.setData(path: APIPath.job(uid, job.id), job: job.toMap());

  @override
  Future<void> deleteJob(Job job) async =>
      _service.deleteData(path: APIPath.job(uid, job.id));

  @override
   Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid),
      builder: (data, documentID) => Job.fromMap(data, documentID));
}
