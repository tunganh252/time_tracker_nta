import 'package:flutter/material.dart';
import 'package:test_01/app/home/model/job.dart';

class JobListTitle extends StatelessWidget {
  const JobListTitle({Key? key, required this.job, required this.onTap})
      : super(key: key);

  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
