import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubmitTrashDialog extends StatefulWidget {
  final String title;
  const SubmitTrashDialog({super.key, required this.title});

  @override
  State<SubmitTrashDialog> createState() => _SubmitTrashDialogState();
}

class _SubmitTrashDialogState extends State<SubmitTrashDialog> {
  int _points = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Points',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  _points = 0;
                  return;
                }

                _points = int.parse(value);
              });
            },
            onSubmitted: (value) {
              setState(() {
                if (value.isEmpty) {
                  _points = 0;
                  return;
                }

                _points = int.parse(value);
                Navigator.of(context).pop(_points);
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
