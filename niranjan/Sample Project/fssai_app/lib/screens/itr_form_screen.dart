import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ItrForm extends StatefulWidget {
  final VoidCallback? onSubmit;
  final int itrType;

  const ItrForm({super.key, this.onSubmit, required this.itrType});

  @override
  State<ItrForm> createState() => _ItrFormState();
}

class _ItrFormState extends State<ItrForm> {
  final _formKey = GlobalKey<FormState>();

  // ─── Shared controllers ───
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

  // ─── ITR-1 controllers ───
  final _salaryCtrl = TextEditingController();
  final _pensionCtrl = TextEditingController();
  final _interestCtrl = TextEditingController();

  // ─── ITR-2 controllers ───
  final _capitalGainsCtrl = TextEditingController();
  final _housePropertyCtrl = TextEditingController();
  final _foreignIncomeCtrl = TextEditingController();

  // ─── ITR-3 controllers ───
  final _businessIncomeCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();

  // ─── ITR-4 controllers ───
  final _presumptiveIncomeCtrl = TextEditingController();
  final _businessTurnoverCtrl = TextEditingController();

  // ─── ITR-5 controllers ───
  final _entityNameCtrl = TextEditingController();
  final _entityPanCtrl = TextEditingController();

  // ─── ITR-6 controllers ───
  final _companyNameCtrl = TextEditingController();
  final _cinCtrl = TextEditingController();
  final _tdsCtrl = TextEditingController();

  // ─── ITR-7 controllers ───
  final _trustNameCtrl = TextEditingController();
  final _registrationNoCtrl = TextEditingController();
  final _donationDetailsCtrl = TextEditingController();

  // ─── Notice Response controllers ───
  final _noticeNoCtrl = TextEditingController();
  final _assessmentYearCtrl = TextEditingController();
  final _responseExplanationCtrl = TextEditingController();
  final _incomeProofCtrl = TextEditingController();

  String? _financialYear;
  bool _acknowledge = false;
  bool _triedSubmit = false;

  // ─── File uploads ───
  PlatformFile? _form26asFile, _form16File, _deductionProofsFile;
  PlatformFile? _capitalGainsFile, _foreignIncomeFile;
  PlatformFile? _plStatementFile, _balanceSheetFile, _bankStmtsFile, _auditReportFile, _gstFile;
  PlatformFile? _digitalSignatureFile, _tdsFile;
  PlatformFile? _registrationCertFile, _donationFile, _incomeExpenditureFile;
  PlatformFile? _noticeFile, _itrCopyFile, _supportingDocsFile, _incomeProofsFile;

  // ─── ITR static data ───

  static const _itrTitles = [
    'ITR Filing – General (All Types)',
    'ITR-1 Filing (Sahaj) — Salaried Individuals',
    'ITR-2 Filing — Individuals/HUF (No Business)',
    'ITR-3 Filing — Business/Profession Income',
    'ITR-4 Filing (Sugam) — Presumptive Income',
    'ITR-5 Filing — Firms/LLPs/AOPs/BOIs',
    'ITR-6 Filing — Companies',
    'ITR-7 Filing — Trusts & Charitable Institutions',
    'Income Tax Notice Response',
  ];

  static const _itrDescriptions = [
    'For all types of ITR filing from ITR-1 to ITR-7 — Select your specific ITR type',
    'For salaried individuals with income from salary, one house property, and other sources',
    'For individuals and HUFs with capital gains, house property, and foreign income',
    'For individuals and HUFs carrying on business or profession',
    'For individuals, HUFs, and firms opting for presumptive taxation scheme',
    'For firms, LLPs, AOPs, BOIs, and artificial juridical persons',
    'For companies registered under the Companies Act',
    'For trusts, charitable institutions, political parties, and similar entities',
    'Respond to notices received from the Income Tax Department',
  ];

  static const _icons = [
    Icons.assignment_outlined,
    Icons.person_outline,
    Icons.person_2_outlined,
    Icons.business_center_outlined,
    Icons.receipt_outlined,
    Icons.business_outlined,
    Icons.corporate_fare_outlined,
    Icons.volunteer_activism_outlined,
    Icons.mail_outline,
  ];

  String get _title => _itrTitles[widget.itrType];
  String get _description => _itrDescriptions[widget.itrType];
  IconData get _icon => _icons[widget.itrType];

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
      _noticeNoCtrl, _assessmentYearCtrl, _responseExplanationCtrl, _incomeProofCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _isItr1 => widget.itrType == 0;
  bool get _isItr2 => widget.itrType == 1;
  bool get _isItr3 => widget.itrType == 2;
  bool get _isItr4 => widget.itrType == 3;
  bool get _isItr5 => widget.itrType == 4;
  bool get _isItr6 => widget.itrType == 5;
  bool get _isItr7 => widget.itrType == 6;
  bool get _isNotice => widget.itrType == 7;
  bool get _isGeneral => widget.itrType == 8;

