import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Deal Detail Widget

class DealDetailWidget extends StatelessWidget {
  final Deal item;
  const DealDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
    _row('Agent Id', item.agentId?.toString() ?? 'N/A', Icons.link),
    _row('Appraisal Contingency', (item.appraisalContingency == true ? 'Yes' : 'No'), Icons.toggle_on),
    _row('Attorney Review', (item.attorneyReview == true ? 'Yes' : 'No'), Icons.toggle_on),
    _row('Buyer Credits', item.buyerCredits?.toString() ?? 'N/A', Icons.numbers),
    _row('Client Id', item.clientId?.toString() ?? 'N/A', Icons.link),
    _row('Closing Costs', item.closingCosts?.toString() ?? 'N/A', Icons.attach_money),
    _row('Closing Date', _fmt(item.closingDate), Icons.calendar_today),
    _row('Commission Amount', item.commissionAmount?.toString() ?? 'N/A', Icons.attach_money),
    _row('Commission Rate', item.commissionRate?.toString() ?? 'N/A', Icons.attach_money),
    _row('Deal Type', item.dealType?.toString() ?? 'N/A', Icons.info_outline),
    _row('Down Payment', item.downPayment?.toString() ?? 'N/A', Icons.attach_money),
    _row('Earnest Money', item.earnestMoney?.toString() ?? 'N/A', Icons.attach_money),
    _row('Escrow Amount', item.escrowAmount?.toString() ?? 'N/A', Icons.attach_money),
    _row('Financing Contingency', (item.financingContingency == true ? 'Yes' : 'No'), Icons.toggle_on),
    _row('Financing Type', item.financingType?.toString() ?? 'N/A', Icons.info_outline),
    _row('Inspection Period', item.inspectionPeriod?.toString() ?? 'N/A', Icons.numbers),
    _row('List Price', item.listPrice?.toString() ?? 'N/A', Icons.attach_money),
    _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
    _row('Loan Amount', item.loanAmount?.toString() ?? 'N/A', Icons.attach_money),
    _row('Location Id', item.locationId?.toString() ?? 'N/A', Icons.link),
    _row('Multiple Offers', (item.multipleOffers == true ? 'Yes' : 'No'), Icons.toggle_on),
    _row('Offer Price', item.offerPrice?.toString() ?? 'N/A', Icons.attach_money),
    _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
    _row('Sale Price', item.salePrice?.toString() ?? 'N/A', Icons.attach_money),
    _row('Seller Concessions', item.sellerConcessions?.toString() ?? 'N/A', Icons.numbers),
    _row('Title Contingency', (item.titleContingency == true ? 'Yes' : 'No'), Icons.person),
    _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
    _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
      ]),
    );
  }
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value, style: const TextStyle(fontSize: 14)),
    ])),
  ]),
);

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}
