import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.title});

  final String? title;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<String?> _langController = ValueNotifier<String?>('eng');

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _langController.value = prefs.getString('language') ?? 'eng';
    _nameController.text = prefs.getString('name') ?? 'eng';
    _emailController.text = prefs.getString('email') ?? 'eng';
  }

  Future<void> _saveLanguage(String? lang) async {
    final prefs = await SharedPreferences.getInstance();

    if (lang != null) {
      await prefs.setString('language', lang);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _langController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _nameController.clear();
    _emailController.clear();
    _langController.value = 'eng';
  }

  Future<void> _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('email', _emailController.text);

      await prefs.setString('name', _nameController.text);

      if (_langController.value != null) {
        await prefs.setString('language', _langController.value!);
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Settings saved successfully!")));
    }

    _resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title ?? ''),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'What do people call you?',
                        labelText: 'Name *',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Name can't be empty";
                        }
                        if (value.contains('@')) {
                          return 'Do not use the @ char.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Your email address',
                        labelText: 'Email *',
                      ),
                      validator: (String? value) {
                        return (value != null && !value.contains('@'))
                            ? 'Value must be an email address'
                            : null;
                      },
                    ),
                    ValueListenableBuilder<String?>(
                      valueListenable: _langController,
                      builder: (context, selectedLanguage, child) {
                        return DropdownButtonFormField<String>(
                          value: selectedLanguage,
                          items: [
                            DropdownMenuItem(value: 'eng', child: Text('Eng')),
                            DropdownMenuItem(value: 'spa', child: Text('Spa')),
                          ],
                          onChanged: (value) {
                            _langController.value = value;
                            _saveLanguage(value);
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.language),
                            labelText: 'Language',
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _resetForm,
                          child: Text('Reset form'),
                        ),
                        ElevatedButton(
                          onPressed: _saveSettings,
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text('Back to main'),
            ),
          ],
        ),
      ),
    );
  }
}
