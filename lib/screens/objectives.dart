import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:laboratorio/database/database.dart';
import 'package:laboratorio/schemas/objectives.dart';
import 'package:laboratorio/components/bottomNavigator.dart';
import 'package:laboratorio/screens/mainScreen.dart';

import 'objectivesMetrics.dart';

class AddObjectiveScreen extends StatefulWidget {
  final ObjectiveData? objective;

  const AddObjectiveScreen({Key? key, this.objective}) : super(key: key);

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
    if (widget.objective != null) {
      _descriptionController.text = widget.objective!.description;
      _valueController.text = widget.objective!.value.toString();
      _selectedType = widget.objective!.type;
    }
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

      if (widget.objective == null) {
        await db.createRecord(db.objectives, objective);
      } else {
        await db.updateRecord(
          db.objectives,
          objective.copyWith(id: Value(widget.objective!.id)),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Objective saved successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen(initialIndex: 3)),
      );
    }
  }

  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(initialIndex: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.objective == null ? 'Add Objective' : 'Edit Objective'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Value'),
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
                decoration: const InputDecoration(labelText: 'Type'),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveObjective,
                child: Text(widget.objective == null ? 'Save Objective' : 'Update Objective'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigator(
        onItemTapped: _onItemTapped,
        selectedIndex: 3,
      ),
    );
  }
}