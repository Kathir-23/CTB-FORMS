import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class BusinessOpcScreen extends StatefulWidget {
  const BusinessOpcScreen({super.key});

  @override
  State<BusinessOpcScreen> createState() => _BusinessOpcScreenState();
}

class _BusinessOpcScreenState extends State<BusinessOpcScreen> {
  int _selectedNavIndex = 14;
  final _formKey = GlobalKey<FormState>();

  final _opcNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _ownerNameCtrl = TextEditingController();
  final _ownerPanCtrl = TextEditingController();
  final _ownerDinCtrl = TextEditingController();
  final _ownerAddressCtrl = TextEditingController();

  String? _moaAoaFile;
  String? _panTanFile;
  String? _ownerPanIdFile;
  String? _officeProofFile;
  String? _bankProofFile;

  @override
  void dispose() {
    _opcNameCtrl.dispose();
    _gstinCtrl.dispose();
    _addressCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _ownerNameCtrl.dispose();
    _ownerPanCtrl.dispose();
    _ownerDinCtrl.dispose();
    _ownerAddressCtrl.dispose();
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
    if (_ownerPanIdFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Owner PAN & ID Proof is required'))); return;
    }
    if (_officeProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered Office Proof is required'))); return;
    }
    showBusinessSuccessDialog(context, 'One Person Company (OPC) Registration');
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
          const GstBreadcrumb(path: 'Business Registration > One Person Company'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'One Person Company (OPC) Registration'),
          const SizedBox(height: 4),
          const Text('Processing Time: 10\u201315 working days',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          GstFormCard(title: 'OPC Information', icon: Icons.business, child: _buildOpcInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Director / Owner Details', icon: Icons.person, child: _buildOwnerDetails()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Supporting Documents', icon: Icons.folder, child: _buildDocuments()),
          const SizedBox(height: 24),
          GstSubmitButton(onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildOpcInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Proposed OPC Name', hint: 'Name for MCA approval', icon: Icons.business, required: true,
              controller: _opcNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'GSTIN', hint: 'GSTIN if applicable (optional)', icon: Icons.receipt,
              controller: _gstinCtrl, validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return !validateGstin(v) ? 'Exactly 15 alphanumeric if entered' : null;
              })),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(label: 'Registered Office Address', hint: 'OPC registered address (min 10 characters)', icon: Icons.location_on, required: true,
          controller: _addressCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Contact Email', hint: 'OPC contact email', icon: Icons.email, required: true,
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

  Widget _buildOwnerDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Director / Owner Name', hint: 'Full name of the owner/director', icon: Icons.person, required: true,
              controller: _ownerNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Director / Owner PAN', hint: 'PAN of the owner/director', icon: Icons.badge, required: true,
              controller: _ownerPanCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
          ],
        ),
        const SizedBox(height: 16),
        GstTextField(label: 'Director / Owner DIN', hint: 'Director Identification Number', icon: Icons.numbers, required: true,
          controller: _ownerDinCtrl, keyboardType: TextInputType.number,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateDin(v) ? 'Exactly 8 digits numeric' : null)),
        const SizedBox(height: 16),
        GstTextareaField(label: 'Director / Owner Address', hint: 'Residential address of the owner/director (min 10 characters)', icon: Icons.location_on, required: true,
          controller: _ownerAddressCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null),
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
            Expanded(child: GstFileField(label: 'Owner PAN & ID Proof', icon: Icons.credit_card, required: true,
              fileName: _ownerPanIdFile, onFilePicked: (n) => _ownerPanIdFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
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
