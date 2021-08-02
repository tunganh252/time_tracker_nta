import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_01/app/home/jobs/edit_job_page.dart';
import 'package:test_01/app/home/model/job.dart';
import 'package:test_01/common_widgets/show_alert_dialog.dart';
import 'package:test_01/services/auth.dart';
import 'package:test_01/services/database.dart';

import 'job_list_title.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: "Logout",
        content: "Are you sure that you want logout?",
        defaultActionText: "Logout",
        cancelActionText: "Cancel");

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  //
  // Future<void> _createJob(BuildContext context) async {
  //   try {
  //     final database = Provider.of<Database>(context, listen: false);
  //     await database.createJob(Job(ratePerHour: 10, name: "Hello123"));
  //   } on FirebaseException catch (e) {
  //     showExceptionAlertDialog(context,
  //         title: "Operation failed", exception: e, defaultActionText: "Ok");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final job = Job(name: "test", ratePerHour: 1);

    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs"),
        actions: [
          TextButton(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 15.5),
              ),
              onPressed: () => _confirmSignOut(context))
        ],
      ),
      body: _createContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(context, TypeAction.create, job),
      ),
    );
  }

  Widget _createContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<Iterable<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          final children = jobs!
              .map(
                (job) => JobListTitle(job: job, onTap: () {}),
              )
              .toList();
          return ListView(
            children: children,
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("Some error occurred"),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
