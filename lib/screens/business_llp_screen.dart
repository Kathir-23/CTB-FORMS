import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class BusinessLlpScreen extends StatefulWidget {
  const BusinessLlpScreen({super.key});

  @override
  State<BusinessLlpScreen> createState() => _BusinessLlpScreenState();
}

class _BusinessLlpScreenState extends State<BusinessLlpScreen> {
  int _selectedNavIndex = 14;
  final _formKey = GlobalKey<FormState>();

  final _llpNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _partner1NameCtrl = TextEditingController();
  final _partner1PanCtrl = TextEditingController();
  final _partner1DinCtrl = TextEditingController();
  final _partner2NameCtrl = TextEditingController();
  final _partner2PanCtrl = TextEditingController();
  final _partner2DinCtrl = TextEditingController();

  String? _llpAgreementFile;
  String? _panTanFile;
  String? _partnerPanIdFile;
  String? _officeProofFile;
  String? _bankProofFile;

  @override
  void dispose() {
    _llpNameCtrl.dispose();
    _gstinCtrl.dispose();
    _addressCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _partner1NameCtrl.dispose();
    _partner1PanCtrl.dispose();
    _partner1DinCtrl.dispose();
    _partner2NameCtrl.dispose();
    _partner2PanCtrl.dispose();
    _partner2DinCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v);
  bool validateGstin(String? v) => v != null && RegExp(r'^[0-9A-Za-z]{15}$').hasMatch(v);
  bool validateDin(String? v) => v != null && RegExp(r'^\d{8}$').hasMatch(v);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_llpAgreementFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('LLP Agreement is required'))); return;
    }
    if (_panTanFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PAN & TAN is required'))); return;
    }
    if (_partnerPanIdFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Partner PAN & ID Proof is required'))); return;
    }
    if (_officeProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered Office Proof is required'))); return;
    }
    showBusinessSuccessDialog(context, 'Limited Liability Partnership (LLP) Registration');
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
          const GstBreadcrumb(path: 'Business Registration > LLP'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Limited Liability Partnership (LLP) Registration'),
          const SizedBox(height: 4),
          const Text('Processing Time: 10\u201315 working days',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          GstFormCard(title: 'LLP Information', icon: Icons.business, child: _buildLlpInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Partner Details', icon: Icons.people, child: _buildPartnerDetails()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Supporting Documents', icon: Icons.folder, child: _buildDocuments()),
          const SizedBox(height: 24),
          GstSubmitButton(onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildLlpInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'LLP Name', hint: 'Proposed LLP name', icon: Icons.business, required: true,
              controller: _llpNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'GSTIN', hint: 'GSTIN if applicable (optional)', icon: Icons.receipt,
              controller: _gstinCtrl, validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return !validateGstin(v) ? 'Exactly 15 alphanumeric if entered' : null;
              })),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(label: 'Registered Office Address', hint: 'Registered office address (min 10 characters)', icon: Icons.location_on, required: true,
          controller: _addressCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Contact Email', hint: 'LLP contact email', icon: Icons.email, required: true,
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

  Widget _buildPartnerDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Partner 1 — Name', hint: 'Full name of Partner 1', icon: Icons.person, required: true,
              controller: _partner1NameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Partner 1 — PAN', hint: 'PAN of Partner 1', icon: Icons.badge, required: true,
              controller: _partner1PanCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Partner 1 — DIN', hint: 'Designated Partner Identification Number', icon: Icons.numbers, required: true,
              controller: _partner1DinCtrl, keyboardType: TextInputType.number,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateDin(v) ? 'Exactly 8 digits numeric' : null))),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Partner 2 — Name', hint: 'Full name of Partner 2', icon: Icons.person, required: true,
              controller: _partner2NameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Partner 2 — PAN', hint: 'PAN of Partner 2', icon: Icons.badge, required: true,
              controller: _partner2PanCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Partner 2 — DIN', hint: 'Designated Partner Identification Number', icon: Icons.numbers, required: true,
              controller: _partner2DinCtrl, keyboardType: TextInputType.number,
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
            Expanded(child: GstFileField(label: 'LLP Agreement', icon: Icons.description, required: true,
              fileName: _llpAgreementFile, onFilePicked: (n) => _llpAgreementFile = n, acceptText: 'PDF only, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'PAN & TAN', icon: Icons.badge, required: true,
              fileName: _panTanFile, onFilePicked: (n) => _panTanFile = n, acceptText: 'PDF only, max 10MB')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'Partner PAN & ID Proof', icon: Icons.credit_card, required: true,
              fileName: _partnerPanIdFile, onFilePicked: (n) => _partnerPanIdFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
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
