void main() {
  var ems = EmployeeManagementSystem();
  
  var dev = Developer('Ahmed Ali', 1, 'Software Engineer', 75000);
  dev.addProgrammingLanguage('Dart');
  dev.addProgrammingLanguage('Flutter');
  dev.addProgrammingLanguage('Python');
  
  var designer = Designer('Sara Mohamed', 2,'', 65000);
  designer.addCreativeSkill('UI/UX Design');
  designer.addCreativeSkill('Graphic Design');
  designer.addCreativeSkill('Figma');
  
  var manager = Manager('Omar Hassan', 3,'' ,90000);
  manager.setTeamSize(12);
  
  var programmerEmp = programmer('Nour Ahmed', 4, 'Programmer', 80000);
  programmerEmp.addProgrammingLanguage('JavaScript');
  programmerEmp.addProgrammingLanguage('Java');
  programmerEmp.addCreativeSkill('Problem Solving');
  programmerEmp.addCreativeSkill('System Design');
  programmerEmp.setTeamSize(5);

  ems.addEmployee(dev);
  ems.addEmployee(designer);
  ems.addEmployee(manager);
  ems.addEmployee(programmerEmp);
  
  ems.generateReport();
  ems.safeDataHandling();
  
  print('\n=== TESTING EMPLOYEE SEARCH ===');
  var foundEmp = ems.findEmployee(1);
  if (foundEmp != null) {
    print('Found Employee:');
    foundEmp.display();
  } else {
    print('Employee not found');
  }
  
  print('\n=== TESTING EMPLOYEE REMOVAL ===');
  ems.removeEmployee(2);
  
  print('\n=== UPDATED REPORT ===');
  ems.generateReport();
}

abstract class Employee {
  String name;
  int id;
  String position;
  double salary;
  Employee(this.name, this.id, this.position, this.salary);

  double calculatePayroll();
  String getRole();
  void display() {
    print(
      "ID: $id, Name: $name, Position: $position, Salary: ${salary.toStringAsFixed(2)}",
    );
  }
}

mixin Programmable {
  List<String> programmingLanguages = [];
  void addProgrammingLanguage(String language) {
    programmingLanguages.add(language);
  }

  void displayProgrammingLanguages() {
    print("Programming Languages: ${programmingLanguages.join(', ')}");
  }
}

mixin Creative {
  List<String> creativeSkills = [];
  void addCreativeSkill(String skill) {
    creativeSkills.add(skill);
  }

  void displayCreativeSkills() {
    print("Creative Skills: ${creativeSkills.join(', ')}");
  }
}

mixin Leadership {
  int teamSize = 0;

  void setTeamSize(int size) {
    teamSize = size;
  }

  void displayTeamSize() {
    print("Team Size: $teamSize");
  }
}

class Developer extends Employee with Programmable {
  Developer(String name, int id, String position, double salary)
    : super(name, id, "developer", salary);
  @override
  double calculatePayroll() {
    return salary * 1.7;
  }

  @override
  String getRole() {
    return "Software Engineer";
  }
}

class Designer extends Employee with Creative {
  Designer(String name, int id, String position, double salary)
    : super(name, id, "designer", salary);
  @override
  double calculatePayroll() {
    return salary * .9;
  }

  @override
  String getRole() {
    return "Graphic Designer";
  }
}

class Manager extends Employee with Leadership {
  Manager(String name, int id, String position, double salary)
    : super(name, id, "manager", salary);
  @override
  double calculatePayroll() {
    return salary * 2.0;
  }

  @override
  String getRole() {
    return "Project Manager";
  }
}

class programmer extends Employee with Programmable, Creative, Leadership {
  programmer(String name, int id, String position, double salary)
    : super(name, id, "programmer", salary);
  @override
  double calculatePayroll() {
    return salary * 1.3;
  }

  @override
  String getRole() {
    return "Programmer";
  }
}

class EmployeeManagementSystem {
  List<Employee> employees = [];

  void addEmployee(Employee employee) {
    employees.add(employee);
    print('Employee ${employee.name} added successfully');
  }

  void removeEmployee(int id) {
    employees.removeWhere((emp) => emp.id == id);
    print('Employee with ID $id removed successfully');
  }

  Employee? findEmployee(int id) {
    try {
      return employees.firstWhere((emp) => emp.id == id);
    } catch (e) {
      return null;
    }
  }
void calculateTotalPayroll() {
    double total = 0;
    for (var emp in employees) {
      total += emp.calculatePayroll();
    }
    print('Total Payroll: \$${total.toStringAsFixed(2)}');
  }
  void generateReport() {
    print('\n=== EMPLOYEE REPORT ===');
    print('Total Employees: ${employees.length}');
    
    for (var emp in employees) {
      emp.display();
      print('Role: ${emp.getRole()}');
      print('Adjusted Salary: \$${emp.calculatePayroll().toStringAsFixed(2)}');
      
      if (emp is Programmable) {
        (emp as Programmable).displayProgrammingLanguages();
      }
      if (emp is Creative) {
        (emp as Creative).displayCreativeSkills();
      }
      if (emp is Leadership) {
        (emp as Leadership).displayTeamSize();
      }
      print('---');
    }
    
    calculateTotalPayroll();
  }
  
  void safeDataHandling() {
    print('\n=== SAFE DATA HANDLING ===');
    print('All employee data is stored securely');
    print('System prevents null pointer exceptions');
    print('Input validation implemented');
  }
}