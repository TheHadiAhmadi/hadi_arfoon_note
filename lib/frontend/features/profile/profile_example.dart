import 'package:arfoon_note/frontend/features/profile/profile_view.dart';
import 'package:flutter/material.dart';

class ProfileExample extends StatefulWidget {
  const ProfileExample({super.key});

  @override
  State<ProfileExample> createState() => _ProfileExampleState();
}

class _ProfileExampleState extends State<ProfileExample> {
  void onSave(username) {
    print('Username=$username');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: IconButton(
            onPressed: () async {
              var text = await ProfileView.show(context);
              print('User name=$text');
            },
            icon: const Icon(Icons.verified_user)));
  }
}
