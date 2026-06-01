import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class FssaiStateLicenseScreen extends StatefulWidget {
  const FssaiStateLicenseScreen({super.key});

  @override
  State<FssaiStateLicenseScreen> createState() =>
      _FssaiStateLicenseScreenState();
}

class _FssaiStateLicenseScreenState
    extends State<FssaiStateLicenseScreen> {
  int _selectedNavIndex = 11;
  bool _authorizedSignatory = false;
  bool _hoveringSubmit = false;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 11
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
        Text(
          'FSSAI Services > State License',
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 4),
        const Text(
          'FSSAI State License Registration',
          style: TextStyle(
            color: Color(0xFF1A1F2E),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        FormCard(title: 'General Details', icon: Icons.badge, child: _buildGeneralDetails()),
        const SizedBox(height: 16),
        FormCard(title: 'Contact Details', icon: Icons.contact_mail, child: _buildContactDetails()),
        const SizedBox(height: 16),
        FormCard(title: 'Food Products and Layout', icon: Icons.fastfood, child: _buildFoodProductsLayout()),
        const SizedBox(height: 16),
        FormCard(title: 'Additional Documents', icon: Icons.description, child: _buildAdditionalDocs()),
        const SizedBox(height: 24),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildGeneralDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormFileField(label: 'Aadhaar Card*', icon: Icons.badge, onFilePicked: (_) {})),
            const SizedBox(width: 20),
            Expanded(child: FormFileField(label: 'PAN Card*', icon: Icons.credit_card, onFilePicked: (_) {})),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormTextField(label: 'Company Name*', hint: '', icon: Icons.business)),
            const SizedBox(width: 20),
            Expanded(child: FormTextField(label: 'Company Address*', hint: '', icon: Icons.location_on)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormTextField(label: 'Company Current Location*', hint: '', icon: Icons.location_on)),
            const SizedBox(width: 20),
            Expanded(child: FormFileField(label: 'Incorporation Certificate*', icon: Icons.assignment, onFilePicked: (_) {})),
          ],
        ),
      ],
    );
  }

  Widget _buildContactDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: FormTextField(label: 'Email*', hint: 'Enter Email', icon: Icons.email)),
        const SizedBox(width: 20),
        Expanded(child: FormTextField(label: 'Phone Number*', hint: 'Enter Phone Number', icon: Icons.phone)),
      ],
    );
  }

  Widget _buildFoodProductsLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormTextField(
            label: 'List of Food Products*',
            hint: 'Packaged Ready-to-Eat Meals, Frozen Foods, Sauces',
            icon: Icons.inventory_2,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: FormFileField(label: 'Blueprint or Layout*', icon: Icons.map, onFilePicked: (_) {})),
      ],
    );
  }

  Widget _buildAdditionalDocs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFileField(label: 'EB Card / Rental Agreement*', icon: Icons.description, onFilePicked: (_) {}),
        const SizedBox(height: 16),
        Row(
          children: [
            SizedBox(
              width: 20, height: 20,
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
              'Proprietor is Authorised Signatory',
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
