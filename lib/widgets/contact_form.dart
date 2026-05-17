import 'package:flutter/material.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_textfield.dart';
import '../core/utils/validators.dart';
import '../models/contact_model.dart';

class ContactForm extends StatefulWidget {
  final ContactModel? contact;
  final Function(ContactModel) onSubmit;
  final bool isLoading;

  const ContactForm({
    super.key,
    this.contact,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _avatarController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _avatarController =
        TextEditingController(text: widget.contact?.avatar ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final contact = ContactModel(
        id: widget.contact?.id,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        avatar: _avatarController.text.trim().isEmpty
            ? null
            : _avatarController.text.trim(),
        isFavorite: widget.contact?.isFavorite ?? false,
      );
      widget.onSubmit(contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Name',
            hint: 'Enter contact name',
            controller: _nameController,
            validator: Validators.validateName,
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Email',
            hint: 'Enter email address',
            controller: _emailController,
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Phone',
            hint: 'Enter phone number',
            controller: _phoneController,
            validator: Validators.validatePhone,
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Avatar URL (Optional)',
            hint: 'Enter avatar image URL',
            controller: _avatarController,
            prefixIcon: Icons.image,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: widget.contact != null ? 'Update Contact' : 'Add Contact',
            onPressed: _submitForm,
            isLoading: widget.isLoading,
            icon: widget.contact != null ? Icons.save : Icons.add,
          ),
        ],
      ),
    );
  }
}
