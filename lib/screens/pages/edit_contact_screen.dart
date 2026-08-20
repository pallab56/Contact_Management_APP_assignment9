// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:assignment9/db/db_handler.dart';
import 'package:assignment9/model/contact_model.dart';
import 'package:assignment9/screens/widgets/custom_button.dart';
import 'package:assignment9/screens/widgets/custom_text_field.dart';

class EditContactScreen extends StatefulWidget {
  final ContactModel contact;
  const EditContactScreen({super.key, required this.contact});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DbHandler dbInstance = DbHandler.instance;
  bool isEdited = false;
  bool wantToFavourite = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.contact.name;
    phoneController.text = widget.contact.number;
    emailController.text = widget.contact.email;
    addressController.text = widget.contact.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Contact'),
        actions: [
          isEdited
              ? CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.check, color: Colors.white, size: 18),
                )
              : Icon(Icons.edit_square),
          SizedBox(width: 10),
        ],
      ),
      body: _bodyUi(context),
    );
  }

  Widget _bodyUi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * .06),
          CircleAvatar(
            radius: 40,
            child: Icon(
              Icons.camera_alt,
              size: 32,
              color: Colors.blueAccent.shade700,
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .03),
          _addContactForm(context),
        ],
      ),
    );
  }

  Widget _addContactForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Name',
            controller: nameController,
            icon: Icon(Icons.person_outline_outlined),
          ),

          CustomTextField(
            label: 'Phone Number',
            controller: phoneController,
            icon: Icon(Icons.call),
          ),

          CustomTextField(
            label: 'Email',
            controller: emailController,
            icon: Icon(Icons.mail_outline_outlined),
          ),

          CustomTextField(
            label: 'Address',
            controller: addressController,
            icon: Icon(Icons.location_on),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Do you want it to be favourite',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              SizedBox(width: 5),
              Checkbox(
                value: wantToFavourite,
                onChanged: (onChanged) {
                  wantToFavourite = onChanged!;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          CustomButton(
            isEdit: isEdited,
            title: 'Edit Contact',
            ontap: () async {
              if (_formKey.currentState!.validate()) {
                final updateContacts = widget.contact.copyWith(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  number: phoneController.text.trim(),
                  address: addressController.text.trim(),
                  isFavorite: wantToFavourite ? 1 : 0,
                  id: widget.contact.id,
                );

                await dbInstance.updateContacts(updateContacts);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.contact.id} Edited SuccessFully'),
                  ),
                );

                setState(() {
                  isEdited = true;
                });
                if (mounted) Navigator.pop(context, updateContacts);
              }
            },
          ),
        ],
      ),
    );
  }
}
