import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class GstNoticeReplyScreen extends StatefulWidget {
  const GstNoticeReplyScreen({super.key});

  @override
  State<GstNoticeReplyScreen> createState() => _GstNoticeReplyScreenState();
}

class _GstNoticeReplyScreenState extends State<GstNoticeReplyScreen> {
  int _selectedNavIndex = 11;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _explanationCtrl = TextEditingController();

  String? _noticeType;
  DateTime? _noticeDate;

  String? _errNoticeType;
  String? _errNoticeDate;

  String? _noticeCopyFile;
  String? _relatedInvoicesFile;
  String? _previousReturnsFile;
  String? _bankStatementsFile;
  String? _gstCorrespondenceFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _businessNameCtrl.dispose();
    _gstinCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _explanationCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);

  void _submit() {
    setState(() {
      _errNoticeType = _noticeType == null ? 'Please select a notice type' : null;
      _errNoticeDate = _noticeDate == null ? 'Please select a date' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errNoticeType != null || _errNoticeDate != null) return;
    if (_noticeCopyFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('GST Notice Copy is required')),
      );
      return;
    }
    showGstSuccessDialog(context, 'GST Notice Reply');
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
        _noticeDate = picked;
        _errNoticeDate = null;
      });
    }
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
          const GstBreadcrumb(path: 'GST Services > GST Notice Reply'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'GST Notice Reply'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Notice Details', icon: Icons.info, child: _buildNoticeDetails()),
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

  Widget _buildNoticeDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstDropdownField(
              label: 'Notice Type', icon: Icons.list, required: true,
              value: _noticeType,
              items: ['Show Cause Notice', 'Demand Notice', 'Audit Notice', 'Others'],
              onChanged: (v) => setState(() { _noticeType = v; _errNoticeType = null; }),
              errorText: _errNoticeType,
            )),
            const SizedBox(width: 20),
            Expanded(child: _buildDateField()),
          ],
        ),
        const SizedBox(height: 16),
        GstTextareaField(
          label: 'Client Explanation', hint: 'Describe the situation and context of the notice', icon: Icons.description, required: true,
          controller: _explanationCtrl, maxChars: 500,
          validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Notice Date', true),
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
              border: Border.all(color: _errNoticeDate != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Color(0xFF94A3B8)),
                const SizedBox(width: 10),
                Text(
                  _noticeDate != null
                      ? '${_noticeDate!.day}/${_noticeDate!.month}/${_noticeDate!.year}'
                      : 'Select date',
                  style: TextStyle(
                    color: _noticeDate != null ? const Color(0xFF374151) : const Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_errNoticeDate != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 14),
            child: Text(_errNoticeDate!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12)),
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
              label: 'GST Notice Copy', icon: Icons.description, required: true,
              fileName: _noticeCopyFile, onFilePicked: (n) => _noticeCopyFile = n,
              acceptText: 'PDF only, max 5MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Related Invoices / Bills', icon: Icons.receipt,
              fileName: _relatedInvoicesFile, onFilePicked: (n) => _relatedInvoicesFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'Previous GST Returns', icon: Icons.history,
              fileName: _previousReturnsFile, onFilePicked: (n) => _previousReturnsFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Bank Statements', icon: Icons.account_balance,
              fileName: _bankStatementsFile, onFilePicked: (n) => _bankStatementsFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstFileField(
          label: 'GST Department Correspondence', icon: Icons.email,
          fileName: _gstCorrespondenceFile, onFilePicked: (n) => _gstCorrespondenceFile = n,
          acceptText: 'PDF only, max 10MB',
        ),
      ],
    );
  }
}
