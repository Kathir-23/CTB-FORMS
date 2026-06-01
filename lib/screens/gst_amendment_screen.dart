import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class GstAmendmentScreen extends StatefulWidget {
  const GstAmendmentScreen({super.key});

  @override
  State<GstAmendmentScreen> createState() => _GstAmendmentScreenState();
}

class _GstAmendmentScreenState extends State<GstAmendmentScreen> {
  int _selectedNavIndex = 11;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  String? _amendmentType;
  String? _errAmendmentType;

  String? _proofNewDetailsFile;
  String? _panCardFile;
  String? _bankStatementFile;
  String? _identityProofFile;
  String? _boardResolutionFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);

  void _submit() {
    setState(() {
      _errAmendmentType = _amendmentType == null ? 'Please select an amendment type' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errAmendmentType != null) return;
    if (_proofNewDetailsFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proof of New Details is required')),
      );
      return;
    }
    showGstSuccessDialog(context, 'GST Amendment');
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 11 ? _buildForm() : const Center(
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
          const GstBreadcrumb(path: 'GST Services > GST Amendment'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'GST Amendment'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Amendment Details', icon: Icons.edit, child: _buildAmendmentDetails()),
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
              label: 'Client Name', hint: 'Full name of the client', icon: Icons.person, required: true,
              controller: _clientNameCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Business Name', hint: 'Registered business name', icon: Icons.business, required: true,
              controller: _businessNameCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstTextField(
          label: 'GSTIN', hint: '15-digit GST Identification Number', icon: Icons.badge, required: true,
          controller: _gstinCtrl,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!RegExp(r'^[0-9A-Za-z]{15}$').hasMatch(v) ? 'Exactly 15 alphanumeric characters' : null),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Contact Email', hint: 'Client email address', icon: Icons.email, required: true,
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

  Widget _buildAmendmentDetails() {
    return Column(
      children: [
        GstDropdownField(
          label: 'Amendment Type', icon: Icons.edit, required: true,
          value: _amendmentType,
          items: ['Business Address', 'Business Name', 'PAN', 'Bank Details', 'Authorized Signatory', 'Other'],
          onChanged: (v) => setState(() { _amendmentType = v; _errAmendmentType = null; }),
          errorText: _errAmendmentType,
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'Amendment Description', hint: 'Describe the amendment in detail', icon: Icons.description, required: true,
          controller: _descriptionCtrl, maxChars: 300,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
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
              label: 'Proof of New Details', icon: Icons.description, required: true,
              fileName: _proofNewDetailsFile, onFilePicked: (n) => _proofNewDetailsFile = n,
              acceptText: 'PDF/JPG/PNG, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'PAN Card', icon: Icons.credit_card,
              fileName: _panCardFile, onFilePicked: (n) => _panCardFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'Bank Statement / Cancelled Cheque', icon: Icons.account_balance,
              fileName: _bankStatementFile, onFilePicked: (n) => _bankStatementFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Identity Proof of Signatory', icon: Icons.badge,
              fileName: _identityProofFile, onFilePicked: (n) => _identityProofFile = n,
              acceptText: 'PDF/JPG/PNG, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstFileField(
          label: 'Board Resolution / Authorization Letter', icon: Icons.description,
          fileName: _boardResolutionFile, onFilePicked: (n) => _boardResolutionFile = n,
          acceptText: 'PDF only, max 10MB',
        ),
      ],
    );
  }
}
