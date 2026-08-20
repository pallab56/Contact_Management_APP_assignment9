// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:assignment9/db/db_handler.dart';
import 'package:assignment9/model/contact_model.dart';
import 'package:assignment9/screens/pages/contact_detail_screen.dart';
import 'package:assignment9/utils/utils.dart';

class ContactTile extends StatefulWidget {
  final bool isCallFromFavourite;
  final ContactModel contact;
  final VoidCallback onTap;
  const ContactTile({
    super.key,
    this.isCallFromFavourite = false,
    required this.contact,
    required this.onTap
  });

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  late int _isFavourite;
  @override
  void initState() {
    super.initState();
    _isFavourite = widget.contact.isFavorite;
  }

  Future<void> _toggleFavourite() async {
    final newValue = _isFavourite == 0 ? 1 : 0;
    setState(() {
      _isFavourite = newValue;
    });
    final updateContact = widget.contact.copyWith(isFavorite: newValue);
    await DbHandler.instance.updateFavorite(updateContact);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.contact;
    return ListTile(
      title: Text(data.name),
      subtitle: Text(data.number),
      leading: CircleAvatar(
        backgroundColor: Utils.getAvatarColor(data.name, context),
        child: Text(
          Utils.getNameInitials(data.name),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _toggleFavourite,
            icon: _isFavourite == 1
                ? Icon(Icons.star, color: Colors.amber)
                : Icon(Icons.star_border_outlined),
          ),
          widget.isCallFromFavourite
              ? SizedBox()
              : IconButton(
                  onPressed: widget.onTap,
                  icon: Icon(Icons.navigate_next_outlined),
                ),
        ],
      ),
    );
  }
}
