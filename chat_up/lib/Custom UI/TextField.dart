import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class Texteditor extends StatefulWidget {
  const Texteditor({super.key});

  @override
  State<Texteditor> createState() => _TexteditorState();
}

class _TexteditorState extends State<Texteditor> {
  final TextEditingController _controller = TextEditingController();
  bool hasText = false;
  bool showEmojiPicker = false; // Track emoji picker visibility
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  void toggleEmojiPicker() {
    setState(() {
      showEmojiPicker = !showEmojiPicker;
      if (!showEmojiPicker) {
        focusNode.requestFocus();
      } else {
        focusNode.unfocus();
      }
    });
  }

  Future<bool> onBackPressed() async {
    if (showEmojiPicker) {
      setState(() {
        showEmojiPicker = false;
      });
      return Future.value(false); // Prevents the page from popping
    } else {
      return Future.value(true); // Allows the page to pop
    }
  }

  Widget buildEmojiPicker() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          setState(() {
            _controller.text += emoji.emoji;
            hasText = _controller.text.trim().isNotEmpty;
          });
        },
        onBackspacePressed: () {
          setState(() {
            if (_controller.text.isNotEmpty) {
              _controller.value = _controller.value.copyWith(
                text: _controller.text.characters.skipLast(1).toString(),
              );
              hasText = _controller.text.trim().isNotEmpty;
            }
          });
        },
        config: const Config(
          emojiViewConfig: EmojiViewConfig(
            emojiSizeMax: 28,
          ),
          viewOrderConfig: ViewOrderConfig(
            top: EmojiPickerItem.searchBar,
            middle: EmojiPickerItem.emojiView,
            bottom: EmojiPickerItem.categoryBar,
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Stack(
      children: [
        // 👇 Click korle hide korar jonne GestureDetector use kora holo
        GestureDetector(
          onTap: () => Navigator.pop(context), // Click outside to close
          child: Container(
            color: Colors.transparent, // Transparent area clickable
            height: MediaQuery.of(context).size.height,
          ),
        ),

        Positioned(
          bottom: 60, // Moves it 60px above the bottom
          left: 0,
          right: 0,
          child: SizedBox(
            height: 220,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.transparent,
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        iconCreation(Icons.photo_library_sharp, Colors.indigoAccent, "Gallery"),
                        iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                        iconCreation(Icons.insert_drive_file, Colors.purple, "Document"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        iconCreation(Icons.headphones, Colors.deepOrange, "Audio"),
                        iconCreation(Icons.location_on, Colors.teal, "Location"),
                        iconCreation(Icons.person, Colors.blue, "Contact"),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget iconCreation(IconData icon, Color color, String text){
    return Column(
      children: [

        Container(
          width: 50, // Width of the border container
          height: 50, // Height of the border container
          decoration: BoxDecoration(
            color: Colors.transparent, // Background color of the border container
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blueGrey, // Border color
              width: 1.5, // Border width
            ),
          ),
          child: CircleAvatar(
            radius: 25, // Adjust radius to fit within the border container
            backgroundColor: Colors.transparent, // Background color of the avatar
            child: Icon(icon, size: 25, color: color,), // Example icon
          ),
        ),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 10),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Column(
        children: [
          // Input Field Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            // color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Background color
                          borderRadius:
                          BorderRadius.circular(25), // Rounded border
                          border: Border.all(
                              color: Colors.grey.shade300), // Border color
                        ),
                        padding: const EdgeInsets.only(left: 40, right: 80),
                        margin: const EdgeInsets.only(right: 45),
                        child: TextFormField(
                          focusNode: focusNode,
                          controller: _controller,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                          ),
                          onTap: () {
                            if (showEmojiPicker) {
                              setState(() {
                                showEmojiPicker =
                                false; // Hide emoji picker when typing
                              });
                            }
                          },
                        ),
                      ),
                      // Positioned(
                      //   left: 0,
                      //   bottom: 3,
                      //   child: IconButton(
                      //     icon: Icon(
                      //       showEmojiPicker
                      //           ? Icons.keyboard
                      //           : Icons.emoji_emotions_outlined,
                      //       color: Colors.grey,
                      //     ),
                      //     onPressed: toggleEmojiPicker,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Emoji Picker Section
          // if (showEmojiPicker) buildEmojiPicker()
        ],
      ),
    );
  }
}
