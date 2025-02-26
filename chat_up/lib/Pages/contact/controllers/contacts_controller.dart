import 'package:chat_up/Pages/contact/repository/contacts_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactControllerProvider = FutureProvider((ref) async {
  final contactRepository = ref.watch(contactsRepositoryProvider);
  return await contactRepository.getAllContacts();
});
