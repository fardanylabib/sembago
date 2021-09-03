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
}

class Store{
  String id;
  String inventoryID;
  String address ;
  List<Employee> employees ;
  String name ;
  String phone ;
  Store({
    this.id,
    this.inventoryID,
    this.name,
    this.address,
    this.employees,
    this.phone,
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
    final _employeeData = data['employees'] as List<dynamic>;
    final _employees = _employeeData == null ? <Employee>[] : 
        _employeeData.map((emp) => Employee.fromJson(emp)).toList();
    // return result passing all the arguments
    return Store(
      id: data['id'] as String,
      inventoryID: _inventoryID,
      name: _name,
      address: _address,
      phone: _phone,
      employees: _employees
    );
  }
}