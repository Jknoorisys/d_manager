import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class DeliveryDetails {
  String deliveryDate;
  String transportName;
  String hammalName;

  DeliveryDetails({
    required this.deliveryDate,
    required this.transportName,
    required this.hammalName,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeliveryListScreen(),
    );
  }
}

class DeliveryListScreen extends StatefulWidget {
  @override
  _DeliveryListScreenState createState() => _DeliveryListScreenState();
}

class _DeliveryListScreenState extends State<DeliveryListScreen> {
  List<DeliveryDetails> deliveryDetailsList = [];

  void _addDeliveryDetails(
      String deliveryDate, String transportName, String hammalName) {
    setState(() {
      deliveryDetailsList.add(
        DeliveryDetails(
          deliveryDate: deliveryDate,
          transportName: transportName,
          hammalName: hammalName,
        ),
      );
    });
  }

  void _deleteDeliveryDetails(int index) {
    setState(() {
      deliveryDetailsList.removeAt(index);
    });
  }

  void _showAddDeliveryDialog(BuildContext context) {
    TextEditingController deliveryDateController = TextEditingController();
    TextEditingController transportNameController = TextEditingController();
    TextEditingController hammalNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Delivery Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: deliveryDateController,
                  decoration: InputDecoration(labelText: 'Delivery Date'),
                ),
                TextField(
                  controller: transportNameController,
                  decoration: InputDecoration(labelText: 'Transport Name'),
                ),
                TextField(
                  controller: hammalNameController,
                  decoration: InputDecoration(labelText: 'Hammal Name'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                _addDeliveryDetails(
                  deliveryDateController.text,
                  transportNameController.text,
                  hammalNameController.text,
                );
                Navigator.of(context).pop();
              },
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
        title: Text('Delivery Details'),
      ),
      body: ListView.builder(
        itemCount: deliveryDetailsList.length,
        itemBuilder: (BuildContext context, int index) {
          final delivery = deliveryDetailsList[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(delivery.deliveryDate),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Transport Name: ${delivery.transportName}'),
                  Text('Hammal Name: ${delivery.hammalName}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Add edit functionality here
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteDeliveryDetails(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDeliveryDialog(context);
        },
        tooltip: 'Add Delivery',
        child: Icon(Icons.add),
      ),
    );
  }
}
