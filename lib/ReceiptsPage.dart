import 'package:flutter/material.dart';
import 'InventoryPage.dart';
import 'HomePage.dart';

class ReceiptsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipts'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Receipts Page'),
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
        currentIndex: 2, // Set currentIndex to 2 for ReceiptsPage
        selectedItemColor: Colors.deepPurple, // Set selected item color to purple
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InventoryPage()),
            );
          } else if (index == 2) {
            // Do nothing, already on ReceiptsPage
          }
        },
      ),
    );
  }
}
