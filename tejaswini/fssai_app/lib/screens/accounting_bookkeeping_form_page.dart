import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/financial_form_widgets.dart';

class AccountingBookkeepingFormPage extends StatefulWidget {
  const AccountingBookkeepingFormPage({super.key});

  @override
  State<AccountingBookkeepingFormPage> createState() =>
      _AccountingBookkeepingFormPageState();
}

class _AccountingBookkeepingFormPageState
    extends State<AccountingBookkeepingFormPage> {
  int _selectedNavIndex = 12;
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: _selectedNavIndex,
      onNavChanged: (i) => setState(() => _selectedNavIndex = i),
      showBackButton: true,
      child: _selectedNavIndex == 12
          ? _buildFormContent()
          : const Center(
              child: Text(
                'Not built yet',
                style: TextStyle(fontSize: 18, color: AppColors.textMuted),
              ),
            ),
    );
  }

  Widget _buildFormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TDS & Financial Services > Accounting & Bookkeeping',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        const SizedBox(height: 4),
        const Text(
          'Accounting & Bookkeeping Information',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Complete the form below for Accounting & Bookkeeping services',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
        ),
        const SizedBox(height: 28),
        FinancialServicesFormCard(
          title: 'Accounting & Bookkeeping Information',
          icon: Icons.calculate_outlined,
          child: _buildFormBody([
            FinancialServicesTextField(
              label: 'Client Name*',
              hint: 'Enter Client Name',
              icon: Icons.person_outline,
            ),
            FinancialServicesTextField(
              label: 'PAN*',
              hint: 'Enter Business PAN',
              icon: Icons.credit_card_outlined,
            ),
            FinancialServicesTextField(
              label: 'GST*',
              hint: 'Enter GSTIN',
              icon: Icons.badge_outlined,
            ),
            FinancialServicesTextField(
              label: 'Business Address*',
              hint: 'Enter Business Address',
              icon: Icons.location_on_outlined,
            ),
            FinancialServicesTextField(
              label: 'Accounting Period*',
              hint: 'e.g., Monthly, Quarterly, Annual',
              icon: Icons.date_range_outlined,
            ),
            FinancialServicesFileField(
              label: 'Invoices Upload*',
              icon: Icons.file_upload_outlined,
              onFilePicked: (file) {},
            ),
            FinancialServicesFileField(
              label: 'Bank Upload*',
              icon: Icons.upload_file_outlined,
              onFilePicked: (file) {},
            ),
            FinancialServicesFileField(
              label: 'Payroll Upload*',
              icon: Icons.upload_file_outlined,
              onFilePicked: (file) {},
            ),
            FinancialServicesFileField(
              label: 'Previous Records Upload*',
              icon: Icons.upload_file_outlined,
              onFilePicked: (file) {},
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildFormBody(List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldGrid(fields),
        const SizedBox(height: 32),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildFieldGrid(List<Widget> fields) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 760;
        final fieldWidth = isDesktop
            ? (constraints.maxWidth - 20) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: fields
              .map((field) => SizedBox(width: fieldWidth, child: field))
              .toList(),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return FinancialGradientButton(
      expand: true,
      label: 'Submit Application',
      loadingLabel: 'Submitting...',
      isLoading: _submitting,
      onPressed: _submitting ? null : _handleSubmit,
    );
  }

  void _handleSubmit() {
    if (_submitting) return;
    setState(() => _submitting = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _submitting = false);
        _showSuccessDialog();
      }
    });
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
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Application Submitted Successfully',
                  style: TextStyle(
                    color: Color(0xFF1A1F2E),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'We have received your Accounting & Bookkeeping application. Our team will review it and get back to you shortly.',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
