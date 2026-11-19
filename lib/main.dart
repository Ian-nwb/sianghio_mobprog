// Week 3 Lab - Mini Challenge TEMPLATE: Build My Movie Night (Flutter)
// Paste this into DartPad in FLUTTER mode (the counter app link).
// It runs as-is. Fill in the three TODO sections below, then press Run.
//
// FILL IN 1: the language() and recommendation() methods.
// FILL IN 2: your watchlist (1 example given, replace it with 4 movies you love).
// FILL IN 3: the summary numbers: totalBoxOffice, avgDuration, topGrossing.

import 'package:flutter/material.dart';

// ============================================================
// FILL IN 1: The Movie class
// The fields and constructor are done for you.
// Fill in language() and recommendation() below.
// ============================================================
class Movie {
  String title;
  String director;
  int duration; // in minutes
  double boxOffice; // box office revenue, in millions of dollars
  bool isTagalog; // true = Tagalog, false = English
  double imdb; // IMDb score out of 10
  int rottenTomatoes; // Rotten Tomatoes score, in percent

  Movie(
    this.title,
    this.director,
    this.duration,
    this.boxOffice,
    this.isTagalog,
    this.imdb,
    this.rottenTomatoes,
  );

  // TODO: return 'Tagalog' if isTagalog is true, else 'English'.
  // Hint: if (isTagalog) { return 'Tagalog'; } else { return 'English'; }
  String language() {
    if (isTagalog == true) {
      return 'Tagalog';
    } else {
      return 'English';
    }
  }

  // TODO: recommend the movie based on its review scores.
  // - 'Highly recommended' if IMDb is 8.0 or higher AND Rotten Tomatoes is 90 or higher
  // - 'Recommended' if IMDb is 7.0 or higher AND Rotten Tomatoes is 70 or higher
  // - 'Mixed reviews' for anything else
  // Hint: use an if / else if chain, and && means "and".
  String recommendation() {
    if (imdb >= 8.0 && rottenTomatoes >= 90) {
      return 'Highly recommended'; // TODO: fill in the if / else if chain
    } else if (imdb >= 7.0 && rottenTomatoes >= 70) {
      return 'Recommended';
    } else {
      return 'Mixed reviews';
    }
  }
}

void main() => runApp(const MovieNightApp());

class MovieNightApp extends StatelessWidget {
  const MovieNightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sianghio's Movie List",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MovieNightPage(),
    );
  }
}

class MovieNightPage extends StatefulWidget {
  const MovieNightPage({super.key});

  @override
  State<MovieNightPage> createState() => _MovieNightPageState();
}

class _MovieNightPageState extends State<MovieNightPage> {
  // ============================================================
  // FILL IN 2: Your watchlist
  // One example is given. Replace it with 4 movies you love.
  // Movie('Title', 'Director', duration in minutes, box office in $M,
  //       isTagalog, IMDb score, Rotten Tomatoes %)
  // ============================================================
  final List<Movie> watchlist = [
    Movie('Fight Club', 'David Fincher', 139, 101.8, false, 8.8, 96),
    Movie('American Psycho', 'Denis Villeneuve', 152, 287.3, false, 8.0, 94),
    Movie(' Praybeyt Benjamin', 'Wenn V. Deramas', 95, 7.65, true, 5.0, 0),
    Movie(
      'Amazing Praybeyt Benjamin',
      'Wenn V. Deramas',
      105,
      9,
      false,
      4.4,
      0,
    ),
  ];

  String query = '';

  // The list shown on screen: everything, or only the titles that match the search.
  List<Movie> get shown {
    if (query.isEmpty) {
      return watchlist;
    }
    return watchlist
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // ============================================================
  // FILL IN 3: The summary numbers
  // Fill in each one below. The summary card on screen uses them.
  // ============================================================

  // TODO: add up the boxOffice of every movie in the watchlist.
  // Hint: loop through the watchlist and add each movie's boxOffice,
  // or use watchlist.fold(0, (sum, m) => sum + m.boxOffice).
  double get totalBoxOffice {
    double total;
    total = 0;
    for (final movie in watchlist) {
      total += movie.boxOffice;
    }
    return total; // TODO: fill in
  }

  // TODO: add up all the durations, then divide by the number of movies.
  // Hint: loop through the watchlist and add each movie's duration,
  // then divide the total by watchlist.length.
  int get avgDuration {
    if (watchlist.isEmpty) return 0;
    int totalDuration = 0;
    for (final movie in watchlist) {
      totalDuration += movie.duration;
    }
    return totalDuration ~/ watchlist.length;
  }

  // TODO: find the movie with the biggest boxOffice.
  // Hint: loop through the watchlist, keep the movie with the biggest
  // boxOffice so far, and return it at the end.
  Movie get topGrossing {
    Movie highest = watchlist[0];
    for (final movie in watchlist) {
      if (movie.boxOffice > highest.boxOffice) {
        highest = movie;
      }
    }
    return highest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: replace Surname with your own surname.
        title: const Text("Sianghio's Movie List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search a movie by title',
                hintText: 'Type a title, e.g. The Dark Knight',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total box office: \$${totalBoxOffice}M'),
                  Text(
                    'Average duration: ${avgDuration.toStringAsFixed(1)} min',
                  ),
                  Text('Highest grossing: ${topGrossing.title}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: shown.isEmpty
                ? const Center(child: Text('No movie matches your search.'))
                : ListView.builder(
                    itemCount: shown.length,
                    itemBuilder: (context, index) {
                      final m = shown[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      m.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('${m.director}  •  ${m.duration} min'),
                                    Text(
                                      '${m.language()}  •  Box office: \$${m.boxOffice}M',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Chip(label: Text(m.recommendation())),
                                  Text('IMDb ${m.imdb.toStringAsFixed(1)}'),
                                  Text('RT ${m.rottenTomatoes}%'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
