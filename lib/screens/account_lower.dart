import 'package:flutter/material.dart';
import 'package:record_with_play/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart'; // Import the DatabaseHelper

class AccountLower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper().getSpecialPages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>>? data = snapshot.data;
          if (data == null || data.isEmpty) {
            // Show empty page
            return Container(
              color: Color.fromRGBO(50, 52, 62, 1.0),
              child: Center(
                child: Text(
                  'No history available',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            // Show history items
            return Stack(
              children: [
                Container(
                  color: Color.fromRGBO(50, 52, 62, 1.0),
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(
                                    8.0), // Add margin on all sides
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 24.0), // Adjust padding
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color.fromRGBO(120, 125, 150,
                                      1.0), // Background color of blocks
                                ),
                                child: SizedBox(
                                  width: double
                                      .infinity, // Make the block wider vertically
                                  child: Text(
                                    '${data[index]['dateTime']} ${data[index]['pageName']}',
                                    style: TextStyle(
                                      fontSize: 14.0, // Adjust font size
                                      color: Colors.white, // Text color
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
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
      padding: EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 24.0), // Adjust padding
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
