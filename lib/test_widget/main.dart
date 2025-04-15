import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipeable List Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SwipeableListScreen(),
    );
  }
}

class SwipeableListScreen extends StatefulWidget {
  @override
  _SwipeableListScreenState createState() => _SwipeableListScreenState();
}

class _SwipeableListScreenState extends State<SwipeableListScreen> {
  final List<String> items = [
    'آیتم شماره ۱',
    'آیتم شماره ۲',
    'آیتم شماره ۳',
    'آیتم شماره ۴',
    'آیتم شماره ۵',
  ];

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('آیتم حذف شد')),
      );
    });
  }

  void _editItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(text: items[index]);
        return AlertDialog(
          title: Text('ویرایش آیتم'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'متن جدید'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('انصراف'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  items[index] = controller.text;
                });
                Navigator.pop(context);
              },
              child: Text('ذخیره'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لیست قابل Swipe'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(items[index]),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.blue,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.edit, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                // حذف
                _deleteItem(index);
                return false; // چون خودمان حذف را انجام دادیم
              } else {
                // ویرایش
                _editItem(index);
                return false; // چون خودمان ویرایش را انجام دادیم
              }
            },
            child: Card(
              child: ListTile(
                title: Text(items[index]),
                trailing: Icon(Icons.drag_handle),
              ),
            ),
          );
        },
      ),
    );
  }
}