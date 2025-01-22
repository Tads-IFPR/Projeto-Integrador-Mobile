import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart' as flutter;
import 'package:image_picker/image_picker.dart';
import 'package:laboratorio/database/database.dart';
import 'package:laboratorio/dao/profile.dart';
import 'package:laboratorio/screens/configuration.dart';
import 'package:laboratorio/screens/metrics.dart'; // Importe a tela DatabaseOverview

class UserProfile extends flutter.StatefulWidget {
  final int userId;

  const UserProfile({super.key, required this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends flutter.State<UserProfile> {
  User? _user;
  File? _userImage;
  final flutter.TextEditingController _nameController = flutter.TextEditingController();
  final flutter.TextEditingController _emailController = flutter.TextEditingController();
  final flutter.TextEditingController _descriptionController = flutter.TextEditingController();
  bool _saveMessages = false;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<int?> _fetchLastUserId() async {
    final lastUser = await (db.select(db.users)
      ..orderBy([(u) => drift.OrderingTerm.desc(u.id)])
      ..limit(1))
        .getSingleOrNull();
    return lastUser?.id;
  }

  Future<void> _fetchUser() async {
    final lastUserId = await _fetchLastUserId();
    if (lastUserId == null) {
      // Handle case where there are no users in the database
      return;
    }

    final user = await db.getRecordById(db.users, lastUserId);
    if (user != null && user.photoId != null) {
      final file = await db.getRecordById(db.filesdb, user.photoId!);
      if (file != null) {
        setState(() {
          _user = user;
          _userImage = File(file.path);
          _nameController.text = user.name;
          _emailController.text = user.email;
          _descriptionController.text = user.description;
          _saveMessages = user.isSaveChats;
        });
      } else {
        setState(() {
          _user = user;
          _nameController.text = user.name;
          _emailController.text = user.email;
          _descriptionController.text = user.description;
          _saveMessages = user.isSaveChats;
        });
      }
    } else {
      setState(() {
        _user = user;
        _nameController.text = user?.name ?? '';
        _emailController.text = user?.email ?? '';
        _descriptionController.text = user?.description ?? '';
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
      description: drift.Value(_descriptionController.text),
      isSaveChats: drift.Value(_saveMessages),
      photoId: drift.Value(_user!.photoId),
    );

    try {
      await db.updateRecord(db.users, updatedUser);
      flutter.ScaffoldMessenger.of(context).showSnackBar(
        const flutter.SnackBar(content: flutter.Text('User updated successfully')),
      );
    } catch (e) {
      flutter.ScaffoldMessenger.of(context).showSnackBar(
        flutter.SnackBar(content: flutter.Text('Error updating user: $e')),
      );
    }
  }

  Future<void> _deleteUser() async {
    if (_user == null) return;

    try {
      await deleteUserAndRelatedData(db);
      flutter.ScaffoldMessenger.of(context).showSnackBar(
        const flutter.SnackBar(content: flutter.Text('User deleted successfully')),
      );
      flutter.Navigator.pushReplacement(
        context,
        flutter.MaterialPageRoute(builder: (context) => const Configuration()),
      );
    } catch (e) {
      flutter.ScaffoldMessenger.of(context).showSnackBar(
        flutter.SnackBar(content: flutter.Text('Error deleting user: $e')),
      );
    }
  }

  @override
  flutter.Widget build(flutter.BuildContext context) {
    return flutter.Scaffold(
      appBar: flutter.AppBar(
        backgroundColor: flutter.Colors.transparent,
        elevation: 0,
        title: const flutter.Text(
          'Update Profile',
          style: flutter.TextStyle(
              color: flutter.Colors.black, fontSize: 28, fontWeight: flutter.FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: flutter.Padding(
        padding: const flutter.EdgeInsets.all(16.0),
        child: _user == null
            ? const flutter.Center(child: flutter.CircularProgressIndicator())
            : flutter.Column(
          crossAxisAlignment: flutter.CrossAxisAlignment.start,
          children: [
            const flutter.SizedBox(height: 20),
            flutter.Center(
              child: _userImage == null
                  ? const flutter.Text('No image available.')
                  : flutter.SizedBox(
                width: 200, // Define the maximum width
                height: 200, // Define the maximum height
                child: flutter.Image.file(_userImage!),
              ),
            ),
            const flutter.SizedBox(height: 20),
            flutter.TextField(
              controller: _nameController,
              decoration: const flutter.InputDecoration(
                labelText: 'Name',
                border: flutter.OutlineInputBorder(),
              ),
            ),
            const flutter.SizedBox(height: 10),
            flutter.TextField(
              controller: _emailController,
              decoration: const flutter.InputDecoration(
                labelText: 'Email',
                border: flutter.OutlineInputBorder(),
              ),
            ),
            const flutter.SizedBox(height: 10),
            flutter.TextField(
              controller: _descriptionController,
              decoration: const flutter.InputDecoration(
                labelText: 'Description',
                border: flutter.OutlineInputBorder(),
              ),
            ),
            const flutter.SizedBox(height: 20),
            flutter.Row(
              mainAxisAlignment: flutter.MainAxisAlignment.spaceBetween,
              children: [
                flutter.Switch(
                  value: _saveMessages,
                  onChanged: (value) {
                    setState(() {
                      _saveMessages = value;
                    });
                  },
                ),
                const flutter.Text(
                  'Save Messages',
                  style: flutter.TextStyle(fontSize: 16),
                ),
              ],
            ),
            const flutter.Spacer(),
            flutter.SizedBox(
              width: double.infinity,
              child: flutter.ElevatedButton(
                onPressed: _saveUser,
                style: flutter.ElevatedButton.styleFrom(
                  backgroundColor: flutter.Colors.blue,
                  padding: const flutter.EdgeInsets.symmetric(vertical: 16),
                ),
                child: const flutter.Text(
                  'SAVE',
                  style: flutter.TextStyle(fontSize: 16, fontWeight: flutter.FontWeight.bold),
                ),
              ),
            ),
            const flutter.SizedBox(height: 10),
            flutter.SizedBox(
              width: double.infinity,
              child: flutter.ElevatedButton(
                onPressed: _deleteUser,
                style: flutter.ElevatedButton.styleFrom(
                  backgroundColor: flutter.Colors.red,
                  padding: const flutter.EdgeInsets.symmetric(vertical: 16),
                ),
                child: const flutter.Text(
                  'DELETE',
                  style: flutter.TextStyle(fontSize: 16, fontWeight: flutter.FontWeight.bold),
                ),
              ),
            ),
            const flutter.SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}