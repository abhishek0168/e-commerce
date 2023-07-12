import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPress,
  });
  final String title;
  final String subtitle;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      title: Text(
        title,
        style: CustomeTextStyle.boldName,
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}