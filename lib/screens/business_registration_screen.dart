import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gst_form_fields.dart';
import 'business_sole_proprietorship_screen.dart';
import 'business_partnership_firm_screen.dart';
import 'business_private_limited_screen.dart';
import 'business_public_limited_screen.dart';
import 'business_llp_screen.dart';
import 'business_section8_screen.dart';
import 'business_trust_screen.dart';
import 'business_opc_screen.dart';

class BusinessRegistrationScreen extends StatefulWidget {
  const BusinessRegistrationScreen({super.key});

  @override
  State<BusinessRegistrationScreen> createState() => _BusinessRegistrationScreenState();
}

class _BusinessRegistrationScreenState extends State<BusinessRegistrationScreen> {
  int _selectedCardIndex = 0;
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
    _BizCardInfo('Sole Proprietorship', 'Simple single-owner business', Icons.person_outline, Color(0xFF0EA5E9), true),
    _BizCardInfo('Partnership Firm', 'Register with legal agreements', Icons.people_outline, Color(0xFF10B981), false),
    _BizCardInfo('Private Limited Company', 'Incorporate with limited liability', Icons.business, Color(0xFF8B5CF6), false),
    _BizCardInfo('Public Limited Company', 'Company for public investment', Icons.account_balance, Color(0xFFF97316), false),
    _BizCardInfo('LLP', 'Flexible partnership with limited liability', Icons.handshake, Color(0xFF3B82F6), false),
    _BizCardInfo('Section 8 Company', 'Non-profit charitable organization', Icons.volunteer_activism, Color(0xFFEC4899), false),
    _BizCardInfo('Trust Registration', 'Charitable or private trust', Icons.real_estate_agent, Color(0xFF14B8A6), false),
    _BizCardInfo('One Person Company', 'Single-owner limited liability', Icons.person_pin, Color(0xFFF59E0B), false),
  ];

  static const _documentsByCard = [
    ['PAN Card', 'Address Proof (Utility Bill / Rent Agreement)', 'ID Proof (Aadhaar / Passport / Voter ID)', 'Bank Account Proof'],
    ['PAN Cards (Firm & Partners)', 'Partnership Deed', 'Address Proof', 'Bank Account Proof'],
    ['Director PAN & ID Proof', 'MOA & AOA', 'Registered Office Proof', 'Bank Account Proof'],
    ['Director PAN & ID Proof', 'MOA & AOA', 'Registered Office Proof', 'SEBI Compliance Documents', 'Bank Account Proof'],
    ['Partner PAN & ID Proof', 'LLP Agreement', 'Registered Office Proof', 'Bank Account Proof'],
    ['Director PAN & ID Proof', 'MOA & AOA', 'Section 8 License Application', 'Office Address Proof', 'Bank Account Proof'],
    ['Trust Deed', 'Trustees PAN & ID', 'Registered Office Proof', 'Bank Account Proof'],
    ['Owner PAN & ID Proof', 'MOA & AOA', 'Registered Office Proof', 'Bank Account Proof'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 36),
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
            const Icon(Icons.business_center, color: Color(0xFF3B82F6), size: 40),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: 'Business ', style: TextStyle(color: Color(0xFF000000), fontSize: 28, fontWeight: FontWeight.w800)),
                        TextSpan(text: 'Registration', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 28, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('End-to-end support for all types of business registrations',
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
            borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
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
                      'Registering your business correctly from the start ensures legal compliance and smooth operations. Our experts handle everything from sole proprietorships to public limited companies.',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose your registration type',
          style: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: Row(
            children: [
              _buildArrowButton(Icons.chevron_left, () {
                final offset = _scrollController.offset;
                _scrollController.animateTo((offset - 280).clamp(0.0, _scrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                        child: SizedBox(width: 248, child: _buildServiceCard(i)),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildArrowButton(Icons.chevron_right, () {
                final offset = _scrollController.offset;
                _scrollController.animateTo((offset + 280).clamp(0.0, _scrollController.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
            color: Colors.white, borderRadius: BorderRadius.circular(20),
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
    final isSelected = _selectedCardIndex == index;
    final isHovered = _hoveredCard == index;
    final isPressed = _pressedCard == index;
    final bgColor = isSelected ? const Color(0xFF2D3A6B) : Colors.white;
    final borderColor = isSelected ? const Color(0xFF2D3A6B) : (isHovered ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0));
    final titleColor = isSelected ? Colors.white : const Color(0xFF1E293B);
    final subtitleColor = isSelected ? Colors.white.withAlpha(166) : const Color(0xFF94A3B8);
    final effectiveIconColor = isSelected ? Colors.white : card.color;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredCard = index),
      onExit: (_) => setState(() => _hoveredCard = -1),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressedCard = index),
        onTapUp: (_) => setState(() { _pressedCard = -1; _selectedCardIndex = index; }),
        onTapCancel: () => setState(() => _pressedCard = -1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: isPressed ? Matrix4.diagonal3Values(0.97, 0.97, 1.0) : Matrix4.identity(),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(12),
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
                    child: const Text('Recommended', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                )
              else
                const SizedBox(height: 22),
              const SizedBox(height: 12),
              Icon(card.icon, color: effectiveIconColor, size: 22),
              const SizedBox(height: 12),
              Text(card.title, style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(card.subtitle, style: TextStyle(color: subtitleColor, fontSize: 13, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentsCard() {
    final docs = _documentsByCard[_selectedCardIndex];
    final mid = (docs.length + 1) ~/ 2;
    final leftDocs = docs.sublist(0, mid);
    final rightDocs = docs.sublist(mid);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgCard, borderRadius: BorderRadius.circular(12),
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
              Text('Required documents — ${_cardData[_selectedCardIndex].title}',
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
              if (i < leftDocs.length) Expanded(child: _buildDocTile(leftDocs[i])) else const Expanded(child: SizedBox()),
              const SizedBox(width: 10),
              if (i < rightDocs.length) Expanded(child: _buildDocTile(rightDocs[i])) else const Expanded(child: SizedBox()),
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
        color: AppColors.bgCard, borderRadius: BorderRadius.circular(8),
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
          Expanded(child: Text(name, style: const TextStyle(color: Color(0xFF475569), fontSize: 13.5, fontWeight: FontWeight.w400))),
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
              case 0: nextScreen = const BusinessSoleProprietorshipScreen(); break;
              case 1: nextScreen = const BusinessPartnershipFirmScreen(); break;
              case 2: nextScreen = const BusinessPrivateLimitedScreen(); break;
              case 3: nextScreen = const BusinessPublicLimitedScreen(); break;
              case 4: nextScreen = const BusinessLlpScreen(); break;
              case 5: nextScreen = const BusinessSection8Screen(); break;
              case 6: nextScreen = const BusinessTrustScreen(); break;
              case 7: nextScreen = const BusinessOpcScreen(); break;
              default: return;
            }
            showUserDetailsDialog(context, (context) => nextScreen);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 280, height: 54,
            decoration: BoxDecoration(
              color: _hoveringContinue ? const Color(0xFF3D4F72) : const Color(0xFF2E3A59),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [BoxShadow(color: const Color(0xFF2E3A59).withAlpha(80), blurRadius: 20, offset: const Offset(0, 6))],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () {
                  Widget nextScreen;
                  switch (_selectedCardIndex) {
                    case 0: nextScreen = const BusinessSoleProprietorshipScreen(); break;
                    case 1: nextScreen = const BusinessPartnershipFirmScreen(); break;
                    case 2: nextScreen = const BusinessPrivateLimitedScreen(); break;
                    case 3: nextScreen = const BusinessPublicLimitedScreen(); break;
                    case 4: nextScreen = const BusinessLlpScreen(); break;
                    case 5: nextScreen = const BusinessSection8Screen(); break;
                    case 6: nextScreen = const BusinessTrustScreen(); break;
                    case 7: nextScreen = const BusinessOpcScreen(); break;
                    default: return;
                  }
                  showUserDetailsDialog(context, (context) => nextScreen);
                },
                child: const Center(
                  child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BizCardInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool showRecommended;
  const _BizCardInfo(this.title, this.subtitle, this.icon, this.color, this.showRecommended);
}
