import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/event_cubit.dart';
import '../cubit/event_state.dart';
import '../models/event_model.dart';
import 'event_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    "All Events",
    "Live Event",
    "Workshop",
    "Art Exhibition",
    "Sports",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    if (!mounted) return;
    await context.read<EventCubit>().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF673AB7),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        color: const Color(0xFF673AB7),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Halo, Anrai 👋",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Temukan event impianmu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: const NetworkImage(
                          'https://ui-avatars.com/api/?name=Anrai+Harika&background=random',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search event...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      icon: Icon(Icons.search, color: Colors.grey[400]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final isActive = index == _selectedCategoryIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _categories[index],
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.white54,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (isActive)
                              Container(
                                height: 2,
                                width: 30,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.only(top: 24, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("NEAREST EVENT"),
                    const SizedBox(height: 16),
                    _buildEventList(),
                    const SizedBox(height: 32),
                    _buildSectionHeader("RECOMMENDED EVENTS"),
                    const SizedBox(height: 16),
                    _buildEventList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            "See All",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    return SizedBox(
      height: 290,
      child: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is EventError) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is EventLoaded) {
            if (state.events.isEmpty) {
              return const Center(
                child: Text(
                  "Belum ada event.",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                return _EventCard(event: state.events[index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventModel event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(event: event),
          ),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=400&auto=format&fit=crop',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "EVENT",
                style: TextStyle(
                  color: Color(0xFFD6A054),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Rp 0",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.location,
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
