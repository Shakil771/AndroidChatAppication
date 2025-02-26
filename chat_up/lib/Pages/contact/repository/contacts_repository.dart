import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_up/core/model/user_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsRepositoryProvider = Provider((ref){
  return ContactsRepository(firestore: FirebaseFirestore.instance);
});
class ContactsRepository {
  final FirebaseFirestore firestore;
  ContactsRepository({required this.firestore});

  Future<List<List<UserModel>>> getAllContacts() async {
    List<UserModel> firebaseContacts = [];
    List<UserModel> phoneContacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection("users").get();
        final allContactsInThePhone =
        await FlutterContacts.getContacts(withProperties: true);

        for (var contact in allContactsInThePhone) {
          if (contact.phones.isEmpty) continue; // Skip contacts without phone numbers
          String phoneNumber = contact.phones[0].number.replaceAll(' ', '');

          bool isContactFound = false;
          for (var firebaseContactData in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(firebaseContactData.data());
            if (phoneNumber == firebaseContact.phoneNumber) {
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
          }

          if (!isContactFound) {
            phoneContacts.add(UserModel(
              userName: contact.displayName,
              uid: '',
              active: false,
              lastSeen: 0,
              phoneNumber: phoneNumber,
              groupId: [],
            ));
          }
        }
      }
    } catch (e) {
      print('Error fetching contacts: $e');
    }

    return [firebaseContacts, phoneContacts];
  }
}
