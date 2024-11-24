import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final Function(String title, String description) onSubmit;
  final String? initialTitle;
  final String? initialDescription;

  TaskForm({required this.onSubmit, this.initialTitle, this.initialDescription});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.initialTitle ?? '';
    _description = widget.initialDescription ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: _title,
            decoration: InputDecoration(labelText: 'Title'),
            onSaved: (value) => _title = value ?? '',
            validator: (value) => value!.isEmpty ? 'Enter a title' : null,
          ),
          TextFormField(
            initialValue: _description,
            decoration: InputDecoration(labelText: 'Description'),
            onSaved: (value) => _description = value ?? '',
            validator: (value) => value!.isEmpty ? 'Enter a description' : null,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onSubmit(_title, _description);
              }
            },
          ),
        ],
      ),
    );
  }
}
