import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact/contact_bloc.dart';
import '../bloc/contact/contact_event.dart';
import '../bloc/contact/contact_state.dart';
import '../core/widgets/loading_widget.dart';
import '../widgets/contact_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/empty_contacts_widget.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(LoadContacts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showDeleteDialog(BuildContext context, String id, String name) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete $name?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ContactBloc>().add(DeleteContact(id));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: (query) {
              context.read<ContactBloc>().add(SearchContacts(query));
            },
          ),
          Expanded(
            child: BlocConsumer<ContactBloc, ContactState>(
              listener: (context, state) {
                if (state is ContactOperationSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else if (state is ContactError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ContactLoading) {
                  return const LoadingWidget(message: 'Loading contacts...');
                } else if (state is ContactsLoaded) {
                  final contacts = state.filteredContacts;
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return Dismissible(
                        key: Key(contact.id ?? index.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          _showDeleteDialog(
                            context,
                            contact.id!,
                            contact.name,
                          );
                          return false;
                        },
                        child: ContactCard(
                          contact: contact,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/contact-detail',
                              arguments: contact,
                            );
                          },
                          onFavoriteToggle: () {
                            context.read<ContactBloc>().add(
                                  ToggleFavorite(
                                    contact.id!,
                                    !contact.isFavorite,
                                  ),
                                );
                          },
                        ),
                      );
                    },
                  );
                } else if (state is ContactEmpty) {
                  return EmptyContactsWidget(
                    message: _searchController.text.isNotEmpty
                        ? 'No contacts match your search'
                        : null,
                  );
                } else if (state is ContactError) {
                  return EmptyContactsWidget(
                    message: 'Error: ${state.message}',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add-contact');
          if (result == true) {
            context.read<ContactBloc>().add(LoadContacts());
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Contact'),
      ),
    );
  }
}
