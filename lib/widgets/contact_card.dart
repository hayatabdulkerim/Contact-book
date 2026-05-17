import 'package:flutter/material.dart';
import '../core/utils/helpers.dart';
import '../models/contact_model.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
                          fontSize: 20,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contact.email,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contact.phone,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (onFavoriteToggle != null)
                IconButton(
                  onPressed: onFavoriteToggle,
                  icon: Icon(
                    contact.isFavorite ? Icons.star : Icons.star_border,
                    color: contact.isFavorite ? Colors.amber : Colors.grey,
                  ),
                ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
