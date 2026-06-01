import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class BusinessSoleProprietorshipScreen extends StatefulWidget {
  const BusinessSoleProprietorshipScreen({super.key});

  @override
  State<BusinessSoleProprietorshipScreen> createState() => _BusinessSoleProprietorshipScreenState();
}

class _BusinessSoleProprietorshipScreenState extends State<BusinessSoleProprietorshipScreen> {
  int _selectedNavIndex = 14;
  final _formKey = GlobalKey<FormState>();

  final _applicantNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  String? _businessType;
  String? _errBusinessType;

  String? _panCardFile;
  String? _addressProofFile;
  String? _idProofFile;
  String? _bankProofFile;

  @override
  void dispose() {
    _applicantNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _panCtrl.dispose();
    _gstinCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v);
  bool validateGstin(String? v) => v != null && RegExp(r'^[0-9A-Za-z]{15}$').hasMatch(v);

  void _submit() {
    setState(() => _errBusinessType = _businessType == null ? 'Please select a business type' : null);
    if (!_formKey.currentState!.validate()) return;
    if (_errBusinessType != null) return;
    if (_panCardFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PAN Card is required'))); return;
    }
    if (_addressProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Address Proof is required'))); return;
    }
    if (_idProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ID Proof is required'))); return;
    }
    showBusinessSuccessDialog(context, 'Sole Proprietorship Registration');
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
          const GstBreadcrumb(path: 'Business Registration > Sole Proprietorship'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Sole Proprietorship Registration'),
          const SizedBox(height: 4),
          const Text('Processing Time: 3\u20137 working days',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          GstFormCard(title: 'Applicant Information', icon: Icons.person, child: _buildApplicantInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Business Address', icon: Icons.location_on, child: _buildAddress()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Supporting Documents', icon: Icons.folder, child: _buildDocuments()),
          const SizedBox(height: 24),
          GstSubmitButton(onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildApplicantInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'Applicant Name', hint: 'Full name of the owner', icon: Icons.person, required: true,
              controller: _applicantNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Business Name', hint: 'Proposed business name', icon: Icons.business, required: true,
              controller: _businessNameCtrl, validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(label: 'PAN', hint: "Owner's PAN number", icon: Icons.badge, required: true,
              controller: _panCtrl, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'Exactly 10 alphanumeric characters' : null))),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'GSTIN', hint: 'GSTIN (if applicable)', icon: Icons.receipt,
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
            Expanded(child: GstDropdownField(
              label: 'Business Type', icon: Icons.category, required: true,
              value: _businessType, items: ['Trading', 'Service', 'Manufacturing', 'Other'],
              onChanged: (v) => setState(() { _businessType = v; _errBusinessType = null; }),
              errorText: _errBusinessType,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(label: 'Contact Email', hint: "Owner's email address", icon: Icons.email, required: true,
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

  Widget _buildAddress() {
    return GstTextareaField(label: 'Business Address', hint: 'Registered business address (min 10 characters)', icon: Icons.location_on, required: true,
      controller: _addressCtrl, maxChars: 500,
      validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null);
  }

  Widget _buildDocuments() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'PAN Card', icon: Icons.badge, required: true,
              fileName: _panCardFile, onFilePicked: (n) => _panCardFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'Address Proof', icon: Icons.home, required: true,
              fileName: _addressProofFile, onFilePicked: (n) => _addressProofFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(label: 'ID Proof', icon: Icons.credit_card, required: true,
              fileName: _idProofFile, onFilePicked: (n) => _idProofFile = n, acceptText: 'PDF/JPG/PNG, max 10MB')),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(label: 'Bank Account Proof', icon: Icons.account_balance,
              fileName: _bankProofFile, onFilePicked: (n) => _bankProofFile = n, acceptText: 'PDF only, max 10MB')),
          ],
        ),
      ],
    );
  }
}
