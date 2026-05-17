import 'package:equatable/equatable.dart';
import '../../models/contact_model.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactsLoaded extends ContactState {
  final List<ContactModel> contacts;
  final List<ContactModel> filteredContacts;
  final String searchQuery;

  const ContactsLoaded({
    required this.contacts,
    List<ContactModel>? filteredContacts,
    this.searchQuery = '',
  }) : filteredContacts = filteredContacts ?? contacts;

  @override
  List<Object?> get props => [contacts, filteredContacts, searchQuery];
}

class ContactDetailLoaded extends ContactState {
  final ContactModel contact;

  const ContactDetailLoaded(this.contact);

  @override
  List<Object?> get props => [contact];
}

class ContactEmpty extends ContactState {}

class ContactError extends ContactState {
  final String message;

  const ContactError(this.message);

  @override
  List<Object?> get props => [message];
}

class ContactOperationSuccess extends ContactState {
  final String message;

  const ContactOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
