class Animal {
  String name;
  int age;
  String species;

  Animal(this.name, this.age, this.species);

  void makeSound() {
    print('$name makes a generic animal sound');
  }

  void eat() {
    print('$name is eating');
  }

  void sleep() {
    print('$name is sleeping');
  }
}

class Dog extends Animal {
  String breed;

  Dog(String name, int age, this.breed) : super(name, age, 'Dog');

  @override
  void makeSound() {
    print('$name barks');
  }

  void bark() {
    print('$name says: Woof!');
  }

  void fetch() {
    print('$name is fetching the ball');
  }
}

class Cat extends Animal {
  String color;

  Cat(String name, int age, this.color) : super(name, age, 'Cat');

  @override
  void makeSound() {
    print('$name meows');
  }

  void meow() {
    print('$name says: Meow!');
  }

  void purr() {
    print('$name is purring');
  }
}

class Bird extends Animal {
  bool canFly;

  Bird(String name, int age, this.canFly) : super(name, age, 'Bird');

  @override
  void makeSound() {
    print('$name chirps');
  }

  void chirp() {
    print('$name says: Chirp chirp!');
  }

  void fly() {
    if (canFly) {
      print('$name is flying');
    } else {
      print('$name cannot fly');
    }
  }
}

void main() {
  print('--- Dog Testing ---');
  Dog myDog = Dog('Buddy', 3, 'Golden Retriever');
  myDog.makeSound();
  myDog.bark();
  myDog.fetch();
  myDog.eat();

  print('\n--- Cat Testing ---');
  Cat myCat = Cat('Whiskers', 2, 'Tabby');
  myCat.makeSound();
  myCat.meow();
  myCat.purr();

  print('\n--- Bird Testing ---');
  Bird myBird = Bird('Tweety', 1, true);
  myBird.makeSound();
  myBird.chirp();
  myBird.fly();
}
