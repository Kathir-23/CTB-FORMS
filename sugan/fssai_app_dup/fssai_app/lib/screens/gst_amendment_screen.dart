import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class GstAmendmentScreen extends StatefulWidget {
  const GstAmendmentScreen({super.key});

  @override
  State<GstAmendmentScreen> createState() => _GstAmendmentScreenState();
}

class _GstAmendmentScreenState extends State<GstAmendmentScreen> {
  int _selectedNavIndex = 10;
  bool _hoveringSubmit = false;

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
          'GST Services > Amendment',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        const SizedBox(height: 4),
        const Text(
          'GST Amendment Request',
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
        FormCard(title: 'Amendment Details', icon: Icons.edit_document, child: _buildAmendmentDetails()),
        const SizedBox(height: 16),
        FormCard(title: 'Supporting Documents', icon: Icons.folder_open_outlined, child: _buildDocuments()),
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
              child: FormTextField(label: 'Client Name*', hint: 'Enter Full Name', icon: Icons.person_outline),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Contact Email*', hint: 'Enter Email Address', icon: Icons.email_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'Contact Number*', hint: 'Enter 10-digit Mobile Number', icon: Icons.phone_outlined),
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
          child: FormTextField(label: 'Business Name*', hint: 'Enter Registered Business Name', icon: Icons.business),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FormTextField(label: 'GSTIN*', hint: 'Enter 15-digit GSTIN', icon: Icons.badge_outlined),
        ),
      ],
    );
  }

  Widget _buildAmendmentDetails() {
    return Column(
      children: [
        const FormDropdownField(
          label: 'Amendment Type*',
          icon: Icons.swap_horiz_outlined,
          placeholder: 'Select Type (Address, Business Name, PAN, Bank Details, Signatory, Other)',
        ),
        const SizedBox(height: 16),
        const FormTextField(
          label: 'Amendment Details*',
          hint: 'Describe the amendment needed (Max 300 characters)',
          icon: Icons.edit_note,
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildDocuments() {
    return FormFileField(
      label: 'Supporting Documents*',
      icon: Icons.upload_file_outlined,
      onFilePicked: (_) {},
      helperText: 'Proof of new details – PDF/JPG/PNG, max 10MB',
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  'We have received your GST Amendment request. Our team will process the changes and get back to you shortly.',
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
