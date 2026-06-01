import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_layout.dart';
import '../widgets/gst_form_fields.dart';

class ItrForm extends StatefulWidget {
  final int itrType;

  const ItrForm({super.key, required this.itrType});

  @override
  State<ItrForm> createState() => _ItrFormState();
}

class _ItrFormState extends State<ItrForm> {
  final _formKey = GlobalKey<FormState>();

  final _panCtrl = TextEditingController();
  final _aadhaarCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _bankAccountCtrl = TextEditingController();
  final _confirmAccountCtrl = TextEditingController();
  final _ifscCtrl = TextEditingController();
  final _bankNameCtrl = TextEditingController();
  final _accountHolderCtrl = TextEditingController();
  final _turnoverCtrl = TextEditingController();

  final _salaryCtrl = TextEditingController();
  final _pensionCtrl = TextEditingController();
  final _interestCtrl = TextEditingController();

  final _capitalGainsCtrl = TextEditingController();
  final _housePropertyCtrl = TextEditingController();
  final _foreignIncomeCtrl = TextEditingController();

  final _businessIncomeCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();

  final _presumptiveIncomeCtrl = TextEditingController();
  final _businessTurnoverCtrl = TextEditingController();

  final _entityNameCtrl = TextEditingController();
  final _entityPanCtrl = TextEditingController();

  final _companyNameCtrl = TextEditingController();
  final _cinCtrl = TextEditingController();
  final _tdsCtrl = TextEditingController();

  final _trustNameCtrl = TextEditingController();
  final _registrationNoCtrl = TextEditingController();
  final _donationDetailsCtrl = TextEditingController();

  final _noticeNoCtrl = TextEditingController();
  final _assessmentYearCtrl = TextEditingController();
  final _responseExplanationCtrl = TextEditingController();

  String? _financialYear;
  bool _acknowledge = false;

  String? _form16FileName, _form26asFileName, _deductionProofsFileName;
  String? _capitalGainsFileName, _foreignIncomeFileName;
  String? _plStatementFileName, _balanceSheetFileName, _bankStmtsFileName, _auditReportFileName, _gstFileName;
  String? _digitalSignatureFileName, _tdsFileName;
  String? _registrationCertFileName, _donationFileName, _incomeExpenditureFileName;
  String? _noticeFileName, _itrCopyFileName, _supportingDocsFileName, _incomeProofsFileName;

  static const _itrTitles = [
    'ITR Filing \u2013 General (All Types)',
    'ITR-1 Filing (Sahaj) \u2014 Salaried Individuals',
    'ITR-2 Filing \u2014 Individuals/HUF (No Business)',
    'ITR-3 Filing \u2014 Business/Profession Income',
    'ITR-4 Filing (Sugam) \u2014 Presumptive Income',
    'ITR-5 Filing \u2014 Firms/LLPs/AOPs/BOIs',
    'ITR-6 Filing \u2014 Companies',
    'ITR-7 Filing \u2014 Trusts & Charitable Institutions',
    'Income Tax Notice Response',
  ];

  String get _title => _itrTitles[widget.itrType];

  bool get _isGeneral => widget.itrType == 0;
  bool get _isItr1 => widget.itrType == 1;
  bool get _isItr2 => widget.itrType == 2;
  bool get _isItr3 => widget.itrType == 3;
  bool get _isItr4 => widget.itrType == 4;
  bool get _isItr5 => widget.itrType == 5;
  bool get _isItr6 => widget.itrType == 6;
  bool get _isItr7 => widget.itrType == 7;
  bool get _isNotice => widget.itrType == 8;

  List<String> get _financialYears {
    final y = DateTime.now().year;
    final s = y % 100;
    return ['$y-${s + 1}', '${y - 1}-$s', '${y - 2}-${s - 1}'];
  }

