import 'package:chat_up/Custom%20UI/ReceiverMessageCard.dart';
import 'package:chat_up/Custom%20UI/SenderMassageCard.dart';
import 'package:chat_up/core/model/user_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.user,});
  final UserModel user;

  // final TextEditingController _controller = TextEditingController();
  // bool hasText = false;
  // bool showEmojiPicker = false; // Track emoji picker visibility
  // FocusNode focusNode = FocusNode();


  //
  // void toggleEmojiPicker() {
  //   setState(() {
  //     showEmojiPicker = !showEmojiPicker;
  //     if (!showEmojiPicker) {
  //       focusNode.requestFocus();
  //     } else {
  //       focusNode.unfocus();
  //     }
  //   });
  // }
  //
  // Future<bool> onBackPressed() async {
  //   if (showEmojiPicker) {
  //     setState(() {
  //       showEmojiPicker = false;
  //     });
  //     return Future.value(false); // Prevents the page from popping
  //   } else {
  //     return Future.value(true); // Allows the page to pop
  //   }
  // }
  //
  // Widget buildEmojiPicker() {
  //   return SizedBox(
  //     height: 250,
  //     child: EmojiPicker(
  //       onEmojiSelected: (category, emoji) {
  //         setState(() {
  //           _controller.text += emoji.emoji;
  //           hasText = _controller.text.trim().isNotEmpty;
  //         });
  //       },
  //
  //       onBackspacePressed: () {
  //         setState(() {
  //           if (_controller.text.isNotEmpty) {
  //             _controller.value = _controller.value.copyWith(
  //               text: _controller.text.characters.skipLast(1).toString(),
  //             );
  //             hasText = _controller.text.trim().isNotEmpty;
  //           }
  //         });
  //       },
  //       config: const Config(
  //         emojiViewConfig: EmojiViewConfig(
  //           emojiSizeMax: 28,
  //         ),
  //         viewOrderConfig: ViewOrderConfig(
  //           top: EmojiPickerItem.searchBar,
  //           middle: EmojiPickerItem.emojiView,
  //           bottom: EmojiPickerItem.categoryBar,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // // Widget bottomSheet() {
  // //   return Stack(
  // //     children: [
  // //       // 👇 Click korle hide korar jonne GestureDetector use kora holo
  // //       GestureDetector(
  // //         onTap: () => Navigator.pop(context), // Click outside to close
  // //         child: Container(
  // //           color: Colors.transparent, // Transparent area clickable
  // //           height: MediaQuery.of(context).size.height,
  // //         ),
  // //       ),
  // //
  // //       Positioned(
  // //         bottom: 60, // Moves it 60px above the bottom
  // //         left: 0,
  // //         right: 0,
  // //         child: SizedBox(
  // //           height: 220,
  // //           width: MediaQuery.of(context).size.width,
  // //           child: Card(
  // //             color: Colors.transparent,
  // //             margin: const EdgeInsets.all(16),
  // //             child: Column(
  // //               mainAxisAlignment: MainAxisAlignment.start,
  // //               children: [
  // //                 Padding(
  // //                   padding: const EdgeInsets.all(15.0),
  // //                   child: Row(
  // //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  // //                     children: [
  // //                       iconCreation(Icons.photo_library_sharp, Colors.indigoAccent, "Gallery"),
  // //                       iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
  // //                       iconCreation(Icons.insert_drive_file, Colors.purple, "Document"),
  // //                     ],
  // //                   ),
  // //                 ),
  // //                 Padding(
  // //                   padding: const EdgeInsets.all(15.0),
  // //                   child: Row(
  // //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  // //                     children: [
  // //                       iconCreation(Icons.headphones, Colors.deepOrange, "Audio"),
  // //                       iconCreation(Icons.location_on, Colors.teal, "Location"),
  // //                       iconCreation(Icons.person, Colors.blue, "Contact"),
  // //                     ],
  // //                   ),
  // //                 )
  // //
  // //               ],
  // //             ),
  // //           ),
  // //         ),
  // //       ),
  // //     ],
  // //   );
  // // }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                  "assets/Icons/person.svg",
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
                    user.userName.length > 15
                        ? '${user.userName.substring(0, 12)}...'
                        : user.userName,
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
            icon: const Icon(Icons.video_call, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }

  void setState(Null Function() param0) {}
}
