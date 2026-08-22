import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitchOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: _bodyUi(context));
  }

  Widget _bodyUi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [_settingsList(context)]),
    );
  }

  Widget _settingsList(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
           ListTile(
            title:const Text(
              'Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle:isSwitchOn? Text(
              'Dark',
              style: TextStyle(color: Colors.black.withAlpha(100)),
            )  :Text(
              'Light',
              style: TextStyle(color: Colors.black.withAlpha(100)),
            ),
            leading:const Icon(Icons.color_lens_outlined),
          ),
          ListTile(
            title:const  Text(
              'Change Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Light/ Dark',
              style: TextStyle(color: Colors.black.withAlpha(100)),
            ),
            leading:const Icon(Icons.palette_outlined),
            trailing: Switch(
              inactiveTrackColor:  Colors.deepPurpleAccent,
              inactiveThumbColor: Colors.white,
              
              
              overlayColor: WidgetStatePropertyAll(Colors.blue),
              value: isSwitchOn,
              onChanged: (value) {
                isSwitchOn = value;
                setState(() {
                  
                });
              },
            ),
          ),
          Divider(color: Colors.black.withAlpha(25),thickness: 2,),
         const ListTile(
            title: Text(
              'About App',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            leading: Icon(Icons.error_outline),
          ),
          Divider(color: Colors.black.withAlpha(25),thickness: 2,),
           ListTile(
            title:const Text(
              'Version',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            leading:const Icon(Icons.access_time),
            trailing: Text('1.1.2',style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black.withAlpha(100)),),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(title: Text('Settings'));
  }
}