  @override
  void dispose() {
    for (final c in [
      _panCtrl, _aadhaarCtrl, _emailCtrl, _mobileCtrl, _descriptionCtrl,
      _bankAccountCtrl, _confirmAccountCtrl, _ifscCtrl, _bankNameCtrl, _accountHolderCtrl, _turnoverCtrl,
      _salaryCtrl, _pensionCtrl, _interestCtrl,
      _capitalGainsCtrl, _housePropertyCtrl, _foreignIncomeCtrl,
      _businessIncomeCtrl, _gstinCtrl,
      _presumptiveIncomeCtrl, _businessTurnoverCtrl,
      _entityNameCtrl, _entityPanCtrl,
      _companyNameCtrl, _cinCtrl, _tdsCtrl,
      _trustNameCtrl, _registrationNoCtrl, _donationDetailsCtrl,
      _noticeNoCtrl, _assessmentYearCtrl, _responseExplanationCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeNavIndex: 0,
      onNavChanged: (_) {},
      showBackButton: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GstBreadcrumb(path: 'Income Tax Services > ITR Filing'),
              const SizedBox(height: 4),
              GstFormTitle(title: _title),
              const SizedBox(height: 24),
              if (_isGeneral) ..._buildGenericForm()
              else if (_isItr1) ..._buildItr1Form()
              else if (_isItr2) ..._buildItr2Form()
              else if (_isItr3) ..._buildItr3Form()
              else if (_isItr4) ..._buildItr4Form()
              else if (_isItr5) ..._buildItr5Form()
              else if (_isItr6) ..._buildItr6Form()
              else if (_isItr7) ..._buildItr7Form()
              else ..._buildNoticeForm(),
              const SizedBox(height: 24),
              _buildAcknowledgement(),
              const SizedBox(height: 28),
              GstSubmitButton(onPressed: _submitForm, label: 'Submit Request'),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItr1Form() {
    return [
      GstFormCard(title: 'PAN & Aadhaar', icon: Icons.verified_user_outlined, child: Column(children: [
        _two(
          _buildTextField('PAN Card*', 'Mandatory', _panCtrl, _panValidator),
          _buildTextField('Aadhaar Number*', 'Mandatory', _aadhaarCtrl, _aadhaarValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Mobile Number*', 'OTP verification', _mobileCtrl, _mobileValidator),
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Income Details', icon: Icons.analytics_outlined, child: Column(children: [
        _sectionLabel('Enter your income details'),
        const SizedBox(height: 10),
        _two(
          _buildTextField('Salary', 'Salary income', _salaryCtrl),
          _buildTextField('Pension', 'Pension income', _pensionCtrl),
        ),
        const SizedBox(height: 20),
        _buildTextField('Interest Income', 'Interest from bank, FD, etc.', _interestCtrl),
        const SizedBox(height: 20),
        _buildFyDropdown(),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _buildFileField('Form 16', _form16FileName, (v) => _form16FileName = v),
        const SizedBox(height: 14),
        _buildFileField('Form 26AS / AIS', _form26asFileName, (v) => _form26asFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Deduction Proofs', _deductionProofsFileName, (v) => _deductionProofsFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildBankCard(),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  List<Widget> _buildItr2Form() {
    return [
      GstFormCard(title: 'PAN & Aadhaar', icon: Icons.verified_user_outlined, child: Column(children: [
        _two(
          _buildTextField('PAN Card*', 'Mandatory', _panCtrl, _panValidator),
          _buildTextField('Aadhaar Number*', 'Mandatory', _aadhaarCtrl, _aadhaarValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Mobile Number*', 'OTP verification', _mobileCtrl, _mobileValidator),
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Income Details', icon: Icons.analytics_outlined, child: Column(children: [
        _two(
          _buildTextField('Salary / Pension*', 'Salary or pension income', _salaryCtrl, _requiredValidator),
          _buildTextField('Capital Gains', 'Shares, MF, property sale', _capitalGainsCtrl),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('House Property Income', 'Multiple properties allowed', _housePropertyCtrl),
          _buildTextField('Foreign Income / Assets', 'If applicable', _foreignIncomeCtrl),
        ),
        const SizedBox(height: 20),
        _buildFyDropdown(),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _buildFileField('Form 26AS / AIS', _form26asFileName, (v) => _form26asFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Capital Gains Statement', _capitalGainsFileName, (v) => _capitalGainsFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Foreign Income Docs', _foreignIncomeFileName, (v) => _foreignIncomeFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildBankCard(),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  List<Widget> _buildItr3Form() {
    return [
      GstFormCard(title: 'PAN & Aadhaar', icon: Icons.verified_user_outlined, child: Column(children: [
        _two(
          _buildTextField('PAN Card*', 'Mandatory', _panCtrl, _panValidator),
          _buildTextField('Aadhaar Number*', 'Mandatory', _aadhaarCtrl, _aadhaarValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Mobile Number*', 'OTP verification', _mobileCtrl, _mobileValidator),
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Business / Professional Income', icon: Icons.business_center_outlined, child: Column(children: [
        _two(
          _buildTextField('Business / Professional Income*', 'Required', _businessIncomeCtrl, _requiredValidator),
          _buildTextField('GSTIN (if applicable)', 'GST registration number', _gstinCtrl),
        ),
        const SizedBox(height: 20),
        _buildFyDropdown(),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _buildFileField('Profit & Loss Statement', _plStatementFileName, (v) => _plStatementFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Balance Sheet', _balanceSheetFileName, (v) => _balanceSheetFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Bank Statements', _bankStmtsFileName, (v) => _bankStmtsFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Form 26AS / AIS', _form26asFileName, (v) => _form26asFileName = v),
        const SizedBox(height: 14),
        _buildFileField('GST Returns (if applicable)', _gstFileName, (v) => _gstFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildBankCard(),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  List<Widget> _buildItr4Form() {
    return [
      GstFormCard(title: 'PAN & Aadhaar', icon: Icons.verified_user_outlined, child: Column(children: [
        _two(
          _buildTextField('PAN Card*', 'Mandatory', _panCtrl, _panValidator),
          _buildTextField('Aadhaar Number*', 'Mandatory', _aadhaarCtrl, _aadhaarValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Mobile Number*', 'OTP verification', _mobileCtrl, _mobileValidator),
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Presumptive Business Income', icon: Icons.receipt_outlined, child: Column(children: [
        _two(
          _buildTextField('Presumptive Business Income*', 'Required', _presumptiveIncomeCtrl, _requiredValidator),
          _buildTextField('Business Turnover*', 'Required', _businessTurnoverCtrl, _requiredValidator),
        ),
        const SizedBox(height: 20),
        _buildFyDropdown(),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _buildFileField('Form 26AS / AIS', _form26asFileName, (v) => _form26asFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Deduction Proofs', _deductionProofsFileName, (v) => _deductionProofsFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildBankCard(),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  List<Widget> _buildItr5Form() {
    return [
      GstFormCard(title: 'Entity Details', icon: Icons.business_outlined, child: Column(children: [
        _two(
          _buildTextField('PAN Card*', 'Mandatory', _panCtrl, _panValidator),
          _buildTextField('Entity Name*', 'Partnership / Entity name', _entityNameCtrl, _requiredValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Entity PAN*', 'PAN of firm/entity', _entityPanCtrl, _panValidator),
          _buildTextField('Mobile Number*', 'Contact number', _mobileCtrl, _mobileValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
          const SizedBox(),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Financial Details', icon: Icons.analytics_outlined, child: Column(children: [
        _two(
          _buildTextField('Turnover / Income', 'Annual turnover', _turnoverCtrl),
          _buildTextField('GSTIN (if applicable)', 'GST number', _gstinCtrl),
        ),
        const SizedBox(height: 20),
        _buildFyDropdown(),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _buildFileField('Balance Sheet', _balanceSheetFileName, (v) => _balanceSheetFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Profit & Loss Statement', _plStatementFileName, (v) => _plStatementFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Audit Report (if applicable)', _auditReportFileName, (v) => _auditReportFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Bank Statements', _bankStmtsFileName, (v) => _bankStmtsFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Form 26AS', _form26asFileName, (v) => _form26asFileName = v),
        const SizedBox(height: 14),
        _buildFileField('GST Returns (if applicable)', _gstFileName, (v) => _gstFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  List<Widget> _buildItr6Form() {
    return [
      GstFormCard(title: 'Company Details', icon: Icons.corporate_fare_outlined, child: Column(children: [
        _two(
          _buildTextField('PAN Card*', 'Company PAN', _panCtrl, _panValidator),
          _buildTextField('Company Name*', 'Registered company name', _companyNameCtrl, _requiredValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('CIN*', 'Corporate Identification Number', _cinCtrl, _requiredValidator),
          _buildTextField('Mobile Number*', 'Contact number', _mobileCtrl, _mobileValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
          const SizedBox(),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Financial Details', icon: Icons.analytics_outlined, child: Column(children: [
        _two(
          _buildTextField('Turnover / Income', 'Annual turnover', _turnoverCtrl),
          _buildTextField('TDS Details', 'Tax deducted details', _tdsCtrl),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('GSTIN (if applicable)', 'GST number', _gstinCtrl),
          const SizedBox(),
        ),
        const SizedBox(height: 20),
        _buildFyDropdown(),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _buildFileField('Balance Sheet', _balanceSheetFileName, (v) => _balanceSheetFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Profit & Loss Statement', _plStatementFileName, (v) => _plStatementFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Audit Report (mandatory if audited)', _auditReportFileName, (v) => _auditReportFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Form 26AS', _form26asFileName, (v) => _form26asFileName = v),
        const SizedBox(height: 14),
        _buildFileField('TDS Certificates', _tdsFileName, (v) => _tdsFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Digital Signature', _digitalSignatureFileName, (v) => _digitalSignatureFileName = v),
        const SizedBox(height: 14),
        _buildFileField('GST Returns (if applicable)', _gstFileName, (v) => _gstFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  List<Widget> _buildItr7Form() {
    return [
      GstFormCard(title: 'Trust / Institution Details', icon: Icons.volunteer_activism_outlined, child: Column(children: [
        _two(
          _buildTextField('PAN Card*', 'Trust PAN', _panCtrl, _panValidator),
          _buildTextField('Trust / Institution Name*', 'Registered name', _trustNameCtrl, _requiredValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Registration Number*', 'Trust/NGO registration no.', _registrationNoCtrl, _requiredValidator),
          _buildTextField('Mobile Number*', 'Contact number', _mobileCtrl, _mobileValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
          const SizedBox(),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Financial & Donation Details', icon: Icons.analytics_outlined, child: Column(children: [
        _two(
          _buildTextField('Donation Details*', 'Required', _donationDetailsCtrl, _requiredValidator),
          const SizedBox(),
        ),
        const SizedBox(height: 20),
        _buildFyDropdown(),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _buildFileField('Registration Certificates', _registrationCertFileName, (v) => _registrationCertFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Balance Sheet', _balanceSheetFileName, (v) => _balanceSheetFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Income & Expenditure Statement', _incomeExpenditureFileName, (v) => _incomeExpenditureFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Audit Report (if applicable)', _auditReportFileName, (v) => _auditReportFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Donation Receipts', _donationFileName, (v) => _donationFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Bank Statements', _bankStmtsFileName, (v) => _bankStmtsFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  List<Widget> _buildNoticeForm() {
    return [
      GstFormCard(title: 'PAN & Notice Details', icon: Icons.mail_outline, child: Column(children: [
        _two(
          _buildTextField('PAN Card*', 'Mandatory', _panCtrl, _panValidator),
          _buildTextField('Aadhaar Number*', 'Mandatory', _aadhaarCtrl, _aadhaarValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Notice Number*', 'Copy reference number', _noticeNoCtrl, _requiredValidator),
          _buildTextField('Assessment Year*', 'e.g. 2025-26', _assessmentYearCtrl, _requiredValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Mobile Number*', 'Contact number', _mobileCtrl, _mobileValidator),
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Response Details', icon: Icons.description_outlined, child: Column(children: [
        _sectionLabel('Response Explanation'),
        const SizedBox(height: 10),
        _buildTextArea(),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _buildFileField('Copy of Notice', _noticeFileName, (v) => _noticeFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Form 16 / ITR Copy', _itrCopyFileName, (v) => _itrCopyFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Supporting Documents', _supportingDocsFileName, (v) => _supportingDocsFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Bank Statements (if requested)', _bankStmtsFileName, (v) => _bankStmtsFileName = v),
        const SizedBox(height: 14),
        _buildFileField('Income Proofs', _incomeProofsFileName, (v) => _incomeProofsFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  List<Widget> _buildGenericForm() {
    return [
      GstFormCard(title: 'Personal Information', icon: Icons.person_outline, child: Column(children: [
        _two(
          _buildTextField('Applicant Name*', 'Full name as per PAN', _panCtrl, (v) {
            if (v == null || v.trim().isEmpty) return 'Required';
            if (v.trim().length < 3) return 'Min 3 characters';
            return null;
          }),
          _buildTextField('PAN*', 'Permanent Account Number', _panCtrl, _panValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Aadhaar Number*', 'Aadhaar of taxpayer', _aadhaarCtrl, _aadhaarValidator),
          _buildTextField('Mobile Number*', 'Contact number', _mobileCtrl, _mobileValidator),
        ),
        const SizedBox(height: 20),
        _two(
          _buildTextField('Email ID*', 'Communication purpose', _emailCtrl, _emailValidator),
          const SizedBox(),
        ),
      ])),
      const SizedBox(height: 20),
      GstFormCard(title: 'Documents Upload', icon: Icons.upload_file_outlined, child: Column(children: [
        _sectionLabel('Upload supporting documents'),
        const SizedBox(height: 6),
        const Text(
          'Form 16, bank statements, capital gain statements, P&L, audit report, donation receipts (PDF, JPG, PNG)',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
        ),
        const SizedBox(height: 10),
        _buildFileField('Supporting Documents', _form26asFileName, (v) => _form26asFileName = v),
      ])),
      const SizedBox(height: 20),
      _buildAdditionalCard(),
    ];
  }

  Widget _buildBankCard() {
    return GstFormCard(title: 'Bank Account Details (Refund Processing)', icon: Icons.account_balance_outlined, child: Column(children: [
      _two(
        _buildTextField('Account Holder Name*', 'Name as per bank records', _accountHolderCtrl, _requiredValidator),
        _buildTextField('Account Number*', 'Account number', _bankAccountCtrl, _accountValidator),
      ),
      const SizedBox(height: 20),
      _two(
        _buildTextField('Confirm Account Number*', 'Re-enter account number', _confirmAccountCtrl, (v) {
          if (v == null || v.trim().isEmpty) return 'Mandatory';
          if (v.trim() != _bankAccountCtrl.text) return 'Account number mismatch';
          return null;
        }),
        _buildTextField('IFSC Code*', 'e.g. SBIN0001234', _ifscCtrl, _ifscValidator),
      ),
      const SizedBox(height: 20),
      _buildTextField('Bank Name*', 'Name of the bank', _bankNameCtrl, _requiredValidator),
    ]));
  }

  Widget _buildAdditionalCard() {
    return GstFormCard(title: 'Additional Information', icon: Icons.notes_outlined, child: Column(children: [
      _sectionLabel('Additional Notes'),
      const SizedBox(height: 10),
      _buildTextArea(),
    ]));
  }

  Widget _buildTextField(String label, String hint, TextEditingController ctrl, [String? Function(String?)? validator, IconData? icon]) {
    final hasAsterisk = label.endsWith('*');
    final cleanLabel = hasAsterisk ? label.substring(0, label.length - 1) : label;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildLabel(cleanLabel, hasAsterisk),
      const SizedBox(height: 6),
      TextFormField(
        controller: ctrl,
        validator: validator,
        textCapitalization: label.contains('PAN') ? TextCapitalization.characters : TextCapitalization.none,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
          contentPadding: EdgeInsets.symmetric(horizontal: icon != null ? 14 : 14, vertical: 12),
          prefixIcon: icon != null ? Icon(icon, size: 18, color: const Color(0xFF6B7280)) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.brandBlue, width: 2),
          ),
          filled: true,
          fillColor: AppColors.white,
        ),
        style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
      ),
    ]);
  }

  Widget _buildFileField(String label, String? fileName, ValueChanged<String> onPicked) {
    return GstFileField(label: label, icon: Icons.upload_file, fileName: fileName, onFilePicked: onPicked);
  }

  Widget _buildFyDropdown() {
    return GstDropdownField(
      label: 'Financial Year',
      icon: Icons.calendar_today,
      placeholder: 'Select financial year',
      value: _financialYear,
      items: _financialYears,
      required: true,
      onChanged: (v) => setState(() => _financialYear = v),
    );
  }

  Widget _buildTextArea() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        maxLines: 3,
        controller: _descriptionCtrl,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12),
          hintText: 'Any additional information...',
          hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
        ),
        style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
      ),
    );
  }

  Widget _buildAcknowledgement() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.infoBorder),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20, height: 20,
            child: Checkbox(
              value: _acknowledge,
              onChanged: (v) => setState(() => _acknowledge = v ?? false),
              activeColor: AppColors.brandBlue,
              side: const BorderSide(color: Color(0xFFD1D5DB)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'I confirm that the information provided is accurate and complete to the best of my knowledge.',
              style: const TextStyle(color: Color(0xFF475569), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, bool hasAsterisk) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(color: Color(0xFF374151), fontSize: 13, fontWeight: FontWeight.w500),
          ),
          if (hasAsterisk)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
            ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        Text(text, style: const TextStyle(color: Color(0xFF1F2937), fontSize: 13, fontWeight: FontWeight.w500)),
        const Text(' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 13)),
      ],
    );
  }

  Widget _two(Widget left, Widget right) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }

  String? _requiredValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mandatory';
    return null;
  }

  String? _panValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mandatory';
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(v.trim().toUpperCase())) return 'Invalid PAN';
    return null;
  }

  String? _aadhaarValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mandatory';
    if (!RegExp(r'^\d{12}$').hasMatch(v.trim())) return 'Invalid Aadhaar';
    return null;
  }

  String? _mobileValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mandatory';
    if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Invalid 10-digit number';
    return null;
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mandatory';
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Invalid email';
    return null;
  }

  String? _accountValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mandatory';
    if (v.trim().length < 9 || v.trim().length > 18) return 'Invalid account number';
    if (!RegExp(r'^\d{9,18}$').hasMatch(v.trim())) return 'Only digits allowed';
    return null;
  }

  String? _ifscValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mandatory';
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(v.trim().toUpperCase())) return 'Invalid IFSC';
    return null;
  }

  void _submitForm() {
    final valid = _formKey.currentState!.validate();
    if (!valid) return;

    bool docsOk = true;
    if (_isItr1) docsOk = _form16FileName != null && _form26asFileName != null && _deductionProofsFileName != null;
    else if (_isItr2) docsOk = _form26asFileName != null;
    else if (_isItr3) docsOk = _plStatementFileName != null && _balanceSheetFileName != null && _bankStmtsFileName != null && _form26asFileName != null;
    else if (_isItr4) docsOk = _form26asFileName != null && _deductionProofsFileName != null;
    else if (_isItr5) docsOk = _balanceSheetFileName != null && _plStatementFileName != null && _form26asFileName != null;
    else if (_isItr6) docsOk = _balanceSheetFileName != null && _plStatementFileName != null && _form26asFileName != null && _digitalSignatureFileName != null;
    else if (_isItr7) docsOk = _registrationCertFileName != null && _balanceSheetFileName != null && _incomeExpenditureFileName != null;
    else if (_isNotice) docsOk = _noticeFileName != null && _itrCopyFileName != null;
    else docsOk = _form26asFileName != null;

    if (!docsOk) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload all mandatory documents')),
      );
      return;
    }

    if (!_acknowledge) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm the acknowledgement')),
      );
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
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Application Submitted!',
                  style: TextStyle(color: Color(0xFF1A1F2E), fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                const Text(
                  'We have received your ITR application. Our team will review and get back to you within 7\u201330 working days.',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back to Income Tax Services',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
