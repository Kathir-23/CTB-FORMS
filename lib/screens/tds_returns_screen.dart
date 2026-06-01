import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class TDSReturnsScreen extends StatefulWidget {
  const TDSReturnsScreen({super.key});

  @override
  State<TDSReturnsScreen> createState() => _TDSReturnsScreenState();
}

class _TDSReturnsScreenState extends State<TDSReturnsScreen> {
  int _selectedNavIndex = 17;
  final _formKey = GlobalKey<FormState>();

  final _clientNameCtrl = TextEditingController();
  final _tanCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _assessmentYearCtrl = TextEditingController();
  final _quarterCtrl = TextEditingController();
  final _businessAddressCtrl = TextEditingController();
  final _contactPersonCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();

  String? _deducteeFile;
  String? _paymentChallanFile;

  @override
  void dispose() {
    _clientNameCtrl.dispose();
    _tanCtrl.dispose();
    _panCtrl.dispose();
    _assessmentYearCtrl.dispose();
    _quarterCtrl.dispose();
    _businessAddressCtrl.dispose();
    _contactPersonCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    super.dispose();
  }

  bool validateEmail(String? v) => v != null && RegExp(r'^[\w\.\-]+@[\w\-]+\.\w{2,}$').hasMatch(v);
  bool validatePhone(String? v) => v != null && RegExp(r'^\d{10}$').hasMatch(v);
  bool validatePan(String? v) => v != null && RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(v);

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
    if (_deducteeFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deductee Upload is required')));
      return;
    }
    if (_paymentChallanFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment Challan Upload is required')));
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
                const Text('We have received your TDS Returns Filing application. Our team will review it and get back to you shortly.', style: TextStyle(color: Color(0xFF64748B), fontSize: 14), textAlign: TextAlign.center),
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
                  const GstBreadcrumb(path: 'TDS & Financial Management > TDS Returns Filing'),
                  const SizedBox(height: 4),
                  const GstFormTitle(title: 'TDS Returns Filing'),
                  const SizedBox(height: 24),
                  GstFormCard(
                    title: 'TDS Returns Filing Information',
                    icon: Icons.assignment_outlined,
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
            SizedBox(width: fieldWidth, child: _buildField('TAN*', 'Enter 10-digit TAN', _tanCtrl)),
            SizedBox(width: fieldWidth, child: _buildField('PAN*', 'Enter 10-digit PAN', _panCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!validatePan(v)) return 'Exactly 10 alphanumeric characters';
              return null;
            })),
            SizedBox(width: fieldWidth, child: _buildField('Assessment Year*', 'e.g. 2026-2027', _assessmentYearCtrl)),
            SizedBox(width: fieldWidth, child: _buildField('Quarter*', 'e.g. Q1, Q2, Q3, Q4', _quarterCtrl)),
            SizedBox(width: fieldWidth, child: _buildField('Business Address*', 'Enter Business Address', _businessAddressCtrl)),
            SizedBox(width: fieldWidth, child: _buildField('Contact Person*', 'Enter Contact Person Name', _contactPersonCtrl)),
            SizedBox(width: fieldWidth, child: _buildField('Email*', 'Enter Email Address', _emailCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!validateEmail(v)) return 'Invalid email format';
              return null;
            })),
            SizedBox(width: fieldWidth, child: _buildField('Mobile*', 'Enter 10-digit Mobile Number', _mobileCtrl, validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              if (!validatePhone(v)) return 'Exactly 10 digits required';
              return null;
            })),
            SizedBox(width: fieldWidth, child: GstFileField(label: 'Deductee Upload*', icon: Icons.file_upload_outlined, onFilePicked: (n) => _deducteeFile = n, fileName: _deducteeFile)),
            SizedBox(width: fieldWidth, child: GstFileField(label: 'Payment Challan Upload*', icon: Icons.upload_file_outlined, onFilePicked: (n) => _paymentChallanFile = n, fileName: _paymentChallanFile)),
          ],
        );
      },
    );
  }
}
