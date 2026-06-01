import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'itr_form_screen.dart';

class IncomeTaxForm extends StatefulWidget {
  const IncomeTaxForm({super.key});

  @override
  State<IncomeTaxForm> createState() => _IncomeTaxFormState();
}

class _IncomeTaxFormState extends State<IncomeTaxForm> {
  int _selectedCard = 0;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  bool _hoveringContinue = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  static const _cardData = [
    _ItrCardInfo('ITR Filing \u2013 General (All Types)', 'ITR-1 to ITR-7 across all categories', Icons.assignment_outlined, Color(0xFF3B82F6), true),
    _ItrCardInfo('ITR-1 Filing (Sahaj)', 'Salaried individuals', Icons.person_outline, Color(0xFF0EA5E9), false),
    _ItrCardInfo('ITR-2 Filing', 'Individuals/HUF (No Business)', Icons.person_2_outlined, Color(0xFF8B5CF6), false),
    _ItrCardInfo('ITR-3 Filing', 'Business/Profession Income', Icons.business_center_outlined, Color(0xFFF97316), false),
    _ItrCardInfo('ITR-4 Filing (Sugam)', 'Presumptive Income', Icons.receipt_outlined, Color(0xFF10B981), false),
    _ItrCardInfo('ITR-5 Filing', 'Firms/LLPs/AOPs/BOIs', Icons.business_outlined, Color(0xFFEF4444), false),
    _ItrCardInfo('ITR-6 Filing', 'Companies', Icons.corporate_fare_outlined, Color(0xFF6366F1), false),
    _ItrCardInfo('ITR-7 Filing', 'Trusts & Charitable Institutions', Icons.volunteer_activism_outlined, Color(0xFFEC4899), false),
    _ItrCardInfo('Income Tax Notice Response', 'Respond to IT notices', Icons.mail_outline, Color(0xFFF59E0B), false),
  ];

  static const _documentsByCard = [
    [
      'PAN Card',
      'Aadhaar Card',
      'Form 16 (for salaried)',
      'Bank Statements (last 6 months or FY)',
      'Investment Proofs (LIC, PPF, ELSS, etc.)',
    ],
    [
      'Form 16',
      'Salary Slips',
    ],
    [
      'Property sale/purchase documents',
      'Capital gain reports from brokers',
    ],
    [
      'Profit & Loss Statement',
      'Balance Sheet',
    ],
    [
      'Bank Statements',
      'Turnover Declaration',
    ],
    [
      'Partnership Deed / LLP Agreement',
      'Financial Statements',
    ],
    [
      'Balance Sheet',
      'Profit & Loss Statement',
    ],
    [
      'Trust Deed / NGO Registration Certificate',
      'Financial Statements',
    ],
    [
      'Copy of Notice',
      'Previous ITR filed',
    ],
  ];