  // ─── Build ───

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 28),
          if (_isItr1) ..._buildItr1Form()
          else if (_isItr2) ..._buildItr2Form()
          else if (_isItr3) ..._buildItr3Form()
          else if (_isItr4) ..._buildItr4Form()
          else if (_isItr5) ..._buildItr5Form()
          else if (_isItr6) ..._buildItr6Form()
          else if (_isItr7) ..._buildItr7Form()
          else if (_isNotice) ..._buildNoticeForm()
          else ..._buildGenericForm(),
          const SizedBox(height: 16),
          _buildAcknowledgement(),
          const SizedBox(height: 28),
          _buildActionButtons(),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(children: [
      Icon(_icon, size: 28, color: const Color(0xFF3B82F6)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(_title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 23, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(_description, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
      ])),
    ]);
  }

  // ═══════════════════════════════════════════
  //  FORM BUILDERS PER ITR TYPE
  // ═══════════════════════════════════════════

  List<Widget> _buildItr1Form() {
    return [
      _card('PAN & Aadhaar', Icons.verified_user_outlined, [
        _two(_field('PAN Card', Icons.badge_outlined, 'Mandatory', _panCtrl, _panValidator),
             _field('Aadhaar Number', Icons.fingerprint, 'Mandatory', _aadhaarCtrl, _aadhaarValidator)),
        const SizedBox(height: 20),
        _two(_field('Mobile Number', Icons.phone_outlined, 'OTP verification', _mobileCtrl, _mobileValidator),
             _field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator)),
      ]),
      const SizedBox(height: 20),
      _card('Income Details', Icons.analytics_outlined, [
        _label('Enter your income details'),
        const SizedBox(height: 10),
        _two(_field('Salary', Icons.work_outline, 'Salary income', _salaryCtrl),
             _field('Pension', Icons.account_balance_outlined, 'Pension income', _pensionCtrl)),
        const SizedBox(height: 20),
        _field('Interest Income', Icons.monetization_on_outlined, 'Interest from bank, FD, etc.', _interestCtrl),
        const SizedBox(height: 20),
        _fyDropdown(),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _docRow('Form 16', 'Salary details (PDF, JPG, PNG)', () => _pickDoc((f) => _form16File = f, ['pdf','jpg','jpeg','png']), _form16File, () => _form16File = null),
        const SizedBox(height: 14),
        _docRow('Form 26AS / AIS', 'Tax details verification (PDF)', () => _pickDoc((f) => _form26asFile = f, ['pdf']), _form26asFile, () => _form26asFile = null),
        const SizedBox(height: 14),
        _docRow('Deduction Proofs', '80C, 80D, etc. (PDF, JPG, PNG)', () => _pickDoc((f) => _deductionProofsFile = f, ['pdf','jpg','jpeg','png']), _deductionProofsFile, () => _deductionProofsFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Bank Account Details (Refund Processing)', Icons.account_balance_outlined, [
        _two(_field('Account Holder Name', Icons.person_outline, 'Name as per bank records', _accountHolderCtrl, _requiredValidator),
             _field('Account Number', Icons.pin_outlined, 'Account number', _bankAccountCtrl, _accountValidator)),
        const SizedBox(height: 20),
        _two(_field('Confirm Account Number', Icons.pin_outlined, 'Re-enter account number', _confirmAccountCtrl, (v) {
          if (v == null || v.trim().isEmpty) return 'Mandatory';
          if (v.trim() != _bankAccountCtrl.text) return 'Account number mismatch';
          return null;
        }), _field('IFSC Code', Icons.code_outlined, 'e.g. SBIN0001234', _ifscCtrl, _ifscValidator)),
        const SizedBox(height: 20),
        _field('Bank Name', Icons.business_outlined, 'Name of the bank', _bankNameCtrl, _requiredValidator),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [
        _label('Additional Notes'),
        const SizedBox(height: 10), _textArea(),
      ]),
    ];
  }

  List<Widget> _buildItr2Form() {
    return [
      _card('PAN & Aadhaar', Icons.verified_user_outlined, [
        _two(_field('PAN Card', Icons.badge_outlined, 'Mandatory', _panCtrl, _panValidator),
             _field('Aadhaar Number', Icons.fingerprint, 'Mandatory', _aadhaarCtrl, _aadhaarValidator)),
        const SizedBox(height: 20),
        _two(_field('Mobile Number', Icons.phone_outlined, 'OTP verification', _mobileCtrl, _mobileValidator),
             _field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator)),
      ]),
      const SizedBox(height: 20),
      _card('Income Details', Icons.analytics_outlined, [
        _two(_field('Salary / Pension', Icons.work_outline, 'Salary or pension income', _salaryCtrl, _requiredValidator),
             _field('Capital Gains', Icons.trending_up_outlined, 'Shares, mutual funds, property sale', _capitalGainsCtrl)),
        const SizedBox(height: 20),
        _two(_field('House Property Income', Icons.home_outlined, 'Multiple properties allowed', _housePropertyCtrl),
             _field('Foreign Income / Assets', Icons.public_outlined, 'If applicable', _foreignIncomeCtrl)),
        const SizedBox(height: 20),
        _field('Form 26AS / AIS', Icons.receipt_outlined, 'Tax verification details', _turnoverCtrl),
        const SizedBox(height: 20),
        _fyDropdown(),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _docRow('Form 26AS / AIS', 'Tax verification (PDF)', () => _pickDoc((f) => _form26asFile = f, ['pdf']), _form26asFile, () => _form26asFile = null),
        const SizedBox(height: 14),
        _docRow('Capital Gains Statement', 'Shares, mutual funds reports (PDF)', () => _pickDoc((f) => _capitalGainsFile = f, ['pdf','jpg','jpeg','png']), _capitalGainsFile, () => _capitalGainsFile = null),
        const SizedBox(height: 14),
        _docRow('Foreign Income Docs', 'If applicable (PDF)', () => _pickDoc((f) => _foreignIncomeFile = f, ['pdf','jpg','jpeg','png']), _foreignIncomeFile, () => _foreignIncomeFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Bank Account Details (Refund Processing)', Icons.account_balance_outlined, [
        _two(_field('Account Holder Name', Icons.person_outline, 'Name as per bank records', _accountHolderCtrl, _requiredValidator),
             _field('Account Number', Icons.pin_outlined, 'Account number', _bankAccountCtrl, _accountValidator)),
        const SizedBox(height: 20),
        _two(_field('Confirm Account Number', Icons.pin_outlined, 'Re-enter account number', _confirmAccountCtrl, (v) {
          if (v == null || v.trim().isEmpty) return 'Mandatory';
          if (v.trim() != _bankAccountCtrl.text) return 'Account number mismatch';
          return null;
        }), _field('IFSC Code', Icons.code_outlined, 'e.g. SBIN0001234', _ifscCtrl, _ifscValidator)),
        const SizedBox(height: 20),
        _field('Bank Name', Icons.business_outlined, 'Name of the bank', _bankNameCtrl, _requiredValidator),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [_label('Additional Notes'), const SizedBox(height: 10), _textArea()]),
    ];
  }

  List<Widget> _buildItr3Form() {
    return [
      _card('PAN & Aadhaar', Icons.verified_user_outlined, [
        _two(_field('PAN Card', Icons.badge_outlined, 'Mandatory', _panCtrl, _panValidator),
             _field('Aadhaar Number', Icons.fingerprint, 'Mandatory', _aadhaarCtrl, _aadhaarValidator)),
        const SizedBox(height: 20),
        _two(_field('Mobile Number', Icons.phone_outlined, 'OTP verification', _mobileCtrl, _mobileValidator),
             _field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator)),
      ]),
      const SizedBox(height: 20),
      _card('Business / Professional Income', Icons.business_center_outlined, [
        _two(_field('Business / Professional Income', Icons.monetization_on_outlined, 'Required', _businessIncomeCtrl, _requiredValidator),
             _field('GSTIN (if applicable)', Icons.receipt_outlined, 'GST registration number', _gstinCtrl)),
        const SizedBox(height: 20),
        _fyDropdown(),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _docRow('Profit & Loss Statement', 'Business income details (PDF)', () => _pickDoc((f) => _plStatementFile = f, ['pdf','jpg','jpeg','png']), _plStatementFile, () => _plStatementFile = null),
        const SizedBox(height: 14),
        _docRow('Balance Sheet', 'Financial details (PDF)', () => _pickDoc((f) => _balanceSheetFile = f, ['pdf','jpg','jpeg','png']), _balanceSheetFile, () => _balanceSheetFile = null),
        const SizedBox(height: 14),
        _docRow('Bank Statements', 'Business transactions (PDF)', () => _pickDoc((f) => _bankStmtsFile = f, ['pdf']), _bankStmtsFile, () => _bankStmtsFile = null),
        const SizedBox(height: 14),
        _docRow('Form 26AS / AIS', 'Tax verification (PDF)', () => _pickDoc((f) => _form26asFile = f, ['pdf']), _form26asFile, () => _form26asFile = null),
        const SizedBox(height: 14),
        _docRow('GST Returns (if applicable)', 'GST filing details (PDF)', () => _pickDoc((f) => _gstFile = f, ['pdf']), _gstFile, () => _gstFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Bank Account Details (Refund Processing)', Icons.account_balance_outlined, [
        _two(_field('Account Holder Name', Icons.person_outline, 'Name as per bank records', _accountHolderCtrl, _requiredValidator),
             _field('Account Number', Icons.pin_outlined, 'Account number', _bankAccountCtrl, _accountValidator)),
        const SizedBox(height: 20),
        _two(_field('Confirm Account Number', Icons.pin_outlined, 'Re-enter account number', _confirmAccountCtrl, (v) {
          if (v == null || v.trim().isEmpty) return 'Mandatory';
          if (v.trim() != _bankAccountCtrl.text) return 'Account number mismatch';
          return null;
        }), _field('IFSC Code', Icons.code_outlined, 'e.g. SBIN0001234', _ifscCtrl, _ifscValidator)),
        const SizedBox(height: 20),
        _field('Bank Name', Icons.business_outlined, 'Name of the bank', _bankNameCtrl, _requiredValidator),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [_label('Additional Notes'), const SizedBox(height: 10), _textArea()]),
    ];
  }

  List<Widget> _buildItr4Form() {
    return [
      _card('PAN & Aadhaar', Icons.verified_user_outlined, [
        _two(_field('PAN Card', Icons.badge_outlined, 'Mandatory', _panCtrl, _panValidator),
             _field('Aadhaar Number', Icons.fingerprint, 'Mandatory', _aadhaarCtrl, _aadhaarValidator)),
        const SizedBox(height: 20),
        _two(_field('Mobile Number', Icons.phone_outlined, 'OTP verification', _mobileCtrl, _mobileValidator),
             _field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator)),
      ]),
      const SizedBox(height: 20),
      _card('Presumptive Business Income', Icons.receipt_outlined, [
        _two(_field('Presumptive Business Income', Icons.monetization_on_outlined, 'Required', _presumptiveIncomeCtrl, _requiredValidator),
             _field('Business Turnover', Icons.trending_up_outlined, 'Required', _businessTurnoverCtrl, _requiredValidator)),
        const SizedBox(height: 20),
        _fyDropdown(),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _docRow('Form 26AS / AIS', 'Tax verification (PDF)', () => _pickDoc((f) => _form26asFile = f, ['pdf']), _form26asFile, () => _form26asFile = null),
        const SizedBox(height: 14),
        _docRow('Deduction Proofs', '80C, 80D, etc. (PDF, JPG, PNG)', () => _pickDoc((f) => _deductionProofsFile = f, ['pdf','jpg','jpeg','png']), _deductionProofsFile, () => _deductionProofsFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Bank Account Details (Refund Processing)', Icons.account_balance_outlined, [
        _two(_field('Account Holder Name', Icons.person_outline, 'Name as per bank records', _accountHolderCtrl, _requiredValidator),
             _field('Account Number', Icons.pin_outlined, 'Account number', _bankAccountCtrl, _accountValidator)),
        const SizedBox(height: 20),
        _two(_field('Confirm Account Number', Icons.pin_outlined, 'Re-enter account number', _confirmAccountCtrl, (v) {
          if (v == null || v.trim().isEmpty) return 'Mandatory';
          if (v.trim() != _bankAccountCtrl.text) return 'Account number mismatch';
          return null;
        }), _field('IFSC Code', Icons.code_outlined, 'e.g. SBIN0001234', _ifscCtrl, _ifscValidator)),
        const SizedBox(height: 20),
        _field('Bank Name', Icons.business_outlined, 'Name of the bank', _bankNameCtrl, _requiredValidator),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [_label('Additional Notes'), const SizedBox(height: 10), _textArea()]),
    ];
  }

  List<Widget> _buildItr5Form() {
    return [
      _card('Entity Details', Icons.business_outlined, [
        _two(_field('PAN Card', Icons.badge_outlined, 'Mandatory', _panCtrl, _panValidator),
             _field('Entity Name', Icons.business_outlined, 'Partnership / Entity name', _entityNameCtrl, _requiredValidator)),
        const SizedBox(height: 20),
        _two(_field('Entity PAN', Icons.badge_outlined, 'PAN of firm/entity', _entityPanCtrl, _panValidator),
             _field('Mobile Number', Icons.phone_outlined, 'Contact number', _mobileCtrl, _mobileValidator)),
        const SizedBox(height: 20),
        _two(_field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator),
             const SizedBox()),
      ]),
      const SizedBox(height: 20),
      _card('Financial Details', Icons.analytics_outlined, [
        _two(_field('Turnover / Income', Icons.monetization_on_outlined, 'Annual turnover', _turnoverCtrl),
             _field('GSTIN (if applicable)', Icons.receipt_outlined, 'GST number', _gstinCtrl)),
        const SizedBox(height: 20),
        _fyDropdown(),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _docRow('Balance Sheet', 'Financial details (PDF)', () => _pickDoc((f) => _balanceSheetFile = f, ['pdf','jpg','jpeg','png']), _balanceSheetFile, () => _balanceSheetFile = null),
        const SizedBox(height: 14),
        _docRow('Profit & Loss Statement', 'Income details (PDF)', () => _pickDoc((f) => _plStatementFile = f, ['pdf','jpg','jpeg','png']), _plStatementFile, () => _plStatementFile = null),
        const SizedBox(height: 14),
        _docRow('Audit Report (if applicable)', 'Audited statements (PDF)', () => _pickDoc((f) => _auditReportFile = f, ['pdf']), _auditReportFile, () => _auditReportFile = null),
        const SizedBox(height: 14),
        _docRow('Bank Statements', 'Transaction verification (PDF)', () => _pickDoc((f) => _bankStmtsFile = f, ['pdf']), _bankStmtsFile, () => _bankStmtsFile = null),
        const SizedBox(height: 14),
        _docRow('Form 26AS', 'Tax verification (PDF)', () => _pickDoc((f) => _form26asFile = f, ['pdf']), _form26asFile, () => _form26asFile = null),
        const SizedBox(height: 14),
        _docRow('GST Returns (if applicable)', 'GST filing (PDF)', () => _pickDoc((f) => _gstFile = f, ['pdf']), _gstFile, () => _gstFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [_label('Additional Notes'), const SizedBox(height: 10), _textArea()]),
    ];
  }

  List<Widget> _buildItr6Form() {
    return [
      _card('Company Details', Icons.corporate_fare_outlined, [
        _two(_field('PAN Card', Icons.badge_outlined, 'Company PAN', _panCtrl, _panValidator),
             _field('Company Name', Icons.business_outlined, 'Registered company name', _companyNameCtrl, _requiredValidator)),
        const SizedBox(height: 20),
        _two(_field('CIN', Icons.code_outlined, 'Corporate Identification Number', _cinCtrl, _requiredValidator),
             _field('Mobile Number', Icons.phone_outlined, 'Contact number', _mobileCtrl, _mobileValidator)),
        const SizedBox(height: 20),
        _two(_field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator),
             const SizedBox()),
      ]),
      const SizedBox(height: 20),
      _card('Financial Details', Icons.analytics_outlined, [
        _two(_field('Turnover / Income', Icons.monetization_on_outlined, 'Annual turnover', _turnoverCtrl),
             _field('TDS Details', Icons.receipt_outlined, 'Tax deducted details', _tdsCtrl)),
        const SizedBox(height: 20),
        _two(_field('GSTIN (if applicable)', Icons.receipt_outlined, 'GST number', _gstinCtrl),
             const SizedBox()),
        const SizedBox(height: 20),
        _fyDropdown(),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _docRow('Balance Sheet', 'Company financials (PDF)', () => _pickDoc((f) => _balanceSheetFile = f, ['pdf','jpg','jpeg','png']), _balanceSheetFile, () => _balanceSheetFile = null),
        const SizedBox(height: 14),
        _docRow('Profit & Loss Statement', 'Income details (PDF)', () => _pickDoc((f) => _plStatementFile = f, ['pdf','jpg','jpeg','png']), _plStatementFile, () => _plStatementFile = null),
        const SizedBox(height: 14),
        _docRow('Audit Report (mandatory if audited)', 'Audited statements (PDF)', () => _pickDoc((f) => _auditReportFile = f, ['pdf']), _auditReportFile, () => _auditReportFile = null),
        const SizedBox(height: 14),
        _docRow('Form 26AS', 'Tax verification (PDF)', () => _pickDoc((f) => _form26asFile = f, ['pdf']), _form26asFile, () => _form26asFile = null),
        const SizedBox(height: 14),
        _docRow('TDS Certificates', 'TDS details (PDF)', () => _pickDoc((f) => _tdsFile = f, ['pdf']), _tdsFile, () => _tdsFile = null),
        const SizedBox(height: 14),
        _docRow('Digital Signature', 'Mandatory for filing (PDF/Image)', () => _pickDoc((f) => _digitalSignatureFile = f, ['pdf','jpg','jpeg','png']), _digitalSignatureFile, () => _digitalSignatureFile = null),
        const SizedBox(height: 14),
        _docRow('GST Returns (if applicable)', 'GST filing (PDF)', () => _pickDoc((f) => _gstFile = f, ['pdf']), _gstFile, () => _gstFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [_label('Additional Notes'), const SizedBox(height: 10), _textArea()]),
    ];
  }

  List<Widget> _buildItr7Form() {
    return [
      _card('Trust / Institution Details', Icons.volunteer_activism_outlined, [
        _two(_field('PAN Card', Icons.badge_outlined, 'Trust PAN', _panCtrl, _panValidator),
             _field('Trust / Institution Name', Icons.business_outlined, 'Registered name', _trustNameCtrl, _requiredValidator)),
        const SizedBox(height: 20),
        _two(_field('Registration Number', Icons.assignment_outlined, 'Trust/NGO registration no.', _registrationNoCtrl, _requiredValidator),
             _field('Mobile Number', Icons.phone_outlined, 'Contact number', _mobileCtrl, _mobileValidator)),
        const SizedBox(height: 20),
        _two(_field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator),
             const SizedBox()),
      ]),
      const SizedBox(height: 20),
      _card('Financial & Donation Details', Icons.analytics_outlined, [
        _two(_field('Donation Details', Icons.card_giftcard_outlined, 'Required', _donationDetailsCtrl, _requiredValidator),
             const SizedBox()),
        const SizedBox(height: 20),
        _fyDropdown(),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _docRow('Registration Certificates', 'Trust/NGO approval proof (PDF)', () => _pickDoc((f) => _registrationCertFile = f, ['pdf','jpg','jpeg','png']), _registrationCertFile, () => _registrationCertFile = null),
        const SizedBox(height: 14),
        _docRow('Balance Sheet', 'Financial details (PDF)', () => _pickDoc((f) => _balanceSheetFile = f, ['pdf','jpg','jpeg','png']), _balanceSheetFile, () => _balanceSheetFile = null),
        const SizedBox(height: 14),
        _docRow('Income & Expenditure Statement', 'Required (PDF)', () => _pickDoc((f) => _incomeExpenditureFile = f, ['pdf','jpg','jpeg','png']), _incomeExpenditureFile, () => _incomeExpenditureFile = null),
        const SizedBox(height: 14),
        _docRow('Audit Report (if applicable)', 'Audited statements (PDF)', () => _pickDoc((f) => _auditReportFile = f, ['pdf']), _auditReportFile, () => _auditReportFile = null),
        const SizedBox(height: 14),
        _docRow('Donation Receipts', 'Donation proof (PDF)', () => _pickDoc((f) => _donationFile = f, ['pdf','jpg','jpeg','png']), _donationFile, () => _donationFile = null),
        const SizedBox(height: 14),
        _docRow('Bank Statements', 'Verification (PDF)', () => _pickDoc((f) => _bankStmtsFile = f, ['pdf']), _bankStmtsFile, () => _bankStmtsFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [_label('Additional Notes'), const SizedBox(height: 10), _textArea()]),
    ];
  }

  List<Widget> _buildNoticeForm() {
    return [
      _card('PAN & Notice Details', Icons.mail_outline, [
        _two(_field('PAN Card', Icons.badge_outlined, 'Mandatory', _panCtrl, _panValidator),
             _field('Aadhaar Number', Icons.fingerprint, 'Mandatory', _aadhaarCtrl, _aadhaarValidator)),
        const SizedBox(height: 20),
        _two(_field('Notice Number', Icons.note_outlined, 'Copy reference number', _noticeNoCtrl, _requiredValidator),
             _field('Assessment Year', Icons.calendar_today, 'e.g. 2025-26', _assessmentYearCtrl, _requiredValidator)),
        const SizedBox(height: 20),
        _two(_field('Mobile Number', Icons.phone_outlined, 'Contact number', _mobileCtrl, _mobileValidator),
             _field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator)),
      ]),
      const SizedBox(height: 20),
      _card('Response Details', Icons.description_outlined, [
        _label('Response Explanation'),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(7), border: Border.all(color: const Color(0xFFD1D5DB))),
          child: TextField(
            maxLines: 4, controller: _responseExplanationCtrl,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
              hintText: 'Clarification for department...',
              hintStyle: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
            ),
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
          ),
        ),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _docRow('Copy of Notice', 'Required (PDF)', () => _pickDoc((f) => _noticeFile = f, ['pdf','jpg','jpeg','png']), _noticeFile, () => _noticeFile = null),
        const SizedBox(height: 14),
        _docRow('Form 16 / ITR Copy', 'Verification (PDF)', () => _pickDoc((f) => _itrCopyFile = f, ['pdf']), _itrCopyFile, () => _itrCopyFile = null),
        const SizedBox(height: 14),
        _docRow('Supporting Documents', 'Based on notice type (PDF)', () => _pickDoc((f) => _supportingDocsFile = f, ['pdf','jpg','jpeg','png']), _supportingDocsFile, () => _supportingDocsFile = null),
        const SizedBox(height: 14),
        _docRow('Bank Statements (if requested)', 'Verification (PDF)', () => _pickDoc((f) => _bankStmtsFile = f, ['pdf']), _bankStmtsFile, () => _bankStmtsFile = null),
        const SizedBox(height: 14),
        _docRow('Income Proofs', 'Salary/business/capital gains (PDF)', () => _pickDoc((f) => _incomeProofsFile = f, ['pdf','jpg','jpeg','png']), _incomeProofsFile, () => _incomeProofsFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [_label('Additional Notes'), const SizedBox(height: 10), _textArea()]),
    ];
  }

  // ─── Generic form (for General selection) ───

  List<Widget> _buildGenericForm() {
    return [
      _card('Personal Information', Icons.person_outline, [
        _two(_field('Applicant Name', Icons.person_outline, 'Full name as per PAN', _panCtrl, (v) {
          if (v == null || v.trim().isEmpty) return 'Required';
          if (v.trim().length < 3) return 'Min 3 characters';
          return null;
        }), _field('PAN', Icons.badge_outlined, 'Permanent Account Number', _panCtrl, _panValidator)),
        const SizedBox(height: 20),
        _two(_field('Aadhaar Number', Icons.fingerprint, 'Aadhaar of taxpayer', _aadhaarCtrl, _aadhaarValidator),
             _field('Mobile Number', Icons.phone_outlined, 'Contact number', _mobileCtrl, _mobileValidator)),
        const SizedBox(height: 20),
        _two(_field('Email ID', Icons.email_outlined, 'Communication purpose', _emailCtrl, _emailValidator),
             const SizedBox()),
      ]),
      const SizedBox(height: 20),
      _card('Documents Upload', Icons.upload_file_outlined, [
        _label('Upload supporting documents'),
        const SizedBox(height: 6),
        const Text('Form 16, bank statements, capital gain statements, P&L, audit report, donation receipts (PDF, JPG, PNG)',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
        const SizedBox(height: 10),
        _singleUpload(() async {
          final r = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','jpg','jpeg','png']);
          if (r != null && r.files.isNotEmpty) setState(() => _form26asFile = r.files.first);
        }, _form26asFile, () => _form26asFile = null),
      ]),
      const SizedBox(height: 20),
      _card('Additional Information', Icons.notes_outlined, [_label('Additional Notes'), const SizedBox(height: 10), _textArea()]),
    ];
  }

  // ═══════════════════════════════════════════
  //  SHARED WIDGET HELPERS
  // ═══════════════════════════════════════════

  Widget _card(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 2))]),
      padding: const EdgeInsets.all(28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, size: 19, color: const Color(0xFF64748B)),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16, fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 16),
        Container(height: 1, color: const Color(0xFFF1F5F9)),
        const SizedBox(height: 20),
        ...children,
      ]),
    );
  }

  Widget _label(String text) {
    return Row(children: [
      Text(text, style: const TextStyle(color: Color(0xFF1F2937), fontSize: 13, fontWeight: FontWeight.w500)),
      const Text(' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 13, fontWeight: FontWeight.w500)),
    ]);
  }

  Widget _field(String label, IconData icon, String hint, TextEditingController ctrl, [String? Function(String?)? validator]) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Color(0xFF1F2937), fontSize: 13, fontWeight: FontWeight.w500)),
      const SizedBox(height: 6),
      TextFormField(
        controller: ctrl, validator: validator,
        textCapitalization: label.contains('PAN') ? TextCapitalization.characters : TextCapitalization.none,
        decoration: InputDecoration(
          prefixIcon: _prefixIcon(icon),
          hintText: hint, hintStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: _inputBorder(), enabledBorder: _inputBorder(), focusedBorder: _focusedBorder(),
          filled: true, fillColor: const Color(0xFFF3F4F6),
        ),
        style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
      ),
    ]);
  }

  Widget _two(Widget left, Widget right) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: left), const SizedBox(width: 16), Expanded(child: right),
    ]);
  }

  Widget _fyDropdown() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _label('Financial Year'),
      const SizedBox(height: 6),
      DropdownButtonFormField<String>(
        initialValue: _financialYear, isExpanded: true,
        decoration: _dropdownDeco(Icons.calendar_view_month_outlined),
        hint: const Text('Year for filing', style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
        items: _financialYears.map((o) => DropdownMenuItem(value: o, child: Text(o, style: const TextStyle(fontSize: 13, color: Color(0xFF374151))))).toList(),
        onChanged: (v) => setState(() => _financialYear = v),
        validator: (v) => v == null ? 'Must select' : null,
      ),
    ]);
  }

  Widget _docRow(String label, String hint, VoidCallback onPick, PlatformFile? file, VoidCallback onRemove) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Color(0xFF1F2937), fontSize: 13, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      Text(hint, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
      const SizedBox(height: 6),
      _singleUpload(onPick, file, onRemove),
    ]);
  }

  Widget _singleUpload(VoidCallback onPick, PlatformFile? file, VoidCallback onRemove) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: double.infinity, height: 54,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(7),
          border: Border.all(color: file != null ? const Color(0xFF10B981) : const Color(0xFFD1D5DB), width: file != null ? 1.5 : 1),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: file == null
          ? [const Icon(Icons.cloud_upload_outlined, size: 20, color: Color(0xFF6B7280)), const SizedBox(width: 6),
             const Text('Tap to upload', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12))]
          : [const Icon(Icons.check_circle_outline, size: 20, color: Color(0xFF10B981)), const SizedBox(width: 6),
             Flexible(child: Text(file.name, style: const TextStyle(color: Color(0xFF374151), fontSize: 12), overflow: TextOverflow.ellipsis)),
             const SizedBox(width: 8),
             GestureDetector(onTap: onRemove, child: const Icon(Icons.close, size: 16, color: Color(0xFFEF4444)))],
        ),
      ),
    );
  }

  Widget _textArea() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(7), border: Border.all(color: const Color(0xFFD1D5DB))),
      child: TextField(
        maxLines: 3, controller: _descriptionCtrl,
        decoration: const InputDecoration(
          border: InputBorder.none, contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
          hintText: 'Any additional information...', hintStyle: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
        ),
        style: const TextStyle(fontSize: 13, color: Color(0xFF374151)),
      ),
    );
  }

  Widget _buildAcknowledgement() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF0F9FF), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFBAE6FD))),
      child: Row(children: [
        SizedBox(width: 20, height: 20, child: Checkbox(
          value: _acknowledge, onChanged: (v) => setState(() => _acknowledge = v ?? false),
          activeColor: const Color(0xFF1E2A4A), side: const BorderSide(color: Color(0xFFD1D5DB)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )),
        const SizedBox(width: 12),
        Expanded(child: Text('I confirm that the information provided is accurate and complete to the best of my knowledge.',
            style: const TextStyle(color: Color(0xFF475569), fontSize: 13))),
      ]),
    );
  }

  // ═══════════════════════════════════════════
  //  DECORATION HELPERS
  // ═══════════════════════════════════════════

  Widget _prefixIcon(IconData icon) {
    return SizedBox(width: 32, child: Row(children: [
      const SizedBox(width: 8),
      Icon(icon, size: 15, color: const Color(0xFF6B7280)),
      Container(height: 20, width: 1, color: const Color(0xFFD1D5DB), margin: const EdgeInsets.only(left: 8)),
    ]));
  }

  InputBorder _inputBorder() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFFD1D5DB)));
  }

  InputBorder _focusedBorder() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Color(0xFF9CA3AF)));
  }

  InputDecoration _dropdownDeco(IconData icon) {
    return InputDecoration(
      prefixIcon: _prefixIcon(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: _inputBorder(), enabledBorder: _inputBorder(), focusedBorder: _focusedBorder(),
      filled: true, fillColor: const Color(0xFFF3F4F6),
    );
  }

  // ═══════════════════════════════════════════
  //  VALIDATORS
  // ═══════════════════════════════════════════

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

  // ═══════════════════════════════════════════
  //  FILE PICKER & ACTIONS
  // ═══════════════════════════════════════════

  Future<void> _pickDoc(void Function(PlatformFile) onFile, List<String> exts) async {
    final r = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: exts);
    if (r != null && r.files.isNotEmpty) setState(() => onFile(r.files.first));
  }

  void _submitForm() {
    _triedSubmit = true;
    final valid = _formKey.currentState!.validate();
    if (!valid) return;

    // Check mandatory docs per ITR type
    bool docsOk = true;
    if (_isItr1) docsOk = _form16File != null && _form26asFile != null && _deductionProofsFile != null;
    else if (_isItr2) docsOk = _form26asFile != null;
    else if (_isItr3) docsOk = _plStatementFile != null && _balanceSheetFile != null && _bankStmtsFile != null && _form26asFile != null;
    else if (_isItr4) docsOk = _form26asFile != null && _deductionProofsFile != null;
    else if (_isItr5) docsOk = _balanceSheetFile != null && _plStatementFile != null && _form26asFile != null;
    else if (_isItr6) docsOk = _balanceSheetFile != null && _plStatementFile != null && _form26asFile != null && _digitalSignatureFile != null;
    else if (_isItr7) docsOk = _registrationCertFile != null && _balanceSheetFile != null && _incomeExpenditureFile != null;
    else if (_isNotice) docsOk = _noticeFile != null && _itrCopyFile != null;
    else docsOk = _form26asFile != null;

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

    widget.onSubmit?.call();
  }

  void _resetForm() {
    setState(() {
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
        _noticeNoCtrl, _assessmentYearCtrl, _responseExplanationCtrl, _incomeProofCtrl,
      ]) {
        c.clear();
      }
      _financialYear = null;
      _acknowledge = false;
      _triedSubmit = false;
      _form26asFile = _form16File = _deductionProofsFile = null;
      _capitalGainsFile = _foreignIncomeFile = null;
      _plStatementFile = _balanceSheetFile = _bankStmtsFile = _auditReportFile = _gstFile = null;
      _digitalSignatureFile = _tdsFile = null;
      _registrationCertFile = _donationFile = _incomeExpenditureFile = null;
      _noticeFile = _itrCopyFile = _supportingDocsFile = _incomeProofsFile = null;
    });
  }

  Widget _buildActionButtons() {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        OutlinedButton(
          onPressed: _resetForm,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF64748B), side: const BorderSide(color: Color(0xFFD1D5DB)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Reset', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: _submitForm,
          icon: const Icon(Icons.send, size: 14),
          label: const Text('Submit Request', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2A4A), foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), elevation: 0,
          ),
        ),
      ]),
    );
  }
}
