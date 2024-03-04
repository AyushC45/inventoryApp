import 'package:flutter/material.dart';
import 'InventoryPage.dart';
import 'ReceiptsPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InventoryPage()),
                );
              },
              child: Text('Go to Inventory'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Adjust button shape here
                ),
                padding: EdgeInsets.symmetric(horizontal: 20), // Adjust button padding here
                primary: Colors.deepPurpleAccent, // Change button color to purple
              ),
            ),
            SizedBox(width: 20), // Adjust spacing between buttons here
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceiptsPage()),
                );
              },
              child: Text('Go to Receipts'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Adjust button shape here
                ),
                padding: EdgeInsets.symmetric(horizontal: 20), // Adjust button padding here
                primary: Colors.deepPurpleAccent, // Change button color to purple
              ),
            ),
          ],
        ),
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
        currentIndex: 0,
        selectedItemColor: Colors.deepPurpleAccent, // Change selected item color to purple
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReceiptsPage()),
            );
          }
        },
      ),
    );
  }
}
