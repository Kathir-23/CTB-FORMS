import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class AccountingBookkeepingScreen extends StatefulWidget {
  const AccountingBookkeepingScreen({super.key});

  @override
  State<AccountingBookkeepingScreen> createState() => _AccountingBookkeepingScreenState();
}

class _AccountingBookkeepingScreenState extends State<AccountingBookkeepingScreen> {
  int _selectedNavIndex = 17;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _gstCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _accountingPeriodCtrl = TextEditingController();

  String? _invoicesFile;
  String? _bankFile;
  String? _payrollFile;
  String? _previousRecordsFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _panCtrl.dispose();
    _gstCtrl.dispose();
    _addressCtrl.dispose();
    _accountingPeriodCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v);
  bool validateGstin(String? v) => v != null && RegExp(r'^[0-9A-Za-z]{15}$').hasMatch(v);

  Widget _buildField(String label, String hint, TextEditingController controller, {String? Function(String?)? validator}) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk ? label.substring(0, label.length - 1) : label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(cleanLabel, hasAsterisk),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint.isEmpty ? null : hint,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF94A3B8))),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
            validator: validator ?? (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text, bool hasAsterisk) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text, style: const TextStyle(color: Color(0xFF374151), fontSize: 13, fontWeight: FontWeight.w500)),
          if (hasAsterisk) const TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 13)),
        ],
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_invoicesFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invoices Upload is required')));
      return;
    }
    if (_bankFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bank Upload is required')));
      return;
    }
    if (_payrollFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payroll Upload is required')));
      return;
    }
    if (_previousRecordsFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Previous Records Upload is required')));
      return;
    }
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 420,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 20),
                const Text('Application Submitted Successfully', style: TextStyle(color: Color(0xFF1A1F2E), fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                const Text('We have received your Accounting & Bookkeeping application. Our team will review it and get back to you shortly.', style: TextStyle(color: Color(0xFF64748B), fontSize: 14), textAlign: TextAlign.center),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text('Close', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 17
          ? Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GstBreadcrumb(path: 'TDS & Financial Management > Accounting & Bookkeeping'),
                  const SizedBox(height: 4),
                  const GstFormTitle(title: 'Accounting & Bookkeeping'),
                  const SizedBox(height: 24),
                  GstFormCard(
                    title: 'Accounting & Bookkeeping Information',
                    icon: Icons.calculate_outlined,
                    child: _buildFormBody(),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('Not built yet', style: TextStyle(fontSize: 18, color: AppColors.textMuted)),
            ),
    );
  }

  Widget _buildFormBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldGrid(),
        const SizedBox(height: 32),
        GstSubmitButton(onPressed: _submit, label: 'Submit'),
      ],
    );
  }

  Widget _buildFieldGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fieldWidth = constraints.maxWidth >= 760
            ? (constraints.maxWidth - 20) / 2
            : constraints.maxWidth;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(width: fieldWidth, child: _buildField('Client Name*', 'Enter Client Name', _clientNameCtrl)),
            SizedBox(width: fieldWidth, child: _buildField('PAN*', 'Enter Business PAN', _panCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!validatePan(v)) return 'Exactly 10 alphanumeric characters';
              return null;
            })),
            SizedBox(width: fieldWidth, child: _buildField('GST*', 'Enter GSTIN', _gstCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!validateGstin(v)) return 'Exactly 15 alphanumeric characters';
              return null;
            })),
            SizedBox(width: fieldWidth, child: _buildField('Business Address*', 'Enter Business Address', _addressCtrl)),
            SizedBox(width: fieldWidth, child: _buildField('Accounting Period*', 'Monthly / Quarterly / Annual', _accountingPeriodCtrl)),
            SizedBox(width: fieldWidth, child: GstFileField(label: 'Invoices Upload*', icon: Icons.file_upload_outlined, onFilePicked: (n) => _invoicesFile = n, fileName: _invoicesFile)),
            SizedBox(width: fieldWidth, child: GstFileField(label: 'Bank Upload*', icon: Icons.upload_file_outlined, onFilePicked: (n) => _bankFile = n, fileName: _bankFile)),
            SizedBox(width: fieldWidth, child: GstFileField(label: 'Payroll Upload*', icon: Icons.upload_file_outlined, onFilePicked: (n) => _payrollFile = n, fileName: _payrollFile)),
            SizedBox(width: fieldWidth, child: GstFileField(label: 'Previous Records Upload*', icon: Icons.upload_file_outlined, onFilePicked: (n) => _previousRecordsFile = n, fileName: _previousRecordsFile)),
          ],
        );
      },
    );
  }
}
