import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'icon_widget.dart';

class AccountPage extends StatelessWidget {

  static const keyLanguage = 'key-language';
  static const keyLocation = 'key-location';

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
      title: 'Account Settings',
      leading: IconWidget(
        icon: Icons.person,
        color: Colors.green,
      ),
      subtitle: 'Privacy, Security, Language',
      child: SettingsScreen(
        title: 'Account Settings',
        children: <Widget>[
          buildLanguage(),
          buildLocation(),
          buildPrivacy(context),
          buildSecurity(context),
          buildAccountInfo(context),
        ],
      ),
      onTap: () {}
  );

  Widget buildSecurity(BuildContext context) =>
      SimpleSettingsTile(
          title: 'Security',
          leading: IconWidget(
            icon: Icons.security,
            color: Colors.red,
          ),
          onTap: () {}
      );

  Widget buildPrivacy(BuildContext context) =>
      SimpleSettingsTile(
          title: 'Privacy',
          leading: IconWidget(
            icon: Icons.lock,
            color: Colors.blue,
          ),
          onTap: () {}
      );

  Widget buildAccountInfo(BuildContext context) =>
      SimpleSettingsTile(
          title: 'Account Info',
          leading: IconWidget(
            icon: Icons.text_snippet,
            color: Colors.purple,
          ),
          onTap: () {}
      );


  Widget buildLanguage() =>
      DropDownSettingsTile(
        title: 'Language',
        settingKey: keyLanguage,
        selected: 1,
        values: <int, String>{
          1: 'English',
          2: 'Hindi',
          3: 'Spanish',
          4: 'Bangla',
        },
      );

  Widget buildLocation() =>
      TextInputSettingsTile(
        settingKey: keyLocation,
        title: 'Location',
        initialValue: 'Khulna',
        onChange: (location) {},
      );

}
