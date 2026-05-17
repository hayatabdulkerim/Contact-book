import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact/contact_bloc.dart';
import '../bloc/contact/contact_event.dart';
import '../bloc/contact/contact_state.dart';
import '../core/utils/helpers.dart';
import '../models/contact_model.dart';

class ContactDetailScreen extends StatelessWidget {
  final ContactModel contact;

  const ContactDetailScreen({
    super.key,
    required this.contact,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete ${contact.name}?'),
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
              context.read<ContactBloc>().add(DeleteContact(contact.id!));
              Navigator.pop(context, true);
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
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact Details'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/edit-contact',
                  arguments: contact,
                ).then((result) {
                  if (result == true) {
                    Navigator.pop(context, true);
                  }
                });
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => _showDeleteDialog(context),
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Hero(
                tag: 'avatar_${contact.id}',
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  backgroundImage:
                      contact.avatar != null && contact.avatar!.isNotEmpty
                          ? NetworkImage(contact.avatar!)
                          : null,
                  child: contact.avatar == null || contact.avatar!.isEmpty
                      ? Text(
                          Helpers.getInitials(contact.name),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        context,
                        Icons.person,
                        'Name',
                        contact.name,
                      ),
                      const Divider(height: 24),
                      _buildInfoRow(
                        context,
                        Icons.email,
                        'Email',
                        contact.email,
                      ),
                      const Divider(height: 24),
                      _buildInfoRow(
                        context,
                        Icons.phone,
                        'Phone',
                        contact.phone,
                      ),
                      const Divider(height: 24),
                      _buildInfoRow(
                        context,
                        contact.isFavorite ? Icons.star : Icons.star_border,
                        'Favorite',
                        contact.isFavorite ? 'Yes' : 'No',
                        valueColor: contact.isFavorite ? Colors.amber : null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: valueColor ?? Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: valueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
