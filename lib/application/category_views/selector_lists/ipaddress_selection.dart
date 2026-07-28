import 'package:flutter/material.dart';
import 'package:gc_wizard/application/tools/widget/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/ip_address/widget/ip_address.dart';
import 'package:gc_wizard/tools/science_and_technology/ip_address/widget/ip_address_minimumsubnet.dart';

class IPAddressSelection extends GCWSelection {
  const IPAddressSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final _toolList = filterTools(const {
        IPAddress,
        IPAddressMinimumSubnet
       });

    return GCWToolList(toolList: _toolList);
  }
}
