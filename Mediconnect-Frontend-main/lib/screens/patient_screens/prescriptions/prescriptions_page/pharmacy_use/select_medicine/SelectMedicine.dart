import 'package:flutter/material.dart';
import 'view/SelectMedicineScaffold.dart';

class SelectMedicinePage extends StatelessWidget {
  final Map<String, dynamic> prescription;

  const SelectMedicinePage({Key? key, required this.prescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectMedicineScaffold(prescription: prescription);
  }
}
