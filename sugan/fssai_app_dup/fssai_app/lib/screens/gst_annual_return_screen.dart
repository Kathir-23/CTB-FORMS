import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class GstAnnualReturnScreen extends StatefulWidget {
  const GstAnnualReturnScreen({super.key});

  @override
  State<GstAnnualReturnScreen> createState() => _GstAnnualReturnScreenState();
}

class _GstAnnualReturnScreenState extends State<GstAnnualReturnScreen> {
  int _selectedNavIndex = 10;
  bool _hoveringSubmit = false;
  String? _selectedFY;

  final List<String> _financialYears = [
    'FY 2024-25',
    'FY 2023-24',
    'FY 2022-23',
    'FY 2021-22',
    'FY 2020-21',
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 10
          ? _buildFormContent()
          : const Center(
              child: Text(
                'Not built yet',
                style: TextStyle(fontSize: 18, color: AppColors.textMuted),
              ),
            ),
    );
  }

  Widget _buildFormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GST Services > Annual Return',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        const SizedBox(height: 4),
        const Text(
          'GST Annual Return (GSTR-9 / 9C)',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        FormCard(title: 'Client Information', icon: Icons.person_outline, child: _buildClientInfo()),
        const SizedBox(height: 16),
        FormCard(title: 'Business & GST Details', icon: Icons.domain, child: _buildBusinessDetails()),
        const SizedBox(height: 16),
        FormCard(title: 'Annual Return Details', icon: Icons.calendar_month_outlined, child: _buildReturnDetails()),
        const SizedBox(height: 16),
        FormCard(title: 'Document Upload', icon: Icons.folder_open_outlined, child: _buildDocuments()),
        const SizedBox(height: 24),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildClientInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(
                label: 'Client Name*',
                hint: 'Enter Full Name',
                icon: Icons.person_outline,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(
                label: 'Contact Email*',
                hint: 'Enter Email Address',
                icon: Icons.email_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(
                label: 'Contact Number*',
                hint: 'Enter 10-digit Mobile Number',
                icon: Icons.phone_outlined,
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormTextField(
            label: 'Business Name*',
            hint: 'Enter Registered Business Name',
            icon: Icons.business,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FormTextField(
            label: 'GSTIN*',
            hint: 'Enter 15-digit GSTIN',
            icon: Icons.badge_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildReturnDetails() {
    return _buildFYDropdown();
  }

  Widget _buildFYDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Financial Year',
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF94A3B8)),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedFY,
                    hint: const Text(
                      'Select Financial Year (e.g. FY 2024-25)',
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8)),
                    style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
                    onChanged: (v) => setState(() => _selectedFY = v),
                    items: _financialYears
                        .map((fy) => DropdownMenuItem(value: fy, child: Text(fy)))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Must be a past or current financial year',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDocuments() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormFileField(
            label: 'GSTR-9 Data*',
            icon: Icons.description_outlined,
            onFilePicked: (_) {},
            helperText: 'Annual return data – XLSX/PDF, max 10MB',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FormFileField(
            label: 'GSTR-9C Data',
            icon: Icons.verified_outlined,
            onFilePicked: (_) {},
            helperText: 'Auditor certified statement – PDF only (Optional)',
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveringSubmit = true),
        onExit: (_) => setState(() => _hoveringSubmit = false),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () => _showSuccessDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: _hoveringSubmit ? const Color(0xFF4A59D0) : AppColors.brandBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 420,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Application Submitted!',
                  style: TextStyle(
                    color: Color(0xFF1A1F2E),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'We have received your GST Annual Return request. Our team will process it and get back to you shortly.',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back to Services',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
