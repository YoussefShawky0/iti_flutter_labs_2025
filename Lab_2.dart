void main() {
  // Q1: Which collection allows duplicates?
  // Answer: List allows duplicates, Set and Map do not.
  List<String> myList = ['apple', 'banana', 'apple'];
  print('List with duplicates: $myList');

  // Q2: Complete the loop: for (String item ___ items) { ... }
  // Answer: for (String item in items)
  List<String> items = ['pen', 'book', 'laptop'];
  for (String item in items) {
    print('Item: $item');
  }

  // Q3: What does break do in a loop?
  // Answer: break immediately exits the nearest enclosing loop or switch statement.
  for (int i = 0; i < 5; i++) {
    if (i == 3) break;
    print('i: $i');
  }

  // Q4: Fix this function: calculateArea(int length, int width) => length * width;
  // Answer: The function is missing a return type.
  print('Area: ${calculateArea(5, 10)}');

  // Q5: Which is faster for checking if an item exists: List or Set?
  // Answer: Set is faster (O(1)) while List is slower (O(n)).
  List<int> myList2 = [1, 2, 3, 4, 5];
  Set<int> mySet = {1, 2, 3, 4, 5};
  print('List contains 3? ${myList2.contains(3)}');
  print('Set contains 3? ${mySet.contains(3)}');

  // Bonus Challenge: Write a function that returns the second largest number in a list.
  List<int> numbers = [4, 7, 2, 9, 5];
  print('Second largest: ${secondLargest(numbers)}');
}

// Q4 continued - Fixed version of the function
int calculateArea(int length, int width) => length * width;

// Bonus Challenge - Function to find the second largest number
int secondLargest(List<int> numbers) {
  Set<int> uniqueNumbers = numbers.toSet(); // Remove duplicates
  List<int> sorted = uniqueNumbers.toList()..sort();
  if (sorted.length < 2) {
    throw Exception('List must contain at least 2 unique numbers');
  }
  return sorted[sorted.length - 2];
}
