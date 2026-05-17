import 'package:equatable/equatable.dart';
import '../../models/contact_model.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}

class LoadContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final ContactModel contact;

  const AddContact(this.contact);

  @override
  List<Object?> get props => [contact];
}

class UpdateContact extends ContactEvent {
  final String id;
  final ContactModel contact;

  const UpdateContact(this.id, this.contact);

  @override
  List<Object?> get props => [id, contact];
}

class DeleteContact extends ContactEvent {
  final String id;

  const DeleteContact(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleFavorite extends ContactEvent {
  final String id;
  final bool isFavorite;

  const ToggleFavorite(this.id, this.isFavorite);

  @override
  List<Object?> get props => [id, isFavorite];
}

class SearchContacts extends ContactEvent {
  final String query;

  const SearchContacts(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadContactDetail extends ContactEvent {
  final String id;

  const LoadContactDetail(this.id);

  @override
  List<Object?> get props => [id];
}
