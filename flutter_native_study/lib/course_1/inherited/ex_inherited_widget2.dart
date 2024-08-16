import 'package:flutter/material.dart';

class UserSettings {
  bool darkMode;

  UserSettings({this.darkMode = false});
}

class InheritedWidget2Example extends StatefulWidget {
  const InheritedWidget2Example({super.key});

  @override
  State<InheritedWidget2Example> createState() =>
      _InheritedWidget2ExampleState();
}

class _InheritedWidget2ExampleState extends State<InheritedWidget2Example> {
  UserSettings settings = UserSettings(darkMode: false);

  void _toggleDarkMode(bool value) {
    setState(() {
      settings.darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: settings.darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User Settings Inherited Widget'),
        ),
        body: UserSettingInheritedWidget(
          settings: settings,
          toggleDarkMode: _toggleDarkMode,
          child: const Center(child: SettingsWidget()),
        ),
      ),
    );
  }
}

class UserSettingInheritedWidget extends InheritedWidget {
  final UserSettings settings;
  final void Function(bool) toggleDarkMode;

  const UserSettingInheritedWidget(
      {super.key,
      required super.child,
      required this.settings,
      required this.toggleDarkMode});

  static UserSettingInheritedWidget of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<UserSettingInheritedWidget>();
    assert(result != null, 'No UserSettingsInheritedWidget fount in context');

    return result!;
  }

  @override
  bool updateShouldNotify(UserSettingInheritedWidget oldWidget) {
    return oldWidget.settings.darkMode != settings.darkMode;
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = UserSettingInheritedWidget.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Dark Mode is ${inheritedWidget.settings.darkMode ? 'ON' : 'OFF'}',
        ),
        Switch(
          value: inheritedWidget.settings.darkMode,
          onChanged: inheritedWidget.toggleDarkMode,
        )
      ],
    );
  }
}
