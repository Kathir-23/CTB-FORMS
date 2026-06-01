import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class BusinessSection8Screen extends StatefulWidget {
  const BusinessSection8Screen({super.key});

  @override
  State<BusinessSection8Screen> createState() => _BusinessSection8ScreenState();
}

class _BusinessSection8ScreenState extends State<BusinessSection8Screen> {
  int _selectedNavIndex = 14;
  final _formKey = GlobalKey<FormState>();

  final _companyNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _objectivesCtrl = TextEditingController();
  final _dir1NameCtrl = TextEditingController();
  final _dir1PanCtrl = TextEditingController();
  final _dir1DinCtrl = TextEditingController();
  final _dir2NameCtrl = TextEditingController();
  final _dir2PanCtrl = TextEditingController();
  final _dir2DinCtrl = TextEditingController();

  String? _moaAoaFile;
  String? _section8LicenseFile;
  String? _panTanFile;
  String? _dirPanIdFile;
  String? _officeProofFile;
  String? _bankProofFile;

  @override
  void dispose() {
    _companyNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _objectivesCtrl.dispose();
    _dir1NameCtrl.dispose();
    _dir1PanCtrl.dispose();
    _dir1DinCtrl.dispose();
    _dir2NameCtrl.dispose();
    _dir2PanCtrl.dispose();
    _dir2DinCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v);
  bool validateDin(String? v) => v != null && RegExp(r'^\d{8}$').hasMatch(v);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_moaAoaFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('MOA & AOA is required'))); return;
    }
    if (_section8LicenseFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Section 8 License Application is required'))); return;
    }
    if (_panTanFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PAN & TAN is required'))); return;
    }
    if (_dirPanIdFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Director PAN & ID Proof is required'))); return;
    }
    if (_officeProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Office Address Proof is required'))); return;
    }
    showBusinessSuccessDialog(context, 'Section 8 Company Registration');
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
          const GstBreadcrumb(path: 'Business Registration > Section 8 Company'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Section 8 Company Registration'),
          const SizedBox(height: 4),
          const Text('Processing Time: 15\u201320 working days',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          GstFormCard(title: 'Company Information', icon: Icons.business, child: _buildCompanyInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Objectives & Director Details', icon: Icons.list_alt, child: _buildObjectives()),
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
            Expanded(child: GstTextField(label: 'Proposed Company Name', hint: 'Name for MCA approval', icon: Icons.business, required: true,
              controller: _companyNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Contact Email', hint: 'Company contact email', icon: Icons.email, required: true,
              controller: _emailCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null))),
          ],
        ),
        const SizedBox(height: 16),
        GstTextField(label: 'Contact Number', hint: '10-digit mobile number', icon: Icons.phone, required: true,
          controller: _phoneCtrl, keyboardType: TextInputType.phone,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null)),
      ],
    );
  }

  Widget _buildObjectives() {
    return Column(
      children: [
        GstTextareaField(label: 'Charitable / Social Objectives', hint: 'Describe the charitable or social objectives of the company (max 500 characters)', icon: Icons.volunteer_activism, required: true,
          controller: _objectivesCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (v.trim().length > 500 ? 'Max 500 characters' : null)),
        const SizedBox(height: 16),
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
            Expanded(child: GstTextField(label: 'Director 1 — DIN', hint: 'Director Identification Number', icon: Icons.numbers, required: true,
              controller: _dir1DinCtrl, keyboardType: TextInputType.number,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateDin(v) ? 'Exactly 8 digits numeric' : null))),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Director 2 — Name', hint: 'Full name of Director 2', icon: Icons.person, required: true,
              controller: _dir2NameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Director 2 — PAN', hint: 'PAN of Director 2', icon: Icons.badge, required: true,
              controller: _dir2PanCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Director 2 — DIN', hint: 'Director Identification Number', icon: Icons.numbers, required: true,
              controller: _dir2DinCtrl, keyboardType: TextInputType.number,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateDin(v) ? 'Exactly 8 digits numeric' : null))),
          ],
        ),
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
            Expanded(child: GstFileField(label: 'Section 8 License Application', icon: Icons.verified, required: true,
              fileName: _section8LicenseFile, onFilePicked: (n) => _section8LicenseFile = n, acceptText: 'PDF only, max 10MB')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'PAN & TAN', icon: Icons.badge, required: true,
              fileName: _panTanFile, onFilePicked: (n) => _panTanFile = n, acceptText: 'PDF only, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'Director PAN & ID Proof', icon: Icons.credit_card, required: true,
              fileName: _dirPanIdFile, onFilePicked: (n) => _dirPanIdFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'Office Address Proof', icon: Icons.home, required: true,
              fileName: _officeProofFile, onFilePicked: (n) => _officeProofFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'Bank Account Proof', icon: Icons.account_balance,
              fileName: _bankProofFile, onFilePicked: (n) => _bankProofFile = n, acceptText: 'PDF only, max 10MB')),
          ],
        ),
      ],
    );
  }
}
