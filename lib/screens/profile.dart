import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:laboratorio/database/database.dart';

class UserProfile extends StatefulWidget {
  final int userId;

  const UserProfile({super.key, required this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? _user;
  File? _userImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedLanguage = 'English';
  bool _saveMessages = false;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final user = await db.getRecordById(db.users, 1);
    if (user != null && user.photoId != null) {
      final file = await db.getRecordById(db.filesdb, user.photoId!);
      if (file != null) {
        setState(() {
          _user = user;
          _userImage = File(file.path);
          _nameController.text = user.name;
          _emailController.text = user.email;
          _selectedLanguage = user.language;
          _saveMessages = user.isSaveChats;
        });
      } else {
        setState(() {
          _user = user;
          _nameController.text = user.name;
          _emailController.text = user.email;
          _selectedLanguage = user.language;
          _saveMessages = user.isSaveChats;
        });
      }
    } else {
      setState(() {
        _user = user;
        _nameController.text = user?.name ?? '';
        _emailController.text = user?.email ?? '';
        _selectedLanguage = user?.language ?? 'English';
        _saveMessages = user?.isSaveChats ?? false;
      });
    }
  }

  Future<void> _saveUser() async {
    if (_user == null) return;

    final updatedUser = UsersCompanion(
      id: drift.Value(_user!.id),
      name: drift.Value(_nameController.text),
      email: drift.Value(_emailController.text),
      language: drift.Value(_selectedLanguage),
      isSaveChats: drift.Value(_saveMessages),
      photoId: drift.Value(_user!.photoId),
    );

    try {
      await db.updateRecord(db.users, updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating user: $e')),
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
          'User Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _user == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: _userImage == null
                  ? const Text('No image available.')
                  : SizedBox(
                width: 200, // Define the maximum width
                height: 200, // Define the maximum height
                child: Image.file(_userImage!),
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
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              items: ['English', 'Portuguese']
                  .map((language) => DropdownMenuItem(
                value: language,
                child: Text(language),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Language',
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
            const Spacer(),
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
    );
  }
}