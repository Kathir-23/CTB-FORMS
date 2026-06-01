import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class GstAnnualReturnScreen extends StatefulWidget {
  const GstAnnualReturnScreen({super.key});

  @override
  State<GstAnnualReturnScreen> createState() => _GstAnnualReturnScreenState();
}

class _GstAnnualReturnScreenState extends State<GstAnnualReturnScreen> {
  int _selectedNavIndex = 11;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  String? _financialYear;
  String? _errFinancialYear;

  String? _gstr9DataFile;
  String? _gstr9CFile;
  String? _itcReconFile;
  String? _auditedFinFile;
  String? _bankStatementsFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);

  void _submit() {
    setState(() {
      _errFinancialYear = _financialYear == null ? 'Please select a financial year' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errFinancialYear != null) return;
    if (_gstr9DataFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('GSTR-9 Annual Data is required')),
      );
      return;
    }
    showGstSuccessDialog(context, 'GST Annual Return Filing');
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
          const GstBreadcrumb(path: 'GST Services > GST Annual Return'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'GST Annual Return Filing'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Annual Return Details', icon: Icons.calendar_today, child: _buildAnnualReturn()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Documents', icon: Icons.folder, child: _buildDocuments()),
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

  Widget _buildAnnualReturn() {
    return GstDropdownField(
      label: 'Financial Year', icon: Icons.calendar_today, required: true,
      value: _financialYear,
      items: ['FY 2022-23', 'FY 2023-24', 'FY 2024-25'],
      onChanged: (v) => setState(() { _financialYear = v; _errFinancialYear = null; }),
      errorText: _errFinancialYear,
    );
  }

  Widget _buildDocuments() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'GSTR-9 Annual Data', icon: Icons.description, required: true,
              fileName: _gstr9DataFile, onFilePicked: (n) => _gstr9DataFile = n,
              acceptText: 'XLSX/PDF, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'GSTR-9C Auditor Statement', icon: Icons.verified,
              fileName: _gstr9CFile, onFilePicked: (n) => _gstr9CFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'ITC Reconciliation', icon: Icons.account_balance,
              fileName: _itcReconFile, onFilePicked: (n) => _itcReconFile = n,
              acceptText: 'XLSX/PDF, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Audited Financial Statements', icon: Icons.account_balance,
              fileName: _auditedFinFile, onFilePicked: (n) => _auditedFinFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstFileField(
          label: 'Bank Statements', icon: Icons.account_balance,
          fileName: _bankStatementsFile, onFilePicked: (n) => _bankStatementsFile = n,
          acceptText: 'PDF only, max 10MB',
        ),
      ],
    );
  }
}
