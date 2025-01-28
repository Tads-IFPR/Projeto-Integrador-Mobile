import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:laboratorio/database/database.dart';
import 'package:laboratorio/schemas/objectives.dart';
import '../components/bottomNavigator.dart';
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
  int _selectedIndex = 0;
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
        await db.updateRecord(db.objectives, objective.copyWith(id: Value(widget.objective!.id)));
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Objective saved successfully')),
      );
      Navigator.pop(context);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/chat');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/metrics');
        break;
    }
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
                child: Text(widget.objective == null ? 'Save Objective' : 'Update Objective'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigator(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}