import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Traveler since 2025',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
         // Profile Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat(context, '2', 'Trips'),
              _buildStat(context, '8', 'Places'),
              _buildStat(context, '15', 'Days'),
            ],
          ),
         
          const SizedBox(height: 32),
          // Settings
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            context,
            Icons.edit,
            'Edit Profile',
            'Update your personal information',
          ),
          _buildSettingItem(
            context,
            Icons.notifications,
            'Notifications',
            'Manage your notification preferences',
          ),
          _buildSettingItem(
            context,
            Icons.language,
            'Language',
            'Change application language',
          ),
          _buildThemeSettingItem(
            context,
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            'Theme',
            themeProvider.isDarkMode ? 'Switch to Light theme' : 'Switch to Dark theme',
            themeProvider,
          ),
          _buildSettingItem(
            context,
            Icons.security,
            'Privacy',
            'Manage your privacy settings',
          ),
          _buildSettingItem(
            context,
            Icons.help,
            'Help & Support',
            'Get assistance or report issues',
          ),
          _buildSettingItem(
            context,
            Icons.logout,
            'Logout',
            'Sign out from your account',
          ),
         
          const SizedBox(height: 24),         
          // App Info
          Center(
            child: Text(
              'Travel Itinerary Planner v1.0.0',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            // Navigate to Home
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }


  Widget _buildStat(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      ],
    );
  }


  Widget _buildSettingItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle navigation to respective settings screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title feature coming soon!'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
  
 
  Widget _buildThemeSettingItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    ThemeProvider themeProvider,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: SwitchListTile(
        secondary: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        value: themeProvider.isDarkMode,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (value) {
          themeProvider.toggleTheme();
        },
      ),
    );
  }
}
