import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:bus_ticketing/features/home/models/terminal_data.dart';
import 'package:bus_ticketing/features/home/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class LocationPickerSheet {
  LocationPickerSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required bool isDeparture,
    Terminal? selected,
  }) {
    return AppBottomSheet.show(
      context: context,
      title: isDeparture
          ? "Select Departure Point"
          : "Select Destination Point",
      child: _LocationPickerBody(isDeparture: isDeparture, selected: selected),
    );
  }
}

class _LocationPickerBody extends StatefulWidget {
  final bool isDeparture;
  final Terminal? selected;

  const _LocationPickerBody({required this.isDeparture, this.selected});

  @override
  State<_LocationPickerBody> createState() => _LocationPickerBodyState();
}

class _LocationPickerBodyState extends State<_LocationPickerBody> {
  final searchController = TextEditingController();
  late Terminal? _selectedTerminal;

  // all terminals fetched from "api", and the filtered Terminals,
  List<Terminal> _allTerminals = [];
  List<Terminal> _filteredTerminals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedTerminal = widget.selected;
    _fetchTerminals();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  //TODO: replace with Dio later
  Future<void> _fetchTerminals() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      //TODO: to test the empty state, replace mockTerminals with []
      _allTerminals = mockTerminals;
      _filteredTerminals = _allTerminals;
      _isLoading = false;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredTerminals = _allTerminals.where((terminal) {
        final lowerQuery = query.toLowerCase();
        return terminal.city.toLowerCase().contains(lowerQuery) ||
          terminal.terminalName.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  void _onSelect(Terminal terminal) {
    setState(() => _selectedTerminal = terminal);
    Navigator.pop(context, terminal);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //search field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: searchController,
            onChanged: _onSearchChanged,
            enabled: !_isLoading,
            decoration: InputDecoration(
              hintText: widget.isDeparture
                ? 'Search departure terminal'
                : 'Search destination terminal',
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textHint,
                size: 20,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // content area: skeleton, empty state, or list
        Flexible(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const _TerminalListSkeleton();
    }

    if (_filteredTerminals.isEmpty) {
      return const _EmptyTerminalState();
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      itemCount: _filteredTerminals.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final terminal = _filteredTerminals[index];
        final isSelected =
          _selectedTerminal?.terminalName == terminal.terminalName;

        return _TerminalTile(
          terminal: terminal,
          isSelected: isSelected,
          onTap: () => _onSelect(terminal),
        );
      },
    );
  }
}

//shimmer skeleton list, shown while "fetching" terminals
class _TerminalListSkeleton extends StatelessWidget {
  const _TerminalListSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.divider,
      highlightColor: AppColors.background,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        itemCount: 6,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 160,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// empty state shown when terminal list comes back empty
class _EmptyTerminalState extends StatelessWidget {
  const _EmptyTerminalState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_off_outlined,
              size: 32,
              color: AppColors.textHint,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Oops, no terminals available for now',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Please check back later or try a different search.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TerminalTile extends StatelessWidget {
  final Terminal terminal;
  final bool isSelected;
  final VoidCallback onTap;

  const _TerminalTile({
    required this.terminal,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    terminal.city,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    terminal.terminalName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.accent : AppColors.divider,
                  width: 1.5,
                ),
                color: Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}