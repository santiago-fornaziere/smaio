import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetVeiAnoExpansionTitle extends StatelessWidget {
  BuildContext context;
  WidgetVeiAnoExpansionTitle({
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      children: lista(),
    );
  }

  List<ExpansionPanel> lista() {
    List<ExpansionPanel> panels = [];
    return panels;
  }
}
