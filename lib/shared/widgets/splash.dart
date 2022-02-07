import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'raxys.dart';

class Splash<T> extends StatelessWidget {
  const Splash({
    required this.title,
    required this.future,
    required this.onLoaded,
    this.minDuration = const Duration(seconds: 1),
    Key? key,
  }) : super(key: key);

  final Duration minDuration;
  final String title;
  final Future<T> future;
  final void Function(BuildContext, T) onLoaded;

  @override
  Widget build(context) {
    return FutureBuilder<List>(
      future: Future.wait<dynamic>([
        Future<dynamic>.delayed(minDuration),
        future,
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          SchedulerBinding.instance?.addPostFrameCallback(
            (_) => onLoaded(
              context,
              snapshot.data![1] as T,
            ),
          );
        }
        return Material(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RaxysLogo(size: 256),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Made with honor in'),
                const Text(
                  'North Caucasus',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}