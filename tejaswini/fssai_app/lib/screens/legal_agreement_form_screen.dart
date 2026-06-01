import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class LegalAgreementFormScreen extends StatefulWidget {
  const LegalAgreementFormScreen({super.key});

  @override
  State<LegalAgreementFormScreen> createState() => _LegalAgreementFormScreenState();
}

class _LegalAgreementFormScreenState extends State<LegalAgreementFormScreen> {
  int _selectedNavIndex = 13;
  bool _hoveringSubmit = false;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 13
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
          'Legal Services > Legal Agreement Drafting',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        const SizedBox(height: 4),
        const Text(
          'Legal Agreement Drafting Form',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        FormCard(title: 'Legal Agreement Information', icon: Icons.description_outlined, child: _buildAgreementForm()),
        const SizedBox(height: 24),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildAgreementForm() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'Client Name*', hint: 'Enter Client Name', icon: Icons.person_outline),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Business Type*', hint: 'Enter Business Type', icon: Icons.business_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'Business PAN*', hint: 'Enter 10-digit PAN', icon: Icons.credit_card_outlined),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Agreement Type*', hint: 'Enter Agreement Type', icon: Icons.article_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'Key Clauses*', hint: 'Enter key clauses', icon: Icons.list_alt_outlined),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Effective Date*', hint: 'YYYY-MM-DD', icon: Icons.calendar_today_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'Contact Person*', hint: 'Enter Contact Person', icon: Icons.contacts_outlined),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Email*', hint: 'Enter Email Address', icon: Icons.email_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'Phone*', hint: 'Enter 10-digit Mobile Number', icon: Icons.phone_outlined),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormFileField(
                label: 'Agreement Upload*',
                icon: Icons.upload_file_outlined,
                onFilePicked: (file) {},
                helperText: 'PDF, PNG, JPG, DOCX. Max 10MB',
              ),
            ),
          ],
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
                  'We have received your Legal Agreement Drafting request. Our team will review and get back to you shortly.',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                  ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