  static const _documentsRightByCard = [
    [
      'TDS Certificates (Form 16A, 26AS)',
      'Capital Gain Statements (if applicable)',
      'Audit Report (if applicable for business)',
      'Donation Receipts (for exemptions)',
    ],
    [
      'Bank Interest Certificate',
      'Section 80C/80D proofs',
    ],
    [
      'Loan certificate (for interest deduction)',
      'Foreign bank account / investment details',
    ],
    [
      'Audit Report (if applicable)',
      'Expense Bills & Receipts',
    ],
    [
      'Expense Proofs (optional)',
    ],
    [
      'PAN of Firm/LLP',
      'GST Returns (if applicable)',
    ],
    [
      'Tax Audit Report (Form 3CA/3CD)',
      'GST Returns (if applicable)',
    ],
    [
      'Donation Receipts',
      '12A & 80G Certificates',
    ],
    [
      'Form 16 / Financial Statements',
      'Proofs supporting reply (bills, receipts, donation slips)',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 36),
        _buildCardsSection(),
        if (_selectedCard >= 0) ...[
          const SizedBox(height: 28),
          _buildDocumentsCard(),
          const SizedBox(height: 36),
          _buildContinueButton(),
        ],
        const SizedBox(height: 36),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.account_balance_outlined, color: Color(0xFF3B82F6), size: 40),
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
                          style: TextStyle(color: Color(0xFF000000), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: 'Services',
                          style: TextStyle(color: Color(0xFF3B82F6), fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Filing of all types of ITRs, notice responses & compliance services',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
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
            border: const Border(left: BorderSide(color: Color(0xFF3B82F6), width: 4)),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.check_box_outlined, color: Color(0xFF3B82F6), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Income tax compliance is essential for every taxpayer in India. Our expert team simplifies the filing process end-to-end, ensuring accurate and timely submissions.',
                      style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45, fontFamily: 'Roboto'),
                        children: [
                          TextSpan(text: 'From ITR selection to '),
                          TextSpan(
                            text: 'final filing and notice response,',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                          ),
                          TextSpan(text: ' we handle everything so you can '),
                          TextSpan(
                            text: 'stay compliant with peace of mind.',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
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

  Widget _buildCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose your ITR type',
          style: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: Row(
            children: [
              _buildArrowButton(Icons.chevron_left, () {
                final offset = _scrollController.offset;
                _scrollController.animateTo(
                  (offset - 280).clamp(0.0, _scrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(_cardData.length, (i) {
                      return Padding(
                        padding: EdgeInsets.only(right: i < _cardData.length - 1 ? 16 : 0),
                        child: SizedBox(
                          width: 248,
                          child: _buildServiceCard(i),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildArrowButton(Icons.chevron_right, () {
                final offset = _scrollController.offset;
                _scrollController.animateTo(
                  (offset + 280).clamp(0.0, _scrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Icon(icon, color: const Color(0xFF475569), size: 22),
        ),
      ),
    );
  }

  Widget _buildServiceCard(int index) {
    final card = _cardData[index];
    final isSelected = _selectedCard == index;
    final isHovered = _hoveredCard == index;
    final isPressed = _pressedCard == index;

    final bgColor = isSelected ? const Color(0xFF2D3A6B) : Colors.white;
    final borderColor = isSelected
        ? const Color(0xFF2D3A6B)
        : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected ? Colors.white.withAlpha(166) : const Color(0xFF94A3B8);
    final effectiveIconColor = isSelected ? Colors.white : card.color;

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
          setState(() { _pressedCard = -1; _selectedCard = index; });
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
                ? const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (card.showRecommended)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: const BoxDecoration(color: Color(0xFFF59E0B), borderRadius: BorderRadius.all(Radius.circular(999))),
                    child: const Text('Recommended',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              else
                const SizedBox(height: 22),
              const SizedBox(height: 12),
              Icon(card.icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              Text(card.title,
                style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(card.subtitle,
                style: TextStyle(color: subtitleColor, fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentsCard() {
    final leftDocs = _documentsByCard[_selectedCard];
    final rightDocs = _documentsRightByCard[_selectedCard];
    final docCount = leftDocs.length + rightDocs.length;
    final serviceName = _cardData[_selectedCard].title;

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
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
                child: const Icon(Icons.verified_outlined, color: Color(0xFF3B82F6), size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                'Required documents \u2014 $serviceName',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('$docCount documents',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDocGrid(leftDocs, rightDocs),
        ],
      ),
    );
  }

  Widget _buildDocGrid(List<String> leftDocs, List<String> rightDocs) {
    final maxRows = leftDocs.length > rightDocs.length ? leftDocs.length : rightDocs.length;
    return Column(
      children: List.generate(maxRows, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (i < leftDocs.length) Expanded(child: _buildDocTile(leftDocs[i]))
              else const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (i < rightDocs.length) Expanded(child: _buildDocTile(rightDocs[i]))
              else const Expanded(child: SizedBox()),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDocTile(String name) {
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
            width: 26, height: 26,
            decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Color(0xFF3B82F6), size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(name,
            style: const TextStyle(color: Color(0xFF475569), fontSize: 13.5, fontWeight: FontWeight.w400),
          )),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveringContinue = true),
        onExit: (_) => setState(() => _hoveringContinue = false),
        child: GestureDetector(
          onTap: () => _showUserDetailsDialog(context),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 280,
            height: 54,
            decoration: BoxDecoration(
              color: _hoveringContinue ? const Color(0xFF3D4F72) : const Color(0xFF2E3A59),
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
                  child: Text('Continue',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                      child: Text('User Details',
                        style: TextStyle(color: Color(0xFF1A1F2E), fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Divider(height: 24, color: AppColors.border),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildDialogField('User Name', 'Enter your name', nameCtrl, (v) {
                          if (v == null || v.trim().isEmpty) return 'User-name is required.';
                          return null;
                        })),
                        const SizedBox(width: 20),
                        Expanded(child: _buildDialogField('Mobile Number', 'Enter Mobile Number', mobileCtrl, (v) {
                          if (v == null || v.trim().isEmpty) return 'Please enter mobile number.';
                          if (!RegExp(r'^\d{10}$').hasMatch(v.trim())) return 'Enter valid 10-digit number.';
                          return null;
                        })),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDialogField('Mail Address', 'Enter Mail Address', emailCtrl, (v) {
                      if (v == null || v.trim().isEmpty) return 'Please enter mail address.';
                      if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v.trim())) return 'Enter valid email address.';
                      return null;
                    }),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ItrForm(itrType: _selectedCard),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandBlue,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
        Text(label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500),
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

class _ItrCardInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool showRecommended;

  const _ItrCardInfo(this.title, this.subtitle, this.icon, this.color, this.showRecommended);
}
