import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:flutter/cupertino.dart';

import '../../generated/l10n.dart';
class GSTReturnAmount extends StatefulWidget {
  const GSTReturnAmount({super.key});

  @override
  State<GSTReturnAmount> createState() => _GSTReturnAmountState();
}

class _GSTReturnAmountState extends State<GSTReturnAmount> {
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        content: CustomBody(
          title: S.of(context).returnGstAmount,
          content: const Column(
            children: [

            ],
          ),
        )
    );
  }
}
