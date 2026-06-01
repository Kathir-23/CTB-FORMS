import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class BusinessPartnershipFirmScreen extends StatefulWidget {
  const BusinessPartnershipFirmScreen({super.key});

  @override
  State<BusinessPartnershipFirmScreen> createState() => _BusinessPartnershipFirmScreenState();
}

class _BusinessPartnershipFirmScreenState extends State<BusinessPartnershipFirmScreen> {
  int _selectedNavIndex = 14;
  final _formKey = GlobalKey<FormState>();

  final _firmNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _partnerNamesCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  String? _panCardsFile;
  String? _agreementFile;
  String? _addressProofFile;
  String? _bankProofFile;

  @override
  void dispose() {
    _firmNameCtrl.dispose();
    _gstinCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _partnerNamesCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validateGstin(String? v) => v != null && RegExp(r'^[0-9A-Za-z]{15}$').hasMatch(v);

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_panCardsFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PAN Cards (Firm & Partners) is required'))); return;
    }
    if (_agreementFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Partnership Agreement is required'))); return;
    }
    if (_addressProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Address Proof is required'))); return;
    }
    showBusinessSuccessDialog(context, 'Partnership Firm Registration');
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
          const GstBreadcrumb(path: 'Business Registration > Partnership Firm'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Partnership Firm Registration'),
          const SizedBox(height: 4),
          const Text('Processing Time: 7\u201310 working days',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          GstFormCard(title: 'Firm Information', icon: Icons.business, child: _buildFirmInfo()),
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

  Widget _buildFirmInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Firm Name', hint: 'Proposed name of the firm', icon: Icons.business, required: true,
              controller: _firmNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'GSTIN', hint: 'GSTIN if already registered (optional)', icon: Icons.receipt,
              controller: _gstinCtrl, validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return !validateGstin(v) ? 'Exactly 15 alphanumeric if entered' : null;
              })),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Contact Email', hint: 'Contact email for communication', icon: Icons.email, required: true,
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
        GstTextareaField(label: 'Partner Names', hint: 'List all partner names (minimum 2 partners required)', icon: Icons.people, required: true,
          controller: _partnerNamesCtrl, maxChars: 500,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Required';
            final names = v.trim().split('\n').where((l) => l.trim().isNotEmpty).length;
            return names < 2 ? 'Minimum 2 partners must be listed' : null;
          }),
        const SizedBox(height: 16),
        GstTextareaField(label: 'Business Address', hint: 'Registered office address (min 10 characters)', icon: Icons.location_on, required: true,
          controller: _addressCtrl, maxChars: 500,
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
            Expanded(child: GstFileField(label: 'PAN Cards (Firm & Partners)', icon: Icons.badge, required: true,
              fileName: _panCardsFile, onFilePicked: (n) => _panCardsFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'Partnership Agreement', icon: Icons.description, required: true,
              fileName: _agreementFile, onFilePicked: (n) => _agreementFile = n, acceptText: 'PDF only, max 10MB')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'Address Proof', icon: Icons.home, required: true,
              fileName: _addressProofFile, onFilePicked: (n) => _addressProofFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'Bank Account Proof', icon: Icons.account_balance,
              fileName: _bankProofFile, onFilePicked: (n) => _bankProofFile = n, acceptText: 'PDF only, max 10MB')),
          ],
        ),
      ],
    );
  }
}
