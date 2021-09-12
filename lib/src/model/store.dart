class Employee{
  String name;
  String email;
  Employee({this.name, this.email});
  factory Employee.fromJson(Map<String, dynamic> data) {
    final _name = data['name'] as String;
    final _email = data['email'] as String;
    // return result passing all the arguments
    return Employee(
      name: _name,
      email: _email
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'email': this.email,
    };
  }
}

class Store{
  String id;
  String inventoryID;
  String address ;
  List<Employee> employees ;
  String name ;
  String phone ;
  String picture;
  Store({
    this.id,
    this.inventoryID,
    this.name,
    this.address,
    this.employees,
    this.phone,
    this.picture,
  });

  void addEmployees(List<Employee> employee){
    this.employees.addAll(employee);
  }

  factory Store.fromJson(Map<String, dynamic> data) {
    final _id = data['id'] as String;
    final _inventoryID = data['inventoryID'] as String;
    final _name = data['name'] as String;
    final _address = data['address'] as String;
    final _phone = data['phone'] as String;
    final _picture = data['picture'] as String;
    final _employeeData = data['employees'] as List<dynamic>;
    final _employees = _employeeData == null ? <Employee>[] : 
        _employeeData.map((emp) => Employee.fromJson(emp)).toList();
    // return result passing all the arguments
    return Store(
      id: _id,
      inventoryID: _inventoryID,
      name: _name,
      address: _address,
      phone: _phone,
      employees: _employees,
      picture: _picture
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> _emps = this.employees.map((emp) => emp.toJson()).toList();
    return {
      'name': this.name,
      'inventoryID': this.inventoryID,
      'address': this.address,
      'phone': this.phone,
      'employees': _emps,
      'picture': this.picture
    };
  }
}