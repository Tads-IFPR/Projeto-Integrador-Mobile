import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:laboratorio/database/database.dart';
import 'package:laboratorio/schemas/objectives.dart';

class AddObjectiveScreen extends StatefulWidget {
  @override
  _AddObjectiveScreenState createState() => _AddObjectiveScreenState();
}

class _AddObjectiveScreenState extends State<AddObjectiveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  ObjectiveType? _selectedType;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _fetchLastUserId();
  }

  Future<void> _fetchLastUserId() async {
    final users = await db.getAllRecords(db.users);
    if (users.isNotEmpty) {
      setState(() {
        _userId = users.last.id;
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  Future<void> _saveObjective() async {
    if (_formKey.currentState!.validate()) {
      final description = _descriptionController.text;
      final value = int.parse(_valueController.text);

      final objective = ObjectivesCompanion(
        description: Value(description),
        value: Value(value),
        type: Value(_selectedType!),
        userId: Value(_userId!),
      );

      await db.createRecord(db.objectives, objective);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Objective saved successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Objective'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valueController,
                decoration: InputDecoration(labelText: 'Value'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<ObjectiveType>(
                value: _selectedType,
                decoration: InputDecoration(labelText: 'Type'),
                items: ObjectiveType.values.map((ObjectiveType type) {
                  return DropdownMenuItem<ObjectiveType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (ObjectiveType? newValue) {
                  setState(() {
                    _selectedType = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveObjective,
                child: Text('Save Objective'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}