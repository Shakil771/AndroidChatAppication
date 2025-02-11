class ChatModel{
  late String name;
  late String icon;
  late String time;
  late String currentMessage;
  late bool isGroup;
  late bool select;
  ChatModel({required this.name, required this.icon, required this.currentMessage, required this.isGroup, required this.time, this.select=false});

}