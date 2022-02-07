import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordle/shared/extensions.dart';
import 'package:wordle/shared/models/game_state.dart';
import 'package:wordle/shared/widgets/rounded_back_button.dart';

import '../widgets/countdown.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen(
    this.game, {
    Key? key,
  }) : super(key: key);

  final GameState game;

  @override
  Widget build(BuildContext context) {
    final tr = context.read<Map<String, String>>();
    print('STNG LCLZ $tr');
    return Scaffold(
      appBar: AppBar(
        leading: const RoundedBackButton(),
        title: Text(context.lclz('settings')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => launch('https://t.me/raxysstudios'),
        icon: const Icon(Icons.send_rounded),
        label: Text(context.lclz('contact')),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          ListTile(
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.schedule_rounded),
            ),
            title: Countdown(
              builder: (context, string) => Text(string),
            ),
            subtitle: Text(context.lclz('coming')),
          ),
          ListTile(
            onTap: () => launch('https://github.com/alkaitagi/mecel'),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.code_rounded),
            ),
            trailing: const Icon(Icons.launch_rounded),
            title: const Text('GitHub Repository'),
            subtitle: FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                var info = '...';
                final package = snapshot.data;
                if (package != null) {
                  info = 'v${package.version}'
                      ' • '
                      'b${package.buildNumber}';
                }
                return Text(info);
              },
            ),
          ),
        ],
      ),
    );
  }
}