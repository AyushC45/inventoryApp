import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomePage.dart';
import 'ReceiptsPage.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('inventory').orderBy('price', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var documents = snapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length ?? 0,
            itemBuilder: (context, index) {
              var item = documents?[index];
              if (item == null) return SizedBox(); // Null safety check
              return GestureDetector(
                onTap: () {
                  _showEditInventoryDialog(context, item); // Pass the item data to the edit dialog
                },
                child: ListTile(
                  title: Text(item['name'] ?? ''),
                  subtitle: Text('Amount: ${item['amount'] ?? ''}, Price: ${item['price'] ?? ''}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddInventoryDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Receipts',
          ),
        ],
        currentIndex: 1, // Set currentIndex to 1 for InventoryPage
        selectedItemColor: Colors.deepPurple, // Set selected item color to purple
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Do nothing, already on InventoryPage
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReceiptsPage()),
            );
          }
        },
      ),
    );
  }

  void _showAddInventoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Inventory'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addInventoryItem();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addInventoryItem() {
    String name = _nameController.text.trim();
    String amount = _amountController.text.trim(); // Update this line
    double price = double.tryParse(_priceController.text.trim()) ?? 0.0;

    FirebaseFirestore.instance.collection('inventory').add({
      'name': name,
      'amount': amount,
      'price': price,
    });

    _nameController.clear();
    _amountController.clear();
    _priceController.clear();
  }

  void _showEditInventoryDialog(BuildContext context, QueryDocumentSnapshot<Object?> item) {
    // Create a dialog to edit inventory item details
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Inventory'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: item['name'] as String? ?? ''),
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: TextEditingController(text: '${item['amount']}' ?? ''),
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: TextEditingController(text: '${item['price']}' ?? ''),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }




}
