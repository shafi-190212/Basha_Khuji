import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'icon_widget.dart';
import 'languages_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Common'),
          tiles: [
            SettingsTile(
              title: Text('Language'),
              //title:  Text('English'),
              leading: IconWidget(icon: Icons.language,color: Colors.green,),
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LanguagesScreen(),
                ));
              },
            ),
            SettingsTile.switchTile(
              title: Text('Dark Mode'),
              enabled: notificationsEnabled,
              leading: IconWidget(icon:Icons.dark_mode,color: Color(0xFF642ef3),),
              //  switchValue: true,
              onToggle: (value) {}, initialValue: null,
            ),
          ],
        ),
        SettingsSection(
          title: Text('Account'),
          tiles: [
            SettingsTile(
                title: Text('Phone number'), leading: IconWidget(icon:Icons.phone,color:Colors.blueAccent)),
            SettingsTile(
              title: Text('Delete Account'),
              leading: IconWidget(icon:Icons.delete,color: Colors.redAccent,),
            ),
            SettingsTile(
              title: Text('Change Password'),
              leading: IconWidget(icon:Icons.password_sharp,color: Colors.blueGrey,),
            ),
          ],
        ),
        SettingsSection(
          title: Text('Security'),
          tiles: [
            SettingsTile.switchTile(
              title: Text('Lock app in background'),
              leading: IconWidget(icon:Icons.phonelink_lock,color: Colors.pinkAccent,),
              // switchValue: lockInBackground,
              onToggle: (bool value) {
                setState(() {
                  lockInBackground = value;
                  notificationsEnabled = value;
                });
              },
              initialValue: true,
            ),
            SettingsTile.switchTile(
              title: Text('Use fingerprint'),
              //   subtitle: 'Allow application to access stored fingerprint IDs.',
              leading: IconWidget(icon:Icons.fingerprint,color: Colors.black54,),
              onToggle: (bool value) {
              },
              //switchValue: true,
              initialValue: null,
            ),
            SettingsTile.switchTile(
              title: Text('Enable Notifications'),
              enabled: notificationsEnabled,
              leading: IconWidget(icon:Icons.notifications_active,color: Colors.lightGreen,),
              //  switchValue: true,
              initialValue: true,
              onToggle: (value) {
              },
            ),
          ],
        ),
        SettingsSection(
          title: Text('Misc'),
          tiles: [
            SettingsTile(
              title: Text('Report a Bug'),
              leading: IconWidget(
                    icon: Icons.bug_report,
                    color: Colors.teal,
            )),
            SettingsTile(
              title: Text('Send Feedback'),
              leading: IconWidget(
                icon: Icons.thumb_up,
                color: Colors.purple,
              ),),
            SettingsTile(
                title: Text('Terms of Service'),
                leading: IconWidget(icon:Icons.description,color: Colors.blue)),
            SettingsTile(
                title: Text('Open source licenses'),
                leading: IconWidget(icon:Icons.collections_bookmark,color: Colors.teal,)),

          ],
        ),
      ],
    );
  }
}
