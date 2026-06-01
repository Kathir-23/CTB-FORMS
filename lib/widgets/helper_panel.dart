import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum LicenseType { basic, state, central }

class HelperPanel extends StatelessWidget {
  final LicenseType licenseType;

  const HelperPanel({super.key, required this.licenseType});

  List<String> get _documents {
    switch (licenseType) {
      case LicenseType.basic:
        return [
          'Aadhaar Card',
          'PAN Card',
          'Photograph of Proprietor',
          'Company register certificate',
          'Property Document',
          'Electricity Bill',
          'Property Tax Receipt',
        ];
      case LicenseType.state:
        return [
          'Partner-Specific Document',
          'Business information',
          'Aadhar Card',
          'Company register certificate',
          'PAN Card',
          'Company PAN Card',
          'Photograph',
          'Company Seal',
          'Property Document',
        ];
      case LicenseType.central:
        return [
          'Company information',
          'Director information',
          'Contact Details',
          'Business Details',
          'Property Document',
          'Electricity Bill',
          'Property Tax Receipt',
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDocumentsChecklist(),
          const SizedBox(height: 24),
          _buildTimeline(),
          const SizedBox(height: 24),
          _buildProcessingTime(),
        ],
      ),
    );
  }

  Widget _buildDocumentsChecklist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.notifications_outlined, color: AppColors.brandBlue, size: 18),
            const SizedBox(width: 8),
            const Text(
              'Documents Checklist',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1F2E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: const Color(0xFFF1F5F9)),
        const SizedBox(height: 14),
        ..._documents.map((doc) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.brandBlue.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: AppColors.brandBlue, size: 10),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  doc,
                  style: const TextStyle(
                    color: Color(0xFF334155),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_forward, color: AppColors.brandBlue, size: 18),
            const SizedBox(width: 8),
            const Text(
              'Process Timeline',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1F2E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: const Color(0xFFF1F5F9)),
        const SizedBox(height: 14),
        _buildTimelineStep('1', 'Submit Application', 'Fill and submit the application form', true),
        _buildTimelineStep('2', 'Document Verification', '3\u20135 working days', true),
        _buildTimelineStep('3', 'License Issued', 'Final approval and certificate', false),
      ],
    );
  }

  Widget _buildTimelineStep(String number, String title, String desc, bool showLine) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.brandBlue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 28,
                color: const Color(0xFFE2E8F0),
              ),
          ],
        ),
        const SizedBox(width: 10),
        Padding(
          padding: EdgeInsets.only(bottom: showLine ? 12 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1A1F2E),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(
                  color: AppColors.textSecondary.withAlpha(180),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProcessingTime() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.infoBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.infoBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF0EA5E9), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Estimated: 7\u201330 working days depending on completeness',
              style: TextStyle(
                color: const Color(0xFF0369A1),
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
