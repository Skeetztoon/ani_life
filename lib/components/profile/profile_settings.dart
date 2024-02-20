import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size:35, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Настройки",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text("Поменять фото"),
            )
          ],
        ),
      ),
    );
  }
}
