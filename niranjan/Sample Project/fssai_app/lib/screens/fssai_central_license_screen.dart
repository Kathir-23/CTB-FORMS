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
  int _selectedNavIndex = 12;
  bool _hoveringSubmit = false;
  bool _hasSubmitted = false;

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _qualificationCtrl = TextEditingController();
  final _foodProductCtrl = TextEditingController();
  final _productCodesCtrl = TextEditingController();
  String? _formBFile;
  String? _idProofType;
  String? _idProofFile;
  String? _addressProofFile;
  String? _panFile;
  String? _businessRegistrationFile;
  String? _layoutPlanFile;
  String? _flowChartFile;
  String? _waterTestingFile;
  String? _fsmsFile;
  String? _iecFile;
  String? _nocFile;
  String? _turnoverFile;
  String? _affidavitFile;
  String? _nomineeFile;
  String? _authorizedLetterFile;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _qualificationCtrl.dispose();
    _foodProductCtrl.dispose();
    _productCodesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 12
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
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
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
      ),
    );
  }

  bool _fileRequired(List<String?> files) {
    return files.every((f) => f != null);
  }

  Widget _buildBusinessDetailsIdentity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFileField(
          label: 'Form-B (Signed and Completed)*',
          icon: Icons.description,
          onFilePicked: (v) => _formBFile = v,
          errorText: _formBFile == null && _hasSubmitted ? 'Required' : null,
        ),
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
            Expanded(
              child: FormDropdownField(
                label: 'Select ID Proof*',
                icon: Icons.list,
                placeholder: '-- Select an ID Proof --',
                value: _idProofType,
                items: const ['Aadhaar Card', 'Voter ID', 'Passport', 'Driving License'],
                onChanged: (v) => setState(() => _idProofType = v),
                validator: (v) => v == null ? 'Select ID proof' : null,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormFileField(
                label: 'ID Proof File Upload*',
                icon: Icons.upload_file,
                onFilePicked: (v) => _idProofFile = v,
                errorText: _idProofFile == null && _hasSubmitted ? 'Required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormFileField(
                label: 'Address Proof*',
                icon: Icons.location_on,
                onFilePicked: (v) => _addressProofFile = v,
                errorText: _addressProofFile == null && _hasSubmitted ? 'Required' : null,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormFileField(
                label: 'Pan Card*',
                icon: Icons.credit_card,
                onFilePicked: (v) => _panFile = v,
                errorText: _panFile == null && _hasSubmitted ? 'Required' : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormTextField(
            label: 'Email ID*',
            hint: 'Enter Email ID',
            icon: Icons.email,
            controller: _emailCtrl,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Email is required';
              if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Enter valid email';
              return null;
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FormTextField(
            label: 'Phone Number*',
            hint: 'Enter Phone Number',
            icon: Icons.phone,
            controller: _phoneCtrl,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Phone number is required';
              if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Enter valid 10-digit number';
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQualification() {
    return FormTextField(
      label: 'Qualification',
      hint: 'Enter Qualification',
      icon: Icons.school,
      controller: _qualificationCtrl,
    );
  }

  Widget _buildCompanyRegistration() {
    return FormFileField(
      label: 'Proof of Business Registration*',
      icon: Icons.assignment,
      onFilePicked: (v) => _businessRegistrationFile = v,
      errorText: _businessRegistrationFile == null && _hasSubmitted ? 'Required' : null,
    );
  }

  Widget _buildFoodProductsProcessing() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(
                label: 'List of Food Product*',
                hint: 'Enter List of Food Product',
                icon: Icons.inventory_2,
                controller: _foodProductCtrl,
                validator: (v) => v == null || v.trim().isEmpty ? 'Food product list is required' : null,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormTextField(
                label: 'FSSAI Product Codes*',
                hint: 'Enter FSSAI Product code',
                icon: Icons.code,
                helperText: 'Example: 1234, ABC567, 890D',
                controller: _productCodesCtrl,
                validator: (v) => v == null || v.trim().isEmpty ? 'Product codes are required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormFileField(
                label: 'Production Unit Layout Plan*',
                icon: Icons.map,
                onFilePicked: (v) => _layoutPlanFile = v,
                errorText: _layoutPlanFile == null && _hasSubmitted ? 'Required' : null,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormFileField(
                label: 'Manufacturing Process Flow Chart*',
                icon: Icons.timeline,
                onFilePicked: (v) => _flowChartFile = v,
                errorText: _flowChartFile == null && _hasSubmitted ? 'Required' : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQualitySafety() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormFileField(
            label: 'Water Testing Report*',
            icon: Icons.water_drop,
            onFilePicked: (v) => _waterTestingFile = v,
            errorText: _waterTestingFile == null && _hasSubmitted ? 'Required' : null,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FormFileField(
            label: 'Food Safety Management System (FSMS) Plan*',
            icon: Icons.security,
            onFilePicked: (v) => _fsmsFile = v,
            errorText: _fsmsFile == null && _hasSubmitted ? 'Required' : null,
          ),
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
            Expanded(
              child: FormFileField(
                label: 'Import-Export Code (IEC)',
                icon: Icons.public,
                onFilePicked: (v) => _iecFile = v,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormFileField(
                label: 'NOC or Trade License*',
                icon: Icons.gavel,
                onFilePicked: (v) => _nocFile = v,
                errorText: _nocFile == null && _hasSubmitted ? 'Required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        FormFileField(
          label: 'Proof of Turnover*',
          icon: Icons.trending_up,
          onFilePicked: (v) => _turnoverFile = v,
          errorText: _turnoverFile == null && _hasSubmitted ? 'Required' : null,
        ),
      ],
    );
  }

  Widget _buildMiscDocs() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormFileField(
                label: 'Affidavit',
                icon: Icons.description,
                onFilePicked: (v) => _affidavitFile = v,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FormFileField(
                label: 'Nominee Declaration Form*',
                icon: Icons.assignment,
                onFilePicked: (v) => _nomineeFile = v,
                errorText: _nomineeFile == null && _hasSubmitted ? 'Required' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        FormFileField(
          label: 'Authorized Letter*',
          icon: Icons.mail,
          onFilePicked: (v) => _authorizedLetterFile = v,
          errorText: _authorizedLetterFile == null && _hasSubmitted ? 'Required' : null,
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
            onPressed: () {
              setState(() => _hasSubmitted = true);
              if (_formKey.currentState!.validate()) {
                _showSuccessDialog();
              }
            },
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
