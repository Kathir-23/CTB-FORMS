import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class BusinessTrustScreen extends StatefulWidget {
  const BusinessTrustScreen({super.key});

  @override
  State<BusinessTrustScreen> createState() => _BusinessTrustScreenState();
}

class _BusinessTrustScreenState extends State<BusinessTrustScreen> {
  int _selectedNavIndex = 14;
  final _formKey = GlobalKey<FormState>();

  final _trustNameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _trustee1NameCtrl = TextEditingController();
  final _trustee1PanCtrl = TextEditingController();
  final _trustee2NameCtrl = TextEditingController();
  final _trustee2PanCtrl = TextEditingController();
  final _beneficiariesCtrl = TextEditingController();

  String? _trustDeedFile;
  String? _trustPanFile;
  String? _trusteesPanIdFile;
  String? _officeProofFile;
  String? _bankProofFile;

  @override
  void dispose() {
    _trustNameCtrl.dispose();
    _addressCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _trustee1NameCtrl.dispose();
    _trustee1PanCtrl.dispose();
    _trustee2NameCtrl.dispose();
    _trustee2PanCtrl.dispose();
    _beneficiariesCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_trustDeedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Trust Deed is required'))); return;
    }
    if (_trustPanFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Trust PAN is required'))); return;
    }
    if (_trusteesPanIdFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Trustees PAN & ID is required'))); return;
    }
    if (_officeProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered Office Proof is required'))); return;
    }
    showBusinessSuccessDialog(context, 'Trust Registration');
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
          const GstBreadcrumb(path: 'Business Registration > Trust Registration'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Trust Registration'),
          const SizedBox(height: 4),
          const Text('Processing Time: 10\u201315 working days',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          GstFormCard(title: 'Trust Information', icon: Icons.real_estate_agent, child: _buildTrustInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Trustee & Beneficiary Details', icon: Icons.people, child: _buildTrusteeDetails()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Supporting Documents', icon: Icons.folder, child: _buildDocuments()),
          const SizedBox(height: 24),
          GstSubmitButton(onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildTrustInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Trust Name', hint: 'Name of the trust', icon: Icons.real_estate_agent, required: true,
              controller: _trustNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Contact Email', hint: 'Trustee email address', icon: Icons.email, required: true,
              controller: _emailCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null))),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(label: 'Registered Office Address', hint: 'Address of the trust (min 10 characters)', icon: Icons.location_on, required: true,
          controller: _addressCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null),
        const SizedBox(height: 16),
        GstTextField(label: 'Contact Number', hint: '10-digit mobile number', icon: Icons.phone, required: true,
          controller: _phoneCtrl, keyboardType: TextInputType.phone,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null)),
      ],
    );
  }

  Widget _buildTrusteeDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Trustee 1 — Name', hint: 'Full name of Trustee 1', icon: Icons.person, required: true,
              controller: _trustee1NameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Trustee 1 — PAN', hint: 'PAN of Trustee 1', icon: Icons.badge, required: true,
              controller: _trustee1PanCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Trustee 2 — Name', hint: 'Full name of Trustee 2', icon: Icons.person, required: true,
              controller: _trustee2NameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Trustee 2 — PAN', hint: 'PAN of Trustee 2', icon: Icons.badge, required: true,
              controller: _trustee2PanCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(label: 'Beneficiaries', hint: 'Details of beneficiaries of the trust (max 500 characters)', icon: Icons.favorite, required: true,
          controller: _beneficiariesCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
      ],
    );
  }

  Widget _buildDocuments() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'Trust Deed', icon: Icons.description, required: true,
              fileName: _trustDeedFile, onFilePicked: (n) => _trustDeedFile = n, acceptText: 'PDF only, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'Trust PAN', icon: Icons.badge, required: true,
              fileName: _trustPanFile, onFilePicked: (n) => _trustPanFile = n, acceptText: 'PDF only, max 10MB')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'Trustees PAN & ID', icon: Icons.credit_card, required: true,
              fileName: _trusteesPanIdFile, onFilePicked: (n) => _trusteesPanIdFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
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
