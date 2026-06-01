import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class LegalAgreementScreen extends StatefulWidget {
  const LegalAgreementScreen({super.key});

  @override
  State<LegalAgreementScreen> createState() => _LegalAgreementScreenState();
}

class _LegalAgreementScreenState extends State<LegalAgreementScreen> {
  int _selectedNavIndex = 13;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessPanCtrl = TextEditingController();
  final _contactPersonCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _keyClausesCtrl = TextEditingController();

  String? _businessType;
  String? _agreementType;
  String? _errBusinessType;
  String? _errAgreementType;

  DateTime? _effectiveDate;
  String? _errEffectiveDate;

  String? _panCardFile;
  String? _businessProofFile;
  String? _idProofFile;
  String? _draftTermsFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessPanCtrl.dispose();
    _contactPersonCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _keyClausesCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(v);

  void _submit() {
    setState(() {
      _errBusinessType = _businessType == null ? 'Please select a business type' : null;
      _errAgreementType = _agreementType == null ? 'Please select an agreement type' : null;
      _errEffectiveDate = _effectiveDate == null ? 'Please select a date' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errBusinessType != null || _errAgreementType != null || _errEffectiveDate != null) return;
    if (_panCardFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PAN Card of Entity is required')),
      );
      return;
    }
    if (_businessProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Business Proof is required')),
      );
      return;
    }
    if (_idProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID Proof of Signatory is required')),
      );
      return;
    }
    showLegalSuccessDialog(context, 'Legal Agreement Drafting');
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _effectiveDate = picked;
        _errEffectiveDate = null;
      });
    }
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
          const GstBreadcrumb(path: 'Legal Services > Legal Agreement Drafting'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Legal Agreement Drafting'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Agreement Details', icon: Icons.description_outlined, child: _buildAgreementDetails()),
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
              label: 'Client Name', hint: 'Business or entity name', icon: Icons.person, required: true,
              controller: _clientNameCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstDropdownField(
              label: 'Business Type', icon: Icons.business, required: true,
              value: _businessType,
              items: ['Proprietorship', 'Partnership', 'Pvt Ltd', 'LLP', 'NGO', 'Other'],
              onChanged: (v) => setState(() { _businessType = v; _errBusinessType = null; }),
              errorText: _errBusinessType,
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Business PAN', hint: 'PAN of entity', icon: Icons.badge, required: true,
              controller: _businessPanCtrl,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePan(v) ? 'PAN format: 5 letters, 4 digits, 1 letter' : null),
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Contact Person Name', hint: 'Name of authorized signatory', icon: Icons.person_outline, required: true,
              controller: _contactPersonCtrl,
              validator: (v) => v == null || v.trim().length < 3 ? 'Minimum 3 characters' : null,
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'Contact Email', hint: 'Email ID', icon: Icons.email, required: true,
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

  Widget _buildAgreementDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstDropdownField(
              label: 'Agreement Type', icon: Icons.list, required: true,
              value: _agreementType,
              items: ['Partnership Agreement', 'Service Agreement', 'Vendor Agreement', 'Client Agreement', 'Other'],
              onChanged: (v) => setState(() { _agreementType = v; _errAgreementType = null; }),
              errorText: _errAgreementType,
            )),
            const SizedBox(width: 20),
            Expanded(child: _buildEffectiveDateField()),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'Key Clauses', hint: 'Specific requirements or clauses to be included (min 10 characters)', icon: Icons.list_alt, required: true,
          controller: _keyClausesCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().length < 10 ? 'Minimum 10 characters' : null,
        ),
      ],
    );
  }

  Widget _buildEffectiveDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Effective Date', true),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            width: double.infinity,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _errEffectiveDate != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Color(0xFF94A3B8)),
                const SizedBox(width: 10),
                Text(
                  _effectiveDate != null
                      ? '${_effectiveDate!.day}/${_effectiveDate!.month}/${_effectiveDate!.year}'
                      : 'Select date',
                  style: TextStyle(
                    color: _effectiveDate != null ? const Color(0xFF374151) : const Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_errEffectiveDate != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 14),
            child: Text(_errEffectiveDate!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildLabel(String text, bool required) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text, style: const TextStyle(color: Color(0xFF374151), fontSize: 13, fontWeight: FontWeight.w500)),
          if (required) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 13)),
        ],
      ),
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
              label: 'Business Proof', icon: Icons.description, required: true,
              fileName: _businessProofFile, onFilePicked: (n) => _businessProofFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'ID Proof of Signatory', icon: Icons.credit_card, required: true,
              fileName: _idProofFile, onFilePicked: (n) => _idProofFile = n,
              acceptText: 'PDF/JPG/PNG, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Draft Business Terms', icon: Icons.article_outlined,
              fileName: _draftTermsFile, onFilePicked: (n) => _draftTermsFile = n,
              acceptText: 'PDF/DOCX, max 10MB',
            )),
          ],
        ),
      ],
    );
  }
}
