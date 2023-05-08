import 'package:flutter/material.dart';

import '../../models/models.dart';

class LogCard extends StatelessWidget {
  final Log log;

  const LogCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    var textColor = log.change > 0
        ? Theme.of(context).colorScheme.onPrimaryContainer
        : Theme.of(context).colorScheme.onTertiaryContainer;

    return Card(
      color: log.change > 0
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.tertiaryContainer,
      child: ListTile(
          title: Text(
            log.name,
            style: TextStyle(color: textColor),
          ),
          trailing: Text(
            log.change.toString(),
            style: TextStyle(color: textColor),
          ),
          leading: Icon(
            log.change > 0
                ? Icons.restore_from_trash_rounded
                : Icons.emoji_food_beverage_rounded,
            color: textColor,
          )),
    );
  }
}
