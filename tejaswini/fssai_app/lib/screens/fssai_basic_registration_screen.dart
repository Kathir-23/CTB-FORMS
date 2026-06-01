import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class FssaiBasicRegistrationScreen extends StatefulWidget {
  const FssaiBasicRegistrationScreen({super.key});

  @override
  State<FssaiBasicRegistrationScreen> createState() =>
      _FssaiBasicRegistrationScreenState();
}

class _FssaiBasicRegistrationScreenState
    extends State<FssaiBasicRegistrationScreen> {
  int _selectedNavIndex = 10;
  bool _authorizedSignatory = false;
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
          'FSSAI Services > Basic Registration',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        const SizedBox(height: 4),
        const Text(
          'FSSAI Basic Registration',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
        FormCard(title: 'Business Information', icon: Icons.domain, child: _buildBusinessInfo()),
        const SizedBox(height: 16),
        FormCard(title: 'Proprietor Information', icon: Icons.person_outline, child: _buildProprietorInfo()),
        const SizedBox(height: 16),
        FormCard(title: 'Food Product Details', icon: Icons.fastfood_outlined, child: _buildFoodProduct()),
        const SizedBox(height: 16),
        FormCard(title: 'Other Information', icon: Icons.description_outlined, child: _buildOtherInfo()),
        const SizedBox(height: 24),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildBusinessInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'Business Name*', hint: 'Enter Business Name', icon: Icons.business),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Business Address*', hint: 'Enter Business Address', icon: Icons.location_on_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FormTextField(label: 'Nature of Business*', hint: 'Enter Nature of Business', icon: Icons.category_outlined),
      ],
    );
  }

  Widget _buildProprietorInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: "Proprietor's Name*", hint: "Enter Proprietor's Name", icon: Icons.person_outline),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Aadhaar Number*', hint: 'Enter Aadhaar Number', icon: Icons.badge_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'PAN Card*', hint: 'ENTER PAN NUMBER', icon: Icons.credit_card_outlined),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Email Address*', hint: 'Enter Email Id', icon: Icons.email_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'Mobile Number*', hint: 'Enter Mobile Number', icon: Icons.phone_outlined),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(label: 'Qualification', hint: 'Enter Qualification', icon: Icons.school_outlined),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFoodProduct() {
    return FormTextField(label: 'List of Food Product*', hint: 'Enter List of Food Product', icon: Icons.inventory_2);
  }

  Widget _buildOtherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTextField(label: 'Other Info', hint: 'Enter Other Information', icon: Icons.info),
        const SizedBox(height: 16),
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: _authorizedSignatory,
                onChanged: (v) => setState(() => _authorizedSignatory = v ?? false),
                activeColor: AppColors.brandBlue,
                side: const BorderSide(color: AppColors.borderLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'A different person is the Authorized Signatory',
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: 14,
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
                  'We have received your FSSAI application. Our team will review and get back to you within 7\u201330 working days.',
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
                      'Back to FSSAI Services',
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
