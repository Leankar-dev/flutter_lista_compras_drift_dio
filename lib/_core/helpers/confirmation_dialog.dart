import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String content,
  String? title,
  String confirmButtonText = 'Confirmar',
  String cancelButtonText = 'Cancelar',
  Color? confirmButtonColor,
  Color? cancelButtonColor,
  IconData? icon,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null
            ? Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 24),
                    const SizedBox(width: 8),
                  ],
                  Expanded(child: Text(title)),
                ],
              )
            : null,
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            style: TextButton.styleFrom(foregroundColor: cancelButtonColor),
            child: Text(cancelButtonText),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmButtonColor,
            ),
            child: Text(confirmButtonText),
          ),
        ],
      );
    },
  );
}
