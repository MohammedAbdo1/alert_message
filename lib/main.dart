import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LAWidget());
}  

class LAWidget extends StatelessWidget {
  const LAWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LAlertWidget(),
    );
  }
}

class LAlertWidget extends StatelessWidget {
  const LAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Function to Show SnackBar on dialog dismiss

    void _showSnackBar(String text, String ans) {
      final SnackBar snackBar = SnackBar(
          duration: const Duration(milliseconds: 500),
          backgroundColor:
              ans.compareTo('Yes') == 0 ? Colors.green : Colors.red,
          content: Row(
            children: <Widget>[
              Icon(
                ans.compareTo('Yes') == 0 ? Icons.favorite : Icons.watch_later,
                color: ans.compareTo('Yes') == 0 ? Colors.pink : Colors.yellow,
                size: 24.0,
                semanticLabel: text,
              ),
              Text(text)
            ],
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // Simple Dialog

    Future<void> _simpleDialog() async {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Simple Dialog, Is it nice?'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 'Yes');
                  },
                  child: const Text('Yes'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 'No');
                  },
                  child: const Text('No'),
                ),
              ],
            );
          })) {
        case 'Yes':
          _showSnackBar('Thanks!', 'Yes');
          break;
        case 'No':
          _showSnackBar('Oh! No... Try to provide you best', 'No');
          break;
      }
    }

    Future<void> _alertDialog() async {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text('Is it nice?'),
              title: const Text('Alert Dialog'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Yes');
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'No');
                  },
                  child: const Text('No'),
                ),
              ],
            );
          })) {
        case 'Yes':
          _showSnackBar('Thanks!', 'Yes');
          break;
        case 'No':
          _showSnackBar('Oh! No... Try to provide you best', 'No');
          break;
      }
    }

    void _timerDialog() {
      final DateTime now = DateTime.now();
      showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
          .then((TimeOfDay? onValue) {
        _showSnackBar(onValue?.format(context) ?? '', 'ok');
      });
    }

    void _datePickerDialog() {
      final DateTime now = DateTime.now();
      showDatePicker(
              context: context,
              initialDate: now,
              firstDate: DateTime(2000),
              lastDate: DateTime(2050))
          .then((DateTime? onValue) {
        _showSnackBar('$onValue', 'ok');
      });
    }

    Future<void> _cupertinoDialog() async {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Welcome'),
              content: const Text('Cupertino Dialog, Is it nice?'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, 'Yes');
                  },
                  child: const Text('Yes'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, 'No');
                  },
                  child: const Text('No'),
                ),
              ],
            );
          })) {
        case 'Yes':
          _showSnackBar('Thanks!', 'Yes');
          break;
        case 'No':
          _showSnackBar('Oh! No... Try to provide you best', 'No');
          break;
      }
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            child: const Text('Simple Dialog'),
            onPressed: _simpleDialog,
          ),
          ElevatedButton(
            child: const Text('Alert Dialog'),
            onPressed: _alertDialog,
          ),
          ElevatedButton(
            child: const Text('Date Picker Dialog'),
            onPressed: _datePickerDialog,
          ),
          ElevatedButton(
            child: const Text('Timer Picker Dialog'),
            onPressed: _timerDialog,
          ),
          ElevatedButton(
            child: const Text('Cupertino Dialog'),
            onPressed: _cupertinoDialog,
          )
        ],
      ),
    );
  }
}
