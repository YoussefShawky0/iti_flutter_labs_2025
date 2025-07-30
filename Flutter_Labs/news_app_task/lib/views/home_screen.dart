import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../cubits/news_cubit.dart';
import '../cubits/news_state.dart';
import '../models/article_model.dart';
import '../repositories/news_repository.dart';
import '../services/news_service.dart';
import '../theme/app_colors.dart';
import '../widgets/article_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      // Load more articles when reaching 80% of scroll
      context.read<NewsCubit>().loadMoreArticles();
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _searchController.clear();
        context.read<NewsCubit>().clearSearchAndRefresh();
      }
    });
  }

  void _onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      context.read<NewsCubit>().searchNews(query.trim());
    }
  }

  Future<void> _onRefresh() async {
    await context.read<NewsCubit>().fetchTopHeadlines(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(NewsRepository(NewsService()))
        ..loadCategories()
        ..fetchTopHeadlines(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              // Custom app bar with user session status
              CustomAppBar(
                title: 'News Feed',
                onSearchTap: _toggleSearch,
                onNotificationTap: () {
                  // Handle notifications
                },
              ),

              // Search bar (when visible)
              if (_isSearchVisible)
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search news...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggleSearch,
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: _onSearchSubmitted,
                  ),
                ),

              // Horizontal category selection
              BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  final cubit = context.read<NewsCubit>();
                  return CategoryList(
                    categories: cubit.categories,
                    selectedCategoryId: cubit.selectedCategoryId,
                    onCategorySelected: (categoryId) {
                      cubit.selectCategory(categoryId);
                    },
                  );
                },
              ),

              // Vertical list of news articles
              Expanded(
                child: BlocBuilder<NewsCubit, NewsState>(
                  builder: (context, state) {
                    if (state is NewsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    if (state is NewsError) {
                      return ErrorStateWidget(
                        message: state.message,
                        onRetry: () =>
                            context.read<NewsCubit>().retryLastOperation(),
                      );
                    }

                    if (state is NewsEmpty) {
                      return EmptyStateWidget(
                        message: state.message,
                        onRetry: () => context
                            .read<NewsCubit>()
                            .fetchTopHeadlines(refresh: true),
                      );
                    }

                    if (state is NewsOffline) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            color: AppColors.warning.withOpacity(0.1),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.wifi_off,
                                  color: AppColors.warning,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Offline mode - Showing cached articles',
                                  style: TextStyle(
                                    color: AppColors.warning,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: _buildArticlesList(state.articles, false),
                          ),
                        ],
                      );
                    }

                    if (state is NewsLoaded) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AppColors.primary,
                        child: _buildArticlesList(
                          state.articles,
                          state.hasMore,
                        ),
                      );
                    }

                    if (state is NewsRefreshing) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AppColors.primary,
                        child: Stack(
                          children: [
                            _buildArticlesList(state.articles, true),
                            const Positioned(
                              top: 16,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text('Refreshing...'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is NewsLoadingMore) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AppColors.primary,
                        child: _buildArticlesList(
                          state.articles,
                          true,
                          showLoadingIndicator: true,
                        ),
                      );
                    }

                    return const EmptyStateWidget(
                      message: 'Welcome to News App',
                      description: 'Pull down to load the latest news',
                    );
                  },
                ),
              ),
            ],
          ),

          // Floating action button for search
          floatingActionButton: !_isSearchVisible
              ? FloatingActionButton(
                  onPressed: _toggleSearch,
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.search, color: Colors.white),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildArticlesList(
    List<Article> articles,
    bool hasMore, {
    bool showLoadingIndicator = false,
  }) {
    if (articles.isEmpty) {
      return const EmptyStateWidget(
        message: 'No articles available',
        description: 'Pull down to refresh or try a different category',
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: articles.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= articles.length) {
          // Loading indicator for pagination
          return showLoadingIndicator
              ? Container(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                )
              : const SizedBox.shrink();
        }

        final article = articles[index];
        return ArticleCard(
          article: article,
          onTap: () {
            // Navigate to article details
            _showArticleDetails(article);
          },
          onBookmarkTap: () {
            context.read<NewsCubit>().toggleBookmark(article);
          },
        );
      },
    );
  }

  void _showArticleDetails(Article article) {
    // Show article details in bottom sheet or navigate to details page
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Article image
                      if (article.imageUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            article.imageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ),

                      const SizedBox(height: 16),

                      // Article title
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Article meta info
                      Row(
                        children: [
                          Text(
                            article.source,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatDate(article.publishedAt),
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Article content
                      Text(
                        article.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.text,
                          height: 1.5,
                        ),
                      ),

                      if (article.content.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          article.content,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.text,
                            height: 1.5,
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Open full article in browser
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Read Full Article'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              context.read<NewsCubit>().toggleBookmark(article);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: article.isBookmarked
                                  ? AppColors.primary
                                  : Colors.grey.shade200,
                              foregroundColor: article.isBookmarked
                                  ? Colors.white
                                  : AppColors.text,
                            ),
                            child: Icon(
                              article.isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
