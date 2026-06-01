import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class LegalNdaScreen extends StatefulWidget {
  const LegalNdaScreen({super.key});

  @override
  State<LegalNdaScreen> createState() => _LegalNdaScreenState();
}

class _LegalNdaScreenState extends State<LegalNdaScreen> {
  int _selectedNavIndex = 13;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessPanCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _confidentialityDurationCtrl = TextEditingController();
  final _partiesCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  String? _businessType;
  String? _agreementType;
  String? _errBusinessType;
  String? _errAgreementType;

  String? _panCardFile;
  String? _businessRegFile;
  String? _identityProofFile;
  String? _addressProofFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessPanCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _confidentialityDurationCtrl.dispose();
    _partiesCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(v);

  void _submit() {
    setState(() {
      _errBusinessType = _businessType == null ? 'Please select a business type' : null;
      _errAgreementType = _agreementType == null ? 'Please select an agreement type' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errBusinessType != null || _errAgreementType != null) return;
    if (_panCardFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PAN Card of Entity is required')),
      );
      return;
    }
    if (_businessRegFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Business Registration Certificate is required')),
      );
      return;
    }
    if (_identityProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Identity Proof of Signatory is required')),
      );
      return;
    }
    if (_addressProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Address Proof is required')),
      );
      return;
    }
    showLegalSuccessDialog(context, 'NDA (Non-Disclosure Agreement) Service');
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 13 ? _buildForm() : const Center(
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
          const GstBreadcrumb(path: 'Legal Services > NDA Service'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'NDA (Non-Disclosure Agreement) Service'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'NDA Details', icon: Icons.lock_outline, child: _buildNdaDetails()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Supporting Documents', icon: Icons.folder, child: _buildDocuments()),
          const SizedBox(height: 24),
          GstSubmitButton(onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildClientInfo() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Client Name', hint: 'Applicant or business name', icon: Icons.person, required: true,
              controller: _clientNameCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstDropdownField(
              label: 'Business Type', icon: Icons.business, required: true,
              value: _businessType,
              items: ['Proprietorship', 'Partnership', 'Pvt Ltd', 'LLP', 'Startup', 'Other'],
              onChanged: (v) => setState(() { _businessType = v; _errBusinessType = null; }),
              errorText: _errBusinessType,
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstTextField(
          label: 'Business PAN', hint: 'Entity PAN number', icon: Icons.badge, required: true,
          controller: _businessPanCtrl,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'PAN format: 5 letters, 4 digits, 1 letter (e.g. ABCDE1234F)' : null),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Contact Email', hint: 'Email ID of the client', icon: Icons.email, required: true,
              controller: _emailCtrl,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null),
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Contact Number', hint: '10-digit mobile number', icon: Icons.phone, required: true,
              controller: _phoneCtrl, keyboardType: TextInputType.phone,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null),
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildNdaDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstDropdownField(
              label: 'Agreement Type', icon: Icons.list, required: true,
              value: _agreementType,
              items: ['One-way NDA', 'Mutual NDA'],
              onChanged: (v) => setState(() { _agreementType = v; _errAgreementType = null; }),
              errorText: _errAgreementType,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Confidentiality Duration', hint: 'Duration in years (e.g. 2)', icon: Icons.timer, required: true,
              controller: _confidentialityDurationCtrl, keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                final n = int.tryParse(v);
                if (n == null || n < 1 || n > 10) return 'Must be 1 to 10 years';
                return null;
              },
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'Parties Involved', hint: 'Names and details of all parties involved in the NDA (min 10 characters)', icon: Icons.people, required: true,
          controller: _partiesCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null,
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'Business Address', hint: 'Registered office address (min 10 characters)', icon: Icons.location_on, required: true,
          controller: _addressCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null,
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
            Expanded(child: GstFileField(
              label: 'PAN Card of Entity', icon: Icons.badge, required: true,
              fileName: _panCardFile, onFilePicked: (n) => _panCardFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Business Registration Certificate', icon: Icons.description, required: true,
              fileName: _businessRegFile, onFilePicked: (n) => _businessRegFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'Identity Proof of Signatory', icon: Icons.credit_card, required: true,
              fileName: _identityProofFile, onFilePicked: (n) => _identityProofFile = n,
              acceptText: 'PDF/JPG/PNG, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Address Proof', icon: Icons.home, required: true,
              fileName: _addressProofFile, onFilePicked: (n) => _addressProofFile = n,
              acceptText: 'PDF/JPG/PNG, max 10MB',
            )),
          ],
        ),
      ],
    );
  }
}
