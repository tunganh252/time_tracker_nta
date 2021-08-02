import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_01/app/home/model/job.dart';
import 'package:test_01/common_widgets/show_alert_dialog.dart';
import 'package:test_01/common_widgets/show_exception_alert_dialog.dart';
import 'package:test_01/services/database.dart';

enum TypeAction { create, edit }

class EditJobPage extends StatefulWidget {
  const EditJobPage({
    Key? key,
    required this.database,
    required this.typeAction,
    required this.job,
  }) : super(key: key);
  final Database database;
  final TypeAction typeAction;
  final Job job;

  static Future<void> show(
      BuildContext context, TypeAction typeAction, Job job) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditJobPage(
              database: database,
              typeAction: typeAction,
              job: job,
            ),
        fullscreenDialog: true));
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _ratePerHour = 0;

  @override
  void initState() {
    super.initState();
    if (widget.typeAction == TypeAction.edit) {
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((item) => item.name).toList();

        if (widget.typeAction == TypeAction.edit) {
          allNames.remove(widget.job.name);
        }

        if (allNames.contains(_name)) {
          showAlertDialog(context,
              title: "Name already used",
              content: "Please choose a different job name",
              defaultActionText: "Oke");
        } else {
          final id = widget.job.id ?? documentIDFromCurrentDate();
          final job = Job(id: id, name: _name, ratePerHour: _ratePerHour);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: "Operation failed", exception: e, defaultActionText: "Oke");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(
            widget.typeAction == TypeAction.create ? "New Job" : "Edit Job"),
        actions: [
          TextButton(
              onPressed: _submit,
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ))
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildFormChildren()));
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        initialValue: _name,
        decoration: InputDecoration(labelText: "Job name"),
        onSaved: (value) => _name = value!,
        validator: (value) => value!.isNotEmpty ? null : "Name can\'t be empty",
      ),
      TextFormField(
          initialValue: '$_ratePerHour',
          decoration: InputDecoration(labelText: "Rate per hour"),
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false),
          onSaved: (value) => _ratePerHour = int.tryParse(value!)!),
    ];
  }
}
