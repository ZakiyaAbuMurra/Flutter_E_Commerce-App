import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    final usersCollection = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile page
            },
          ),
        ],
      ),
      body: userUid == null
          ? const Center(child: Text("No user found."))
          : FutureBuilder<DocumentSnapshot>(
              future: usersCollection.doc(userUid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching user data."));
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text("User data not found."));
                }

                var userData = snapshot.data!.data() as Map<String, dynamic>;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            userData['photoUrl'] ?? 'default_avatar_url'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userData['name'] ?? 'Name not available',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userData['email'] ?? 'Email not available',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(userData['phone'] ?? 'Phone not available'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(
                            userData['address'] ?? 'Address not available'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            // Navigate to login or initial page as needed
                          },
                          child: const Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Colors.red, // Text Color (Foreground color)
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
