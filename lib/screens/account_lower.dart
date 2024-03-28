import 'package:flutter/material.dart';
import '../bottom_menu.dart'; // Importing the BottomMenu widget

class AccountLower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy list of history items
    List<String> historyItems = [
      "2024-03-14          Hungry         12:30",
      "2024-03-14          Sleepy         15:45",
      "2024-03-14          Tired          18:00",

      // Add more history items as needed
    ];

    return Stack(
      children: [
        Container(
          color: Color.fromRGBO(50, 52, 62, 1.0), // Background color for AccountLower
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'History',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: historyItems.length,
                    itemBuilder: (context, index) {
                      return HistoryItem(
                        itemText: historyItems[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        BottomMenu(activePage: 'account'), // Add the BottomMenu
      ],
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String itemText;

  const HistoryItem({Key? key, required this.itemText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0), // Add margin on all sides
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Adjust padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color.fromRGBO(120, 125, 150, 1.0), // Background color of blocks
      ),
      child: SizedBox(
        width: double.infinity, // Make the block wider vertically
        child: Text(
          itemText,
          style: TextStyle(
            fontSize: 14.0, // Adjust font size
            color: Colors.white, // Text color
          ),
        ),
      ),
    );
  }
}
