import '../models/contact_model.dart';
import '../services/contact_service.dart';

class ContactRepository {
  final ContactService _contactService = ContactService();

  Future<List<ContactModel>> getContacts() async {
    return await _contactService.getContacts();
  }

  Future<ContactModel> getContactById(String id) async {
    return await _contactService.getContactById(id);
  }

  Future<ContactModel> addContact(ContactModel contact) async {
    return await _contactService.addContact(contact);
  }

  Future<ContactModel> updateContact(String id, ContactModel contact) async {
    return await _contactService.updateContact(id, contact);
  }

  Future<void> deleteContact(String id) async {
    return await _contactService.deleteContact(id);
  }
}