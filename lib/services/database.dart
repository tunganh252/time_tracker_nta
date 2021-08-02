import 'package:test_01/app/home/model/job.dart';
import 'package:test_01/services/api_path.dart';
import 'package:test_01/services/firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);

  Stream<Iterable<Job>> jobsStream();
}

String documentIDFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});

  final String uid;

  final _service = FirestoreService.instance;

  Future<void> createJob(Job job) => _service.setData(
      path: APIPath.job(uid, documentIDFromCurrentDate()), job: job.toMap());

  Stream<Iterable<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid), builder: (data) => Job.fromMap(data));
}
