import 'package:flutter/material.dart';

class SenderMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 5),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75, // 75% width max
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffdcf8c6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16), // Space for time & ticks
                  child: Text(
                    "Nello Dear, How are you? Nello Dear, How are you? "
                        "Nello Dear, How are you?",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // Time & Double Tick Aligned Bottom-Right
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "9:56",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.done_all, size: 16, color: Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
