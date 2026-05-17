import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/contact_model.dart';
import '../../repositories/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository = ContactRepository();
  List<ContactModel> _allContacts = [];

  ContactBloc() : super(ContactInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<UpdateContact>(_onUpdateContact);
    on<DeleteContact>(_onDeleteContact);
    on<ToggleFavorite>(_onToggleFavorite);
    on<SearchContacts>(_onSearchContacts);
    on<LoadContactDetail>(_onLoadContactDetail);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactLoading());
    try {
      _allContacts = await _contactRepository.getContacts();
      if (_allContacts.isEmpty) {
        emit(ContactEmpty());
      } else {
        emit(ContactsLoaded(contacts: _allContacts));
      }
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onAddContact(
    AddContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactLoading());
    try {
      await _contactRepository.addContact(event.contact);
      _allContacts = await _contactRepository.getContacts();
      emit(ContactOperationSuccess('Contact added successfully'));
      emit(ContactsLoaded(contacts: _allContacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onUpdateContact(
    UpdateContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactLoading());
    try {
      await _contactRepository.updateContact(event.id, event.contact);
      _allContacts = await _contactRepository.getContacts();
      emit(ContactOperationSuccess('Contact updated successfully'));
      emit(ContactsLoaded(contacts: _allContacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onDeleteContact(
    DeleteContact event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactLoading());
    try {
      await _contactRepository.deleteContact(event.id);
      _allContacts = await _contactRepository.getContacts();
      if (_allContacts.isEmpty) {
        emit(ContactEmpty());
      } else {
        emit(ContactOperationSuccess('Contact deleted successfully'));
        emit(ContactsLoaded(contacts: _allContacts));
      }
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<ContactState> emit,
  ) async {
    try {
      final contact = _allContacts.firstWhere((c) => c.id == event.id);
      final updatedContact = contact.copyWith(isFavorite: event.isFavorite);
      await _contactRepository.updateContact(event.id, updatedContact);
      _allContacts = await _contactRepository.getContacts();
      emit(ContactsLoaded(contacts: _allContacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  void _onSearchContacts(
    SearchContacts event,
    Emitter<ContactState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(ContactsLoaded(contacts: _allContacts));
    } else {
      final filtered = _allContacts.where((contact) {
        return contact.name.toLowerCase().contains(event.query.toLowerCase()) ||
            contact.email.toLowerCase().contains(event.query.toLowerCase()) ||
            contact.phone.contains(event.query);
      }).toList();

      if (filtered.isEmpty) {
        emit(ContactEmpty());
      } else {
        emit(ContactsLoaded(
          contacts: _allContacts,
          filteredContacts: filtered,
          searchQuery: event.query,
        ));
      }
    }
  }

  Future<void> _onLoadContactDetail(
    LoadContactDetail event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactLoading());
    try {
      final contact = await _contactRepository.getContactById(event.id);
      emit(ContactDetailLoaded(contact));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
