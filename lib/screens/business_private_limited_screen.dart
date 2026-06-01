import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class BusinessPrivateLimitedScreen extends StatefulWidget {
  const BusinessPrivateLimitedScreen({super.key});

  @override
  State<BusinessPrivateLimitedScreen> createState() => _BusinessPrivateLimitedScreenState();
}

class _BusinessPrivateLimitedScreenState extends State<BusinessPrivateLimitedScreen> {
  int _selectedNavIndex = 14;
  final _formKey = GlobalKey<FormState>();

  final _companyNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _dir1NameCtrl = TextEditingController();
  final _dir1PanCtrl = TextEditingController();
  final _dir1DinCtrl = TextEditingController();
  final _dir1EmailCtrl = TextEditingController();
  final _dir1MobileCtrl = TextEditingController();
  final _dir2NameCtrl = TextEditingController();
  final _dir2PanCtrl = TextEditingController();
  final _dir2DinCtrl = TextEditingController();
  final _dir2EmailCtrl = TextEditingController();
  final _dir2MobileCtrl = TextEditingController();

  String? _moaAoaFile;
  String? _panTanFile;
  String? _dirPanIdFile;
  String? _officeProofFile;
  String? _bankProofFile;

  @override
  void dispose() {
    _companyNameCtrl.dispose();
    _gstinCtrl.dispose();
    _addressCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _dir1NameCtrl.dispose();
    _dir1PanCtrl.dispose();
    _dir1DinCtrl.dispose();
    _dir1EmailCtrl.dispose();
    _dir1MobileCtrl.dispose();
    _dir2NameCtrl.dispose();
    _dir2PanCtrl.dispose();
    _dir2DinCtrl.dispose();
    _dir2EmailCtrl.dispose();
    _dir2MobileCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v);
  bool validateGstin(String? v) => v != null && RegExp(r'^[0-9A-Za-z]{15}$').hasMatch(v);
  bool validateDin(String? v) => v != null && RegExp(r'^\d{8}$').hasMatch(v);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_moaAoaFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('MOA & AOA is required'))); return;
    }
    if (_panTanFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PAN & TAN is required'))); return;
    }
    if (_dirPanIdFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Director PAN & ID Proof is required'))); return;
    }
    if (_officeProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered Office Proof is required'))); return;
    }
    showBusinessSuccessDialog(context, 'Private Limited Company Incorporation');
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 14 ? _buildForm() : const Center(
        child: Text('Not built yet', style: TextStyle(fontSize: 18, color: AppColors.textMuted)),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GstBreadcrumb(path: 'Business Registration > Private Limited Company'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Private Limited Company Incorporation'),
          const SizedBox(height: 4),
          const Text('Processing Time: 10\u201315 working days',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          GstFormCard(title: 'Company Information', icon: Icons.business, child: _buildCompanyInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Director Details', icon: Icons.people, child: _buildDirectorDetails()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Supporting Documents', icon: Icons.folder, child: _buildDocuments()),
          const SizedBox(height: 24),
          GstSubmitButton(onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Proposed Company Name', hint: 'Company name for MCA approval', icon: Icons.business, required: true,
              controller: _companyNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'GSTIN', hint: 'GSTIN if applicable (optional)', icon: Icons.receipt,
              controller: _gstinCtrl, validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return !validateGstin(v) ? 'Exactly 15 alphanumeric if entered' : null;
              })),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(label: 'Registered Office Address', hint: "Company's official registered address (min 10 characters)", icon: Icons.location_on, required: true,
          controller: _addressCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Contact Email', hint: 'Company contact email', icon: Icons.email, required: true,
              controller: _emailCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null))),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Contact Number', hint: '10-digit mobile number', icon: Icons.phone, required: true,
              controller: _phoneCtrl, keyboardType: TextInputType.phone,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null))),
          ],
        ),
      ],
    );
  }

  Widget _buildDirectorDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Director 1 — Name', hint: 'Full name of Director 1', icon: Icons.person, required: true,
              controller: _dir1NameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Director 1 — PAN', hint: 'PAN of Director 1', icon: Icons.badge, required: true,
              controller: _dir1PanCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Director 1 — DIN', hint: 'Director Identification Number of Director 1', icon: Icons.numbers, required: true,
              controller: _dir1DinCtrl, keyboardType: TextInputType.number,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateDin(v) ? 'Exactly 8 digits numeric' : null))),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Director 1 — Email', hint: 'Email of Director 1', icon: Icons.email, required: true,
              controller: _dir1EmailCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null))),
          ],
        ),
        const SizedBox(height: 16),
        GstTextField(label: 'Director 1 — Mobile', hint: 'Mobile of Director 1', icon: Icons.phone, required: true,
          controller: _dir1MobileCtrl, keyboardType: TextInputType.phone,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null)),
        const SizedBox(height: 20),
        Container(height: 1, color: const Color(0xFFF1F5F9)),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Director 2 — Name', hint: 'Full name of Director 2', icon: Icons.person, required: true,
              controller: _dir2NameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Director 2 — PAN', hint: 'PAN of Director 2', icon: Icons.badge, required: true,
              controller: _dir2PanCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Director 2 — DIN', hint: 'Director Identification Number of Director 2', icon: Icons.numbers, required: true,
              controller: _dir2DinCtrl, keyboardType: TextInputType.number,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateDin(v) ? 'Exactly 8 digits numeric' : null))),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Director 2 — Email', hint: 'Email of Director 2', icon: Icons.email, required: true,
              controller: _dir2EmailCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null))),
          ],
        ),
        const SizedBox(height: 16),
        GstTextField(label: 'Director 2 — Mobile', hint: 'Mobile of Director 2', icon: Icons.phone, required: true,
          controller: _dir2MobileCtrl, keyboardType: TextInputType.phone,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null)),
      ],
    );
  }

  Widget _buildDocuments() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'MOA & AOA', icon: Icons.description, required: true,
              fileName: _moaAoaFile, onFilePicked: (n) => _moaAoaFile = n, acceptText: 'PDF only, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'PAN & TAN', icon: Icons.badge, required: true,
              fileName: _panTanFile, onFilePicked: (n) => _panTanFile = n, acceptText: 'PDF only, max 10MB')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'Director PAN & ID Proof', icon: Icons.credit_card, required: true,
              fileName: _dirPanIdFile, onFilePicked: (n) => _dirPanIdFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'Registered Office Proof', icon: Icons.home, required: true,
              fileName: _officeProofFile, onFilePicked: (n) => _officeProofFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
          ],
        ),
        const SizedBox(height: 16),
        GstFileField(label: 'Bank Account Proof', icon: Icons.account_balance,
          fileName: _bankProofFile, onFilePicked: (n) => _bankProofFile = n, acceptText: 'PDF only, max 10MB'),
      ],
    );
  }
}
