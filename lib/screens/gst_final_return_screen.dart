import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class GstFinalReturnScreen extends StatefulWidget {
  const GstFinalReturnScreen({super.key});

  @override
  State<GstFinalReturnScreen> createState() => _GstFinalReturnScreenState();
}

class _GstFinalReturnScreenState extends State<GstFinalReturnScreen> {
  int _selectedNavIndex = 11;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _businessNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  DateTime? _cancellationDate;
  String? _lastFilingMonth;
  String? _lastFilingYear;

  String? _errCancellationDate;
  String? _errLastFiling;

  String? _salesPurchaseFile;
  String? _cancellationAppFile;
  String? _lastReturnsFile;
  String? _paymentChallansFile;
  String? _priorCorrectionsFile;

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
      _errCancellationDate = _cancellationDate == null ? 'Please select a date' : null;
      _errLastFiling = (_lastFilingMonth == null || _lastFilingYear == null) ? 'Please select filing period' : null;
    });
    if (!_formKey.currentState!.validate()) return;
    if (_errCancellationDate != null || _errLastFiling != null) return;
    if (_salesPurchaseFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sales & Purchase Summary is required')),
      );
      return;
    }
    showGstSuccessDialog(context, 'Final Return (GSTR-10)');
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
        _cancellationDate = picked;
        _errCancellationDate = null;
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
          const GstBreadcrumb(path: 'GST Services > Final Return (GSTR-10)'),
          const SizedBox(height: 4),
          const GstFormTitle(title: 'Final Return (GSTR-10)'),
          const SizedBox(height: 24),
          GstFormCard(title: 'Client Information', icon: Icons.person, child: _buildClientInfo()),
          const SizedBox(height: 16),
          GstFormCard(title: 'Closure Details', icon: Icons.info, child: _buildClosureDetails()),
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

  Widget _buildClosureDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCancellationDateField()),
            const SizedBox(width: 20),
            Expanded(child: _buildLastFilingPicker()),
          ],
        ),
      ],
    );
  }

  Widget _buildCancellationDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('GST Cancellation Date', true),
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
              border: Border.all(color: _errCancellationDate != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Color(0xFF94A3B8)),
                const SizedBox(width: 10),
                Text(
                  _cancellationDate != null
                      ? '${_cancellationDate!.day}/${_cancellationDate!.month}/${_cancellationDate!.year}'
                      : 'Select date',
                  style: TextStyle(
                    color: _cancellationDate != null ? const Color(0xFF374151) : const Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_errCancellationDate != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 14),
            child: Text(_errCancellationDate!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildLastFilingPicker() {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final now = DateTime.now();
    final years = List.generate(5, (i) => '${now.year - i}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Last Filing Period', true),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _errLastFiling != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _lastFilingMonth,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8), size: 22),
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('Month', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14)),
                    ),
                    items: months.map((m) => DropdownMenuItem(value: m, child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(m, style: const TextStyle(fontSize: 14)),
                    ))).toList(),
                    onChanged: (v) => setState(() { _lastFilingMonth = v; _errLastFiling = null; }),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _errLastFiling != null ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _lastFilingYear,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8), size: 22),
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('Year', style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14)),
                    ),
                    items: years.map((y) => DropdownMenuItem(value: y, child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(y, style: const TextStyle(fontSize: 14)),
                    ))).toList(),
                    onChanged: (v) => setState(() { _lastFilingYear = v; _errLastFiling = null; }),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_errLastFiling != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 14),
            child: Text(_errLastFiling!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12)),
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
              label: 'Sales & Purchase Summary', icon: Icons.receipt, required: true,
              fileName: _salesPurchaseFile, onFilePicked: (n) => _salesPurchaseFile = n,
              acceptText: 'XLSX/PDF, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Cancellation / Surrender Application', icon: Icons.description,
              fileName: _cancellationAppFile, onFilePicked: (n) => _cancellationAppFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GstFileField(
              label: 'Last Filed GST Returns', icon: Icons.history,
              fileName: _lastReturnsFile, onFilePicked: (n) => _lastReturnsFile = n,
              acceptText: 'PDF/XLSX, max 10MB',
            )),
            const SizedBox(width: 20),
            Expanded(child: GstFileField(
              label: 'Payment Challans', icon: Icons.payment,
              fileName: _paymentChallansFile, onFilePicked: (n) => _paymentChallansFile = n,
              acceptText: 'PDF only, max 10MB',
            )),
          ],
        ),
        const SizedBox(height: 16),
        GstFileField(
          label: 'Prior Period Corrections', icon: Icons.history,
          fileName: _priorCorrectionsFile, onFilePicked: (n) => _priorCorrectionsFile = n,
          acceptText: 'PDF/XLSX, max 10MB',
        ),
      ],
    );
  }
}
