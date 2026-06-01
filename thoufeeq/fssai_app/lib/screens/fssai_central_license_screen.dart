import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/form_fields.dart';

class FssaiCentralLicenseScreen extends StatefulWidget {
  const FssaiCentralLicenseScreen({super.key});

  @override
  State<FssaiCentralLicenseScreen> createState() =>
      _FssaiCentralLicenseScreenState();
}

class _FssaiCentralLicenseScreenState
    extends State<FssaiCentralLicenseScreen> {
  int _selectedNavIndex = 11;
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
          'FSSAI Services > Central License',
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 4),
        const Text(
          'FSSAI Central License Registration',
          style: TextStyle(
            color: Color(0xFF1A1F2E),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        FormCard(title: 'Business Details and Identity Proofs', icon: Icons.badge, child: _buildBusinessDetailsIdentity()),
        const SizedBox(height: 16),
        FormCard(title: 'Contact Information', icon: Icons.contact_mail, child: _buildContactInfo()),
        const SizedBox(height: 16),
        FormCard(title: 'Qualification of Proprietor', icon: Icons.school, child: _buildQualification()),
        const SizedBox(height: 16),
        FormCard(title: 'Company Registration and Structure', icon: Icons.business, child: _buildCompanyRegistration()),
        const SizedBox(height: 16),
        FormCard(title: 'Food Products and Processing Details', icon: Icons.fastfood, child: _buildFoodProductsProcessing()),
        const SizedBox(height: 16),
        FormCard(title: 'Quality and Safety Standards', icon: Icons.verified, child: _buildQualitySafety()),
        const SizedBox(height: 16),
        FormCard(title: 'Supporting Licenses and Certificates', icon: Icons.assignment, child: _buildSupportingLicenses()),
        const SizedBox(height: 16),
        FormCard(title: 'Miscellaneous Documents', icon: Icons.description, child: _buildMiscDocs()),
        const SizedBox(height: 24),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildBusinessDetailsIdentity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFileField(label: 'Form-B (Signed and Completed)*', icon: Icons.description, onFilePicked: (_) {}),
        const SizedBox(height: 16),
        const Text(
          'Photo ID Proof',
          style: TextStyle(
            color: Color(0xFF475569),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormDropdownField(label: 'Select ID Proof*', icon: Icons.list, placeholder: '-- Select an ID Proof --')),
            const SizedBox(width: 20),
            Expanded(child: FormFileField(label: 'ID Proof File Upload*', icon: Icons.upload_file, onFilePicked: (_) {})),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormFileField(label: 'Address Proof*', icon: Icons.location_on, onFilePicked: (_) {})),
            const SizedBox(width: 20),
            Expanded(child: FormFileField(label: 'Pan Card*', icon: Icons.credit_card, onFilePicked: (_) {})),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: FormTextField(label: 'Email ID*', hint: 'Enter Email ID', icon: Icons.email)),
        const SizedBox(width: 20),
        Expanded(child: FormTextField(label: 'Phone Number*', hint: 'Enter Phone Number', icon: Icons.phone)),
      ],
    );
  }

  Widget _buildQualification() {
    return FormTextField(label: 'Qualification', hint: 'Enter Qualification', icon: Icons.school);
  }

  Widget _buildCompanyRegistration() {
    return FormFileField(label: 'Proof of Business Registration*', icon: Icons.assignment, onFilePicked: (_) {});
  }

  Widget _buildFoodProductsProcessing() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(label: 'List of Food Product*', hint: 'Enter List of Food Product', icon: Icons.inventory_2),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(
                label: 'FSSAI Product Codes*',
                hint: 'Enter FSSAI Product code',
                icon: Icons.code,
                helperText: 'Example: 1234, ABC567, 890D',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormFileField(label: 'Production Unit Layout Plan*', icon: Icons.map, onFilePicked: (_) {})),
            const SizedBox(width: 20),
            Expanded(child: FormFileField(label: 'Manufacturing Process Flow Chart*', icon: Icons.timeline, onFilePicked: (_) {})),
          ],
        ),
      ],
    );
  }

  Widget _buildQualitySafety() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: FormFileField(label: 'Water Testing Report*', icon: Icons.water_drop, onFilePicked: (_) {})),
        const SizedBox(width: 20),
        Expanded(
          child: FormFileField(label: 'Food Safety Management System (FSMS) Plan*', icon: Icons.security, onFilePicked: (_) {}),
        ),
      ],
    );
  }

  Widget _buildSupportingLicenses() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormFileField(label: 'Import-Export Code (IEC)', icon: Icons.public, onFilePicked: (_) {})),
            const SizedBox(width: 20),
            Expanded(child: FormFileField(label: 'NOC or Trade License*', icon: Icons.gavel, onFilePicked: (_) {})),
          ],
        ),
        const SizedBox(height: 20),
        FormFileField(label: 'Proof of Turnover*', icon: Icons.trending_up, onFilePicked: (_) {}),
      ],
    );
  }

  Widget _buildMiscDocs() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: FormFileField(label: 'Affidavit', icon: Icons.description, onFilePicked: (_) {})),
            const SizedBox(width: 20),
            Expanded(child: FormFileField(label: 'Nominee Declaration Form*', icon: Icons.assignment, onFilePicked: (_) {})),
          ],
        ),
        const SizedBox(height: 20),
        FormFileField(label: 'Authorized Letter*', icon: Icons.mail, onFilePicked: (_) {}),
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
