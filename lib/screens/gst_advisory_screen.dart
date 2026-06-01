import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class GstAdvisoryScreen extends StatefulWidget {
  const GstAdvisoryScreen({super.key});

  @override
  State<GstAdvisoryScreen> createState() => _GstAdvisoryScreenState();
}

class _GstAdvisoryScreenState extends State<GstAdvisoryScreen> {
  int _selectedNavIndex = 11;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _turnoverCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  String? _businessType;
  List<String> _advisorySelected = [];

  String? _errBusinessType;
  String? _errAdvisory;

  String? _pastReturnsFile;
  String? _purchaseInvoicesFile;
  String? _salesInvoicesFile;
  String? _finStatementsFile;
  String? _gstCorrespondenceFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _turnoverCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  bool validateGstin(String? v) {
    if (v == null || v.isEmpty) return true;
    return RegExp(r'^[0-9A-Za-z]{15}$').hasMatch(v);
  }

  bool validateEmail(String? v) {
    if (v == null || v.isEmpty) return false;
    return RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  }

  bool validatePhone(String? v) {
    if (v == null || v.isEmpty) return false;
    return RegExp(r'^\d{10}$').hasMatch(v);
  }

  void _submit() {
    setState(() {
      _errBusinessType = _businessType == null ? 'Please select a business type' : null;
      _errAdvisory = _advisorySelected.isEmpty ? 'Please select at least one option' : null;
    });

    if (!_formKey.currentState!.validate()) return;
    if (_errBusinessType != null || _errAdvisory != null) return;

    showGstSuccessDialog(context, 'GST Advisory Service');
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
          const GstBreadcrumb(path: 'GST Services > GST Advisory Service'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'GST Advisory Service'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Advisory Requirements', icon: Icons.lightbulb, child: _buildAdvisory()),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstTextField(
              label: 'GSTIN', hint: 'GST Identification Number (optional)', icon: Icons.badge,
              controller: _gstinCtrl,
              validator: (v) => v != null && v.isNotEmpty && !validateGstin(v) ? 'Must be 15 alphanumeric characters' : null,
            )),
            const SizedBox(width: 20),
            Expanded(child: GstDropdownField(
              label: 'Business Type', icon: Icons.category, required: true,
              value: _businessType,
              items: ['Manufacturer', 'Trader', 'Service Provider', 'Other'],
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
              label: 'Annual Turnover (INR)', hint: 'Annual turnover in Indian Rupees', icon: Icons.trending_up, required: true,
              controller: _turnoverCtrl, keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                final n = double.tryParse(v);
                if (n == null || n <= 0) return 'Must be a positive number';
                return null;
              },
            )),
            const SizedBox(width: 20),
            Expanded(child: GstTextField(
              label: 'Contact Email', hint: 'Client email address', icon: Icons.email, required: true,
              controller: _emailCtrl,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validateEmail(v) ? 'Invalid email format' : null),
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstTextField(
          label: 'Contact Number', hint: '10-digit mobile number', icon: Icons.phone, required: true,
          controller: _phoneCtrl, keyboardType: TextInputType.phone,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (!validatePhone(v) ? 'Exactly 10 digits required' : null),
        ),
      ],
    );
  }

  Widget _buildAdvisory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GstMultiSelectField(
          label: 'Advisory Required', icon: Icons.lightbulb, required: true,
          options: ['Tax Planning', 'Input Tax Credit', 'Compliance Updates', 'Other'],
          selectedValues: _advisorySelected,
          onChanged: (v) => setState(() { _advisorySelected = v; _errAdvisory = null; }),
          errorText: _errAdvisory,
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'Description / Query', hint: 'Describe your query or situation in detail', icon: Icons.description, required: true,
          controller: _descriptionCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (v.length > 500 ? 'Max 500 characters' : null),
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
              label: 'Past GST Returns', icon: Icons.description,
              fileName: _pastReturnsFile, onFilePicked: (n) => _pastReturnsFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Purchase Invoices', icon: Icons.receipt,
              fileName: _purchaseInvoicesFile, onFilePicked: (n) => _purchaseInvoicesFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'Sales Invoices', icon: Icons.receipt_long,
              fileName: _salesInvoicesFile, onFilePicked: (n) => _salesInvoicesFile = n,
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
        const SizedBox(height: 16),
        GstFileField(
          label: 'GST Authority Correspondence', icon: Icons.email,
          fileName: _gstCorrespondenceFile, onFilePicked: (n) => _gstCorrespondenceFile = n,
          acceptText: 'PDF only, max 10MB',
        ),
      ],
    );
  }
}
