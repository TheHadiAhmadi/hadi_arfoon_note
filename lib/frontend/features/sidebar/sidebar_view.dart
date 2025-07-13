import 'package:flutter/material.dart';

class SidebarView extends StatelessWidget {
  SidebarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogo(),
          const SizedBox(height: 40),
          _buildSection('👤 Profile'),
          _buildSection('⚙️ Settings'),
          _buildSection('📁 Files'),
          _buildSection('🔔 Notifications'),
          _buildSection('❓ Help'),
          Spacer(),
          _buildSection('🚪 Logout'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(Icons.ac_unit, color: Colors.white, size: 32),
          const SizedBox(width: 10),
          Text('MyApp', style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(title, style: TextStyle(color: Colors.white70, fontSize: 16)),
    );
  }
}
