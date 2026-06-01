import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class IncomeTaxForm extends StatefulWidget {
  final VoidCallback? onNavigateToGeneral;
  final VoidCallback? onNavigateToItr1;
  final VoidCallback? onNavigateToItr2;
  final VoidCallback? onNavigateToItr3;
  final VoidCallback? onNavigateToItr4;
  final VoidCallback? onNavigateToItr5;
  final VoidCallback? onNavigateToItr6;
  final VoidCallback? onNavigateToItr7;
  final VoidCallback? onNavigateToNoticeResponse;

  const IncomeTaxForm({
    super.key,
    this.onNavigateToGeneral,
    this.onNavigateToItr1,
    this.onNavigateToItr2,
    this.onNavigateToItr3,
    this.onNavigateToItr4,
    this.onNavigateToItr5,
    this.onNavigateToItr6,
    this.onNavigateToItr7,
    this.onNavigateToNoticeResponse,
  });

  @override
  State<IncomeTaxForm> createState() => _IncomeTaxFormState();
}

class _IncomeTaxFormState extends State<IncomeTaxForm> {
  int _selectedRadio = 0;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  bool _hoveringContinue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderCard(),
        const SizedBox(height: 36),
        const Text(
          'Choose your ITR type',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _buildRadioSection(),
        const SizedBox(height: 28),
        _buildDocumentsCard(),
        const SizedBox(height: 36),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildHeaderCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_balance_outlined,
              color: Color(0xFF3B82F6),
              size: 40,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Income Tax ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: 'Services',
                          style: TextStyle(
                            color: Color(0xFF3B82F6),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Filing of all types of ITRs, notice responses & compliance services',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            border: const Border(
              left: BorderSide(
                color: Color(0xFF3B82F6),
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.check_box_outlined,
                  color: Color(0xFF3B82F6),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Income tax compliance is essential for every taxpayer in India. Our expert team simplifies the filing process end-to-end, ensuring accurate and timely submissions.',
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 14,
                          height: 1.45,
                          fontFamily: 'Roboto',
                        ),
                        children: [
                          TextSpan(text: 'From ITR selection to '),
                          TextSpan(
                            text: 'final filing and notice response,',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          TextSpan(text: ' we handle everything so you can '),
                          TextSpan(
                            text: 'stay compliant with peace of mind.',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioSection() {
    return SizedBox(
      height: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                0,
                'ITR Filing – General',
                'ITR-1 to ITR-7 (All types)',
                Icons.assignment_outlined,
                const Color(0xFF3B82F6),
                showRecommended: true,
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                1,
                'ITR-1 Filing (Sahaj)',
                'Salaried individuals',
                Icons.person_outline,
                const Color(0xFF0EA5E9),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                2,
                'ITR-2 Filing',
                'Individuals/HUF no business',
                Icons.person_2_outlined,
                const Color(0xFF8B5CF6),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                3,
                'ITR-3 Filing',
                'Business/profession income',
                Icons.business_center_outlined,
                const Color(0xFFF97316),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                4,
                'ITR-4 Filing (Sugam)',
                'Presumptive income',
                Icons.receipt_outlined,
                const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                5,
                'ITR-5 Filing',
                'Firms/LLPs/AOPs/BOIs',
                Icons.business_outlined,
                const Color(0xFFEF4444),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                6,
                'ITR-6 Filing',
                'Companies',
                Icons.corporate_fare_outlined,
                const Color(0xFF6366F1),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                7,
                'ITR-7 Filing',
                'Trusts/charitable institutions',
                Icons.volunteer_activism_outlined,
                const Color(0xFFEC4899),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 260,
              child: _buildSelectorCard(
                8,
                'Income Tax Notice Response',
                'Respond to IT notices',
                Icons.mail_outline,
                const Color(0xFFF59E0B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectorCard(
    int index,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor, {
    bool showRecommended = false,
  }) {
    final isSelected = _selectedRadio == index;
    final isHovered = _hoveredCard == index;
    final isPressed = _pressedCard == index;
    final bgColor = isSelected ? const Color(0xFF2D3A6B) : Colors.white;
    final borderColor = isSelected
        ? const Color(0xFF2D3A6B)
        : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected
        ? Colors.white.withAlpha(166)
        : const Color(0xFF94A3B8);
    final effectiveIconColor =
        (isSelected && index == 0) ? Colors.white : iconColor;

    Matrix4 getTransform() {
      if (isPressed) return Matrix4.diagonal3Values(0.97, 0.97, 1.0);
      return Matrix4.identity();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredCard = index),
      onExit: (_) => setState(() => _hoveredCard = -1),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressedCard = index),
        onTapUp: (_) {
          setState(() {
            _pressedCard = -1;
            _selectedRadio = index;
          });
        },
        onTapCancel: () => setState(() => _pressedCard = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: getTransform(),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: isHovered && !isSelected
                ? [
                    const BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showRecommended)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Recommended',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Icon(icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentsCard() {
    final allDocs = [..._getLeftDocs(), ..._getRightDocs()];
    final docCount = allDocs.length;
    final serviceName = _getServiceName();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_outlined,
                  color: Color(0xFF3B82F6),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Required documents — $serviceName',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$docCount documents',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDocumentGrid(),
        ],
      ),
    );
  }

  Widget _buildDocumentGrid() {
    final leftDocs = _getLeftDocs();
    final rightDocs = _getRightDocs();
    final maxRows = leftDocs.length > rightDocs.length ? leftDocs.length : rightDocs.length;

    return Column(
      children: List.generate(maxRows, (i) {
        final leftDoc = i < leftDocs.length ? leftDocs[i] : null;
        final rightDoc = i < rightDocs.length ? rightDocs[i] : null;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (leftDoc != null) Expanded(child: _buildDocumentTile(leftDoc))
              else const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (rightDoc != null) Expanded(child: _buildDocumentTile(rightDoc))
              else const Expanded(child: SizedBox()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDocumentTile(String docName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Color(0xFF3B82F6),
              size: 14,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              docName,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getServiceName() {
    switch (_selectedRadio) {
      case 0: return 'ITR Filing – General';
      case 1: return 'ITR-1 Filing (Sahaj)';
      case 2: return 'ITR-2 Filing';
      case 3: return 'ITR-3 Filing';
      case 4: return 'ITR-4 Filing (Sugam)';
      case 5: return 'ITR-5 Filing';
      case 6: return 'ITR-6 Filing';
      case 7: return 'ITR-7 Filing';
      case 8: return 'Income Tax Notice Response';
      default: return '';
    }
  }

  List<String> _getLeftDocs() {
    switch (_selectedRadio) {
      case 0:
        return [
          'PAN Card',
          'Aadhaar Card',
          'Form 16 (for salaried)',
          'Bank Statements (last 6 months or FY)',
          'Investment Proofs (LIC, PPF, ELSS, etc.)',
        ];
      case 1:
        return [
          'Form 16',
          'Salary Slips',
        ];
      case 2:
        return [
          'Property sale/purchase documents',
          'Capital gain reports from brokers',
        ];
      case 3:
        return [
          'Profit & Loss Statement',
          'Balance Sheet',
        ];
      case 4:
        return [
          'Bank Statements',
          'Turnover Declaration',
        ];
      case 5:
        return [
          'Partnership Deed / LLP Agreement',
          'Financial Statements',
        ];
      case 6:
        return [
          'Balance Sheet',
          'Profit & Loss Statement',
        ];
      case 7:
        return [
          'Trust Deed / NGO Registration Certificate',
          'Financial Statements',
        ];
      case 8:
        return [
          'Copy of Notice',
          'Previous ITR filed',
        ];
      default:
        return [];
    }
  }

  List<String> _getRightDocs() {
    switch (_selectedRadio) {
      case 0:
        return [
          'TDS Certificates (Form 16A, 26AS)',
          'Capital Gain Statements (if applicable)',
          'Audit Report (if applicable for business)',
          'Donation Receipts (for exemptions)',
        ];
      case 1:
        return [
          'Bank Interest Certificate',
          'Section 80C/80D proofs',
        ];
      case 2:
        return [
          'Loan certificate (for interest deduction)',
          'Foreign bank account / investment details',
        ];
      case 3:
        return [
          'Audit Report (if applicable)',
          'Expense Bills & Receipts',
        ];
      case 4:
        return [
          'Expense Proofs (optional)',
        ];
      case 5:
        return [
          'PAN of Firm/LLP',
          'GST Returns (if applicable)',
        ];
      case 6:
        return [
          'Tax Audit Report (Form 3CA/3CD)',
          'GST Returns (if applicable)',
        ];
      case 7:
        return [
          'Donation Receipts',
          '12A & 80G Certificates',
        ];
      case 8:
        return [
          'Form 16 / Financial Statements',
          'Proofs supporting reply (bills, receipts, donation slips)',
        ];
      default:
        return [];
    }
  }

  Widget _buildContinueButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveringContinue = true),
        onExit: (_) => setState(() => _hoveringContinue = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 280,
          height: 54,
          decoration: BoxDecoration(
            color: _hoveringContinue
                ? const Color(0xFF3D4F72)
                : const Color(0xFF2E3A59),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2E3A59).withAlpha(80),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () => _showUserDetailsDialog(context),
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showUserDetailsDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final mobileCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: AppColors.bgCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: const Color(0x1F000000),
          child: SizedBox(
            width: 520,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'User Details',
                        style: TextStyle(
                          color: Color(0xFF1A1F2E),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Divider(height: 24, color: AppColors.border),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildDialogField(
                            'User Name',
                            'Enter your name',
                            nameCtrl,
                            (v) => v == null || v.trim().isEmpty ? 'User-name is required.' : null,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildDialogField(
                            'Mobile Number',
                            'Enter Mobile Number',
                            mobileCtrl,
                            (v) {
                              if (v == null || v.trim().isEmpty) return 'Please enter mobile number.';
                              if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Enter valid 10-digit number.';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDialogField(
                      'Mail Address',
                      'Enter Mail Address',
                      emailCtrl,
                      (v) {
                        if (v == null || v.trim().isEmpty) return 'Please enter mail address.';
                        if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Enter valid email address.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(ctx).pop();
                            if (_selectedRadio == 0) {
                              widget.onNavigateToGeneral?.call();
                            } else if (_selectedRadio == 1) {
                              widget.onNavigateToItr1?.call();
                            } else if (_selectedRadio == 2) {
                              widget.onNavigateToItr2?.call();
                            } else if (_selectedRadio == 3) {
                              widget.onNavigateToItr3?.call();
                            } else if (_selectedRadio == 4) {
                              widget.onNavigateToItr4?.call();
                            } else if (_selectedRadio == 5) {
                              widget.onNavigateToItr5?.call();
                            } else if (_selectedRadio == 6) {
                              widget.onNavigateToItr6?.call();
                            } else if (_selectedRadio == 7) {
                              widget.onNavigateToItr7?.call();
                            } else if (_selectedRadio == 8) {
                              widget.onNavigateToNoticeResponse?.call();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandBlue,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogField(
    String label,
    String hint,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 48,
          child: TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.brandBlue, width: 2),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
          ),
        ),
      ],
    );
  }
}
