import 'package:flutter/material.dart';

class PublishListItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String action;
  const PublishListItem({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 16,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            '$title:',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            description,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            action,
            textAlign: TextAlign.start,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
