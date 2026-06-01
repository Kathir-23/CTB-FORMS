import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gst_form_fields.dart';
import 'legal_nda_screen.dart';
import 'legal_agreement_screen.dart';
import 'legal_franchise_screen.dart';

class LegalServicesScreen extends StatefulWidget {
  const LegalServicesScreen({super.key});

  @override
  State<LegalServicesScreen> createState() => _LegalServicesScreenState();
}

class _LegalServicesScreenState extends State<LegalServicesScreen> {
  int _selectedCardIndex = 0;
  int _hoveredCard = -1;
  int _pressedCard = -1;
  bool _hoveringContinue = false;

  static const _cardData = [
    _LegalCardInfo('NDA Service', 'Protect confidential information', Icons.lock_outline, Color(0xFF0EA5E9), true),
    _LegalCardInfo('Legal Agreement Drafting', 'Clear & enforceable agreements', Icons.description_outlined, Color(0xFF8B5CF6), false),
    _LegalCardInfo('Franchise Agreement', 'Define franchise relationships', Icons.handshake_outlined, Color(0xFFF97316), false),
  ];

  static const _documentsByCard = [
    [
      'PAN Card of Entity',
      'Business Registration Certificate',
      'Identity Proof of Signatory',
      'Address Proof (Utility Bill / Rent Agreement)',
    ],
    [
      'PAN Card of Entity',
      'Business Proof (Incorporation Certificate / Partnership Deed)',
      'ID Proof of Authorized Signatory',
      'Draft Business Terms / Clauses (if any)',
    ],
    [
      'PAN of Franchisor',
      'Business Incorporation Certificate',
      'Trademark / Brand Registration Certificate',
      'ID & Address Proof of Franchisor & Franchisee',
      'Franchise Model Document (Operations / Standards)',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 36),
        const Text(
          'Choose your service',
          style: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        _buildCardsSection(),
        const SizedBox(height: 28),
        if (_selectedCardIndex >= 0) _buildDocumentsCard(),
        if (_selectedCardIndex >= 0) ...[
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
            const Icon(Icons.gavel, color: Color(0xFF3B82F6), size: 40),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Legal ',
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
                    'Expert legal document drafting and agreement services',
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
                child: Icon(Icons.info_outline, color: Color(0xFF3B82F6), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Legal agreements and NDAs are critical for protecting your business. Our expert team drafts clear, enforceable documents tailored to your needs.',
                      style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.45),
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
    return SizedBox(
      height: 180,
      child: Row(
        children: [
          for (int i = 0; i < _cardData.length; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            Expanded(child: _buildServiceCard(i)),
          ],
        ],
      ),
    );
  }

  Widget _buildServiceCard(int index) {
    final card = _cardData[index];
    final isSelected = _selectedCardIndex == index;
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
          setState(() { _pressedCard = -1; _selectedCardIndex = index; });
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
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('Recommended',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
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
    final docs = _documentsByCard[_selectedCardIndex];
    final List<String> leftDocs = docs.length > 2 ? docs.sublist(0, (docs.length + 1) ~/ 2) : [docs[0]];
    final List<String> rightDocs = docs.length > 2 ? docs.sublist((docs.length + 1) ~/ 2) : (docs.length > 1 ? [docs[1]] : <String>[]);

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
                'Required documents — ${_cardData[_selectedCardIndex].title}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('${docs.length} documents',
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
          onTap: () {
            Widget nextScreen;
            switch (_selectedCardIndex) {
              case 0: nextScreen = const LegalNdaScreen(); break;
              case 1: nextScreen = const LegalAgreementScreen(); break;
              case 2: nextScreen = const LegalFranchiseScreen(); break;
              default: return;
            }
            showUserDetailsDialog(context, (context) => nextScreen);
          },
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
                onTap: () {
                  Widget nextScreen;
                  switch (_selectedCardIndex) {
                    case 0: nextScreen = const LegalNdaScreen(); break;
                    case 1: nextScreen = const LegalAgreementScreen(); break;
                    case 2: nextScreen = const LegalFranchiseScreen(); break;
                    default: return;
                  }
                  showUserDetailsDialog(context, (context) => nextScreen);
                },
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
}

class _LegalCardInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool showRecommended;

  const _LegalCardInfo(this.title, this.subtitle, this.icon, this.color, this.showRecommended);
}
