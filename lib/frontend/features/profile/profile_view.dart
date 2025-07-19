import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.name});

  final String name;

  @override
  State<ProfileView> createState() => _ProfileViewState();

  static Future<String?> show(BuildContext context, {required String name}) {
    return showDialog(
      context: context,
      builder: (context) {
        return ProfileView(name: name);
      },
    );
  }
}

class _ProfileViewState extends State<ProfileView> {
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          SvgPicture.asset(
            'images/logo.svg',
            width: 90,
            height: 90,
          ),
          const SizedBox(height: 24),
          const Text(
            'Welcome to Arfoon Note',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                label: Text('First Name'), hint: Text('Enter your first name')),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
