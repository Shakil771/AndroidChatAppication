import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Models/ChatModel.dart';

class IndividualChatPage extends StatefulWidget {
  const IndividualChatPage({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<IndividualChatPage> createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
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
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          title: InkWell(
            onTap: () {},
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  child: SvgPicture.asset(
                    widget.chatModel.icon,
                    color: Colors.white,
                    height: 25,
                    width: 25,
                  ),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name.length > 15
                          ? '${widget.chatModel.name.substring(0, 12)}...'
                          : widget.chatModel.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Online",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_call, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(), // Placeholder for chat messages
            ),

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
                        Positioned(
                          left: 0,
                          bottom: 3,
                          child: IconButton(
                            icon: Icon(
                              showEmojiPicker
                                  ? Icons.keyboard
                                  : Icons.emoji_emotions_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: toggleEmojiPicker,
                          ),
                        ),
                        Positioned(
                          right: 45,
                          bottom: 3,
                          child: Row(
                            children: [
                              IconButton(     // Attachment Button
                                icon: const Icon(
                                  Icons.attach_file,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) => bottomSheet());
                                },
                              ),
                              if (!hasText) ...[
                                IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 2),
                              ],
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          right: 2,
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            radius: 20,
                            child: IconButton(
                              icon: Icon(
                                hasText ? Icons.send : Icons.mic,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (hasText) {
                                  _controller.clear();
                                } else {}
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Emoji Picker Section
            if (showEmojiPicker) buildEmojiPicker()
          ],
        ),
      ),
    );
  }
}
