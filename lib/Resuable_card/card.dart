import 'package:flutter/material.dart';

class CustomizeCard extends StatelessWidget {
  final String title, hintText;
  final VoidCallback toggleButton;
  final List<Map<String, dynamic>> data;
  final TextEditingController controller;
  final bool isListVisible;
  final Function(String) onAdd, onDelete;
  const CustomizeCard({
    super.key,

    required this.title,

    required this.toggleButton,
    required this.controller,
    required this.isListVisible,
    required this.hintText,
    required this.data,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: .all(16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        onAdd(controller.text.trim());
                        controller.clear();
                      },
                      child: Icon(Icons.add_circle, size: 32),
                    ),
                    SizedBox(height: 12),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: toggleButton,
                      child: Icon(
                        size: 35,
                        isListVisible
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isListVisible) _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 310),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final name = data[index];
          return Padding(
            padding: const .only(bottom: 8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(name["name"].toUpperCase()),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => onDelete(name["id"]),
                      child: Icon(
                        Icons.delete_forever,
                        size: 30,
                        color: Colors.red[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
