import 'package:flutter/material.dart';
import 'package:frontend/features/leads/models/lead_model.dart';
import 'package:frontend/shared/widgets/icon_container.dart';
import 'package:intl/intl.dart';

class PrimaryInfo extends StatelessWidget {
  final LeadModel lead;

  const PrimaryInfo({
    required this.lead,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildHeader(),

        const SizedBox(height: 20),
        const Divider(color: Colors.black, height: 40, thickness: 1),
        const SizedBox(height: 20),

        _buildInfo(),
        ],
      ),
    );
  }


Widget _buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lead.leadName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, size: 16),
                const SizedBox(width: 7),
                Text(
                  lead.email!,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 7),

                Container(width: 1, height: 16, color: Colors.grey.shade300),

                const SizedBox(width: 18),
                const Icon(Icons.phone, size: 16),
                Text(
                  lead.phoneNumber!,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),

      OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.edit, size: 16),
        label: const Text("Edit Lead"),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
      const SizedBox(width: 12),

      OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.edit, size: 16),
        label: const Text("Edit Status"),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    ],
  );
}

Widget _buildInfo() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //column 1
      Expanded(
        child: Column(
          children: [
            _buildInfoItems(
              icon: Icons.campaign_outlined,
              label: "Lead Source",
              value: "Facebook ",
              iconColor: Colors.blue,
              iconBackground: Colors.white,
            ),
            const SizedBox(height: 22),
            _buildInfoItems(
              icon: Icons.local_offer_outlined,
              label: "Lead Status",
              value: lead.status,
              iconColor: Colors.green,
              iconBackground: Colors.grey,
            ),
          ],
        ),
      ),

      _buildVerticalDivider(),

      //column 2
      Expanded(
        child: Column(
          children: [
            _buildInfoItems(
              icon: Icons.folder_outlined,
              label: "Campaign",
              value: lead.campaignName!,
              iconColor: Colors.yellow,
              iconBackground: Colors.grey,
            ),
            const SizedBox(height: 22),
            _buildInfoItems(
              icon: Icons.update_outlined,
              label: "last updated",
              value: lead.updatedOn != null
              ?DateFormat("dd MM yyyy").format(lead.updatedOn!)
              :"Not updated",
              iconColor: Colors.orange,
              iconBackground: Colors.grey,
            ),
          ],
        ),
      ),

      _buildVerticalDivider(),

      //column 3
      Expanded(
        child: Column(
          children: [
            _buildInfoItems(
              icon: Icons.person_outlined,
              label: "Assigned To",
              value: lead.employeeName!,
              iconColor: Colors.purple,
              iconBackground: Colors.grey,
            ),
            const SizedBox(height: 22),

            _buildInfoItems(
              icon: Icons.star_outline,
              label: "Interested Service",
              value: lead.service!,
              iconColor: Colors.indigoAccent,
              iconBackground: Colors.grey,
            ),
          ],
        ),
      ),

      _buildVerticalDivider(),
      Expanded(
        child: Column(
          children: [
            _buildInfoItems(
              icon: Icons.calendar_today_outlined,
              label: "Created On",
              value: DateFormat("dd MM yyyy").format(lead.addedOn),
              iconColor: Colors.greenAccent,
              iconBackground: Colors.grey,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildInfoItems({
  required IconData icon,
  required String label,
  required String value,
  required Color iconColor,
  required Color iconBackground,
  bool showStatusDot = false,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconContainer(icon: icon, color: iconColor),
      const SizedBox(width: 12),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 89, 84, 84),
              ),
            ),
            const SizedBox(height: 4),

            Row(
              children: [
                if (showStatusDot) ...[
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildVerticalDivider() {
  return Container(
    width: 1,
    height: 130,
    margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 3),
    color: Colors.grey.shade500,
  );
}

}
