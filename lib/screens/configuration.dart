import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:JAJA/database/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:JAJA/main.dart';

import 'chat.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedLanguage = 'English';
  bool _saveMessages = false;

  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    final users = await db.getAllRecords(db.users);
    setState(() {
      _users = users;
    });
  }

  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _saveUser() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and Email are required')),
      );
      return;
    }

    int? imageId;
    if (_selectedImage != null) {
      final file = FilesdbCompanion.insert(
        mimeType: 'image/jpeg', // Adjust as needed
        size: await _selectedImage!.length(),
        path: _selectedImage!.path,
        duration: const Value.absent(),
      );

      try {
        imageId = await db.into(db.filesdb).insert(file);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving image: $e')),
        );
        return;
      }
    }

    final user = UsersCompanion.insert(
      name: _nameController.text,
      email: _emailController.text,
      description: _descriptionController.text,
      isSaveChats: Value(_saveMessages),
      photoId: imageId != null ? Value(imageId) : const Value.absent(),
    );

    try {
      final userId = await db.createRecord(db.users, user);
      if (userId != null) {
        final user = await db.getRecordById(db.users, userId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              'User saved successfully with ID: ${user?.id} NAME: ${user?.name} EMAIL: ${user?.email}')),
        );
      }

      await _fetchUsers();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => App(initialIndex: 0),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving user: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Configurations',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: _selectedImage == null
                    ? const Text('No image selected.')
                    : SizedBox(
                  width: 200, // Define the maximum width
                  height: 200, // Define the maximum height
                  child: Image.file(File(_selectedImage!.path)),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Select Image'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Short Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                    value: _saveMessages,
                    onChanged: (value) {
                      setState(() {
                        _saveMessages = value;
                      });
                    },
                  ),
                  const Text(
                    'Save Messages',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}