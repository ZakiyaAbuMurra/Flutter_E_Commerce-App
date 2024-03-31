import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // Add more controllers if needed for other fields like phone, address, etc.

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    // Dispose other controllers if created
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pre-fill the TextFields with the current user information (not shown here for brevity)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            // Add more TextFields for other editable fields
            ElevatedButton(
              onPressed: () {
                updateUserProfile();
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUserProfile() async {
    // Get the current user's UID
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    if (userUid != null) {
      await FirebaseFirestore.instance.collection('users').doc(userUid).update({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        // Add other fields as necessary
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $error')),
        );
      });
    }
  }
}
