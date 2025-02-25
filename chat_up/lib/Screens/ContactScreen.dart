import 'package:chat_up/core/theme/Colors.dart';
import 'package:chat_up/core/theme/CustomThemeExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Pages/contact/controllers/contacts_controller.dart';
import '../Pages/contact/widgets/contact_card.dart';
import '../core/model/user_model.dart';
import '../routes/Routes.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});
  shareSmsLink(phoneNumber) async {
    Uri sms = Uri.parse(
        "sms:${phoneNumber}?body=Let's chat on ChatUp! it's a fast, simple and secure app we cal call each other for free. Get it at https://chatup.com/dl");
    if (await launchUrl(sms)) {
      await launchUrl(sms, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch SMS");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            ref.watch(contactControllerProvider).when(data: (allContacts) {
              return Text(
                "${allContacts[0].length} Contacts",
                style: TextStyle(fontSize: 14, color: Colors.white),
              );
            }, error: (e, t) {
              return SizedBox();
            }, loading: () {
              return Text(
                "counting...",
                style: TextStyle(fontSize: 14, color: Colors.white),
              );
            }),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: ref.watch(contactControllerProvider).when(
        data: (allContacts) {
          if (allContacts[0].isEmpty && allContacts[1].isEmpty) {
            return Center(
              child: Text(
                'No contacts found.',
                style: TextStyle(color: context.theme?.greyColor),
              ),
            );
          }

          return ListView.builder(
            itemCount: allContacts[0].length + allContacts[1].length,
            itemBuilder: (context, index) {
              late UserModel firebaseContacts;
              late UserModel phoneContacts;
              if (index < allContacts[0].length) {
                firebaseContacts = allContacts[0][index];
              } else {
                phoneContacts = allContacts[1][index - allContacts[0].length];
              }
              return index < allContacts[0].length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myListTile(leading: Icons.group_add, text: "New Group",),
                              myListTile(leading: Icons.person_add_alt, text: "New Contact", trailing: Icons.qr_code),
                              myListTile(leading: Icons.groups, text: "New Community",),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 10,
                                ),
                                child: Text(
                                  "Contacts on ChatUp",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme?.greyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ContactCard(
                          contactSource: firebaseContacts,
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.chat, arguments: firebaseContacts);
                          },
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == allContacts[0].length)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 10,
                            ),
                            child: Text(
                              "Contacts on ChatUp",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: context.theme?.greyColor,
                              ),
                            ),
                          ),
                        ContactCard(
                          contactSource: phoneContacts,
                          onTap: () => shareSmsLink(phoneContacts.phoneNumber),
                        )
                      ],
                    );
            },
          );
        },
        error: (e, t) {
          return Center(
            child: Text(
              'Error: $e',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

ListTile myListTile({
  required IconData leading,
  required String text,
  IconData? trailing,
}) {
  return ListTile(
    contentPadding: EdgeInsets.only(top: 0, left: 20, right: 10),
    leading: CircleAvatar(
      radius: 20,
      backgroundColor: Coloors.greenDark,
      child: Icon(
        leading,
        color: Colors.white,
      ),
    ),
    title: Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    trailing:  Icon(
      trailing,
      color: Coloors.greyDark,
    ),
  );
}
