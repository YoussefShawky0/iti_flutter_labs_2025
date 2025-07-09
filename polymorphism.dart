class LibraryItem {
  String _title;
  String _author;
  String _itemId;
  bool _isAvailable;

  LibraryItem(this._title, this._author, this._itemId, this._isAvailable);

  String get title => _title;
  String get author => _author;
  String get itemId => _itemId;
  bool get isAvailable => _isAvailable;

  set title(String title) => _title = title;
  set author(String author) => _author = author;
  set itemId(String itemId) => _itemId = itemId;
  set isAvailable(bool available) => _isAvailable = available;

  void checkOut() {
    if (_isAvailable) {
      _isAvailable = false;
      print('${_title} has been checked out.');
    } else {
      print('${_title} is not available for checkout.');
    }
  }

  void checkIn() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('${_title} has been checked in.');
    } else {
      print('${_title} is already available.');
    }
  }

  void displayInfo() {
    print('Title: $title');
    print('Author: $author');
    print('ID: $itemId');
    print('Status: ${isAvailable ? "Available" : "Checked Out"}');
    print('');
  }
}

class Book extends LibraryItem {
  String _genre;
  int _pages;

  Book(
    String title,
    String author,
    String itemId,
    bool isAvailable,
    this._genre,
    this._pages,
  ) : super(title, author, itemId, isAvailable);

  String get genre => _genre;
  set genre(String genre) => _genre = genre;

  int get pages => _pages;
  set pages(int pages) => _pages = pages;

  @override
  void displayInfo() {
    print('BOOK:');
    print('Title: $title');
    print('Author: $author');
    print('ID: $itemId');
    print('Genre: $_genre');
    print('Pages: $_pages');
    print('Status: ${isAvailable ? "Available" : "Checked Out"}');
    print('');
  }
}

class Magazine extends LibraryItem {
  String _issueNumber;
  String _publishDate;

  Magazine(
    String title,
    String author,
    String itemId,
    bool isAvailable,
    this._issueNumber,
    this._publishDate,
  ) : super(title, author, itemId, isAvailable);

  String get issueNumber => _issueNumber;
  set issueNumber(String issueNumber) => _issueNumber = issueNumber;

  String get publishDate => _publishDate;
  set publishDate(String publishDate) => _publishDate = publishDate;

  @override
  void displayInfo() {
    print('MAGAZINE:');
    print('Title: $title');
    print('Publisher: $author');
    print('ID: $itemId');
    print('Issue: $_issueNumber');
    print('Published: $_publishDate');
    print('Status: ${isAvailable ? "Available" : "Checked Out"}');
    print('');
  }
}

class DVD extends LibraryItem {
  String _director;
  int _duration;
  String _rating;

  DVD(
    String title,
    String author,
    String itemId,
    bool isAvailable,
    this._director,
    this._duration,
    this._rating,
  ) : super(title, author, itemId, isAvailable);

  String get director => _director;
  set director(String director) => _director = director;

  int get duration => _duration;
  set duration(int duration) => _duration = duration;

  String get rating => _rating;
  set rating(String rating) => _rating = rating;

  @override
  void displayInfo() {
    print('DVD:');
    print('Title: $title');
    print('Studio: $author');
    print('ID: $itemId');
    print('Director: $_director');
    print('Duration: $_duration minutes');
    print('Rating: $_rating');
    print('Status: ${isAvailable ? "Available" : "Checked Out"}');
    print('');
  }
}

class LibraryCatalog {
  List<LibraryItem> _items = [];

  void addItem(LibraryItem item) {
    _items.add(item);
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.itemId == itemId);
  }

  LibraryItem? findItem(String itemId) {
    try {
      return _items.firstWhere((item) => item.itemId == itemId);
    } catch (e) {
      return null;
    }
  }

  void displayCatalog() {
    print('LIBRARY CATALOG:');
    for (LibraryItem item in _items) {
      item.displayInfo();
    }
  }
}

void main() {
  LibraryCatalog catalog = LibraryCatalog();

  Book book1 = Book(
    'The Great Gatsby',
    'F. Scott Fitzgerald',
    'B001',
    true,
    'Fiction',
    180,
  );
  Magazine mag1 = Magazine(
    'National Geographic',
    'National Geographic Society',
    'M001',
    true,
    'Vol. 241 No. 3',
    'March 2024',
  );
  DVD dvd1 = DVD(
    'Inception',
    'Warner Bros',
    'D001',
    true,
    'Christopher Nolan',
    148,
    'PG-13',
  );

  catalog.addItem(book1);
  catalog.addItem(mag1);
  catalog.addItem(dvd1);

  catalog.displayCatalog();

  book1.checkOut();
  book1.checkIn();
}
