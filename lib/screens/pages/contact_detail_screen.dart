// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment9/screens/pages/edit_contact_screen.dart';
import 'package:assignment9/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:assignment9/model/contact_model.dart';

class ContactDetailScreen extends StatefulWidget {
  final ContactModel contact;
  const ContactDetailScreen({super.key, required this.contact});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: _bodyUi(context));
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text('ConatactDetail'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditContactScreen(contact: widget.contact),
              ),
            );
          },
          icon: Icon(Icons.edit_outlined),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.delete_outlined)),
      ],
    );
  }

  Widget _bodyUi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _headerSection(context),
          SizedBox(height: 20),
          _cardSection(context),
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final data = widget.contact;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * .06),
        Center(
          child: CircleAvatar(
            backgroundColor: Utils.getAvatarColor(data.name, context),
            radius: 40,
            child: Text(
              Utils.getNameInitials(data.name),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * .02),
        Text(
          data.name,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _cardSection(BuildContext context) {
    final data = widget.contact;
    return Card(
      color: Colors.white,

      child: Container(
        height: MediaQuery.sizeOf(context).height * .28,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ListTile(
              title: Text(
                data.number,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Mobile', style: TextStyle(fontSize: 16)),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.phone_outlined),
              ),
            ),

            ListTile(
              title: Text(
                data.email,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Email', style: TextStyle(fontSize: 16)),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.email_outlined),
              ),
            ),

            ListTile(
              title: Text(
                data.address,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Address', style: TextStyle(fontSize: 16)),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.location_on),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
