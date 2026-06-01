import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class GstHealthCheckScreen extends StatefulWidget {
  const GstHealthCheckScreen({super.key});

  @override
  State<GstHealthCheckScreen> createState() => _GstHealthCheckScreenState();
}

class _GstHealthCheckScreenState extends State<GstHealthCheckScreen> {
  int _selectedNavIndex = 11;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  String? _reviewPeriod;
  String? _errReviewPeriod;

  List<String> _areasSelected = [];
  String? _errAreas;

  String? _gstReturnsFile;
  String? _ledgerFile;
  String? _gstr2bFile;
  String? _finStatementsFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);

  void _submit() {
    setState(() {
      _errReviewPeriod = _reviewPeriod == null ? 'Please select a review period' : null;
      _errAreas = _areasSelected.isEmpty ? 'Please select at least one area' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errReviewPeriod != null || _errAreas != null) return;
    if (_gstReturnsFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('GST Returns (GSTR-1, GSTR-3B) is required')),
      );
      return;
    }
    showGstSuccessDialog(context, 'GST Health Check');
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
          const GstBreadcrumb(path: 'GST Services > GST Health Check'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'GST Health Check'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Health Check Scope', icon: Icons.search, child: _buildScope()),
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

  Widget _buildScope() {
    return Column(
      children: [
        GstDropdownField(
          label: 'Review Period', icon: Icons.calendar_today, required: true,
          value: _reviewPeriod,
          items: ['Last 3 Months', 'Last 6 Months', 'Last 1 Year', 'Custom'],
          onChanged: (v) => setState(() { _reviewPeriod = v; _errReviewPeriod = null; }),
          errorText: _errReviewPeriod,
        ),
        const SizedBox(height: 16),
        GstMultiSelectField(
          label: 'Areas to Review', icon: Icons.list, required: true,
          options: [
            'Return Review (GSTR-1 & GSTR-3B reconciliation)',
            'ITC Verification (match ITC with GSTR-2B)',
            'Books vs GST Reconciliation (sales & purchase)',
            'Tax Liability Check (correct rate & output tax)',
            'Compliance Status Review (pending returns & e-way bills)',
            'Vendor & Customer Risk Analysis',
          ],
          selectedValues: _areasSelected,
          onChanged: (v) => setState(() { _areasSelected = v; _errAreas = null; }),
          errorText: _errAreas,
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'Additional Notes', hint: 'Any specific concerns or focus areas', icon: Icons.description,
          controller: _notesCtrl, maxChars: 500,
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
              label: 'GST Returns (GSTR-1, GSTR-3B)', icon: Icons.description, required: true,
              fileName: _gstReturnsFile, onFilePicked: (n) => _gstReturnsFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Purchase & Sales Ledger', icon: Icons.receipt,
              fileName: _ledgerFile, onFilePicked: (n) => _ledgerFile = n,
              acceptText: 'XLSX/PDF, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'GSTR-2B Statements', icon: Icons.assignment,
              fileName: _gstr2bFile, onFilePicked: (n) => _gstr2bFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Financial Statements', icon: Icons.account_balance,
              fileName: _finStatementsFile, onFilePicked: (n) => _finStatementsFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
          ],
        ),
      ],
    );
  }
}
