import 'package:flutter/material.dart';
import 'package:test_project/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Sharing",
      content: "You Cannot share an empty note!",
      optionBuilder: () => {
            "OK": null,
          });
}
