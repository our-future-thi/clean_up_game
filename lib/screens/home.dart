import 'dart:math';
import 'dart:ui';

import 'package:clean_up_game/screens/utils/log_card.dart';
import 'package:clean_up_game/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/models.dart';
import '../shared/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0, end: 2).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var logs = Provider.of<List<Log>>(context);
    var credits = logs.fold<int>(
        0, (previousValue, element) => previousValue + element.change);

    var size = min(MediaQuery.of(context).size.width - 64,
        min(MediaQuery.of(context).size.height / 2, 350.0));

    var x = 3 * sin(2 * pi * (_animation.value + 0.5));
    var y = 3 * cos(2 * pi * (_animation.value + 0.5));

    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context, 'Clean Up Game'),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(75, 149, 178, 34),
                        blurRadius: 3,
                        spreadRadius: 3,
                        offset: Offset(
                          x * -1,
                          y,
                        ),
                      ),
                      BoxShadow(
                        color: const Color.fromARGB(75, 41, 156, 177),
                        blurRadius: 6,
                        spreadRadius: 6,
                        offset: Offset(
                          x,
                          y * -1,
                        ),
                      )
                    ],
                  ),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: QrImageView(
                        data: AuthService().user!.uid,
                        size: size,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(
                        credits.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: credits > 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const Text(
                        'Credits',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size + 32),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: logs.length,
                    itemBuilder: (context, index) => LogCard(
                      log: logs[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
