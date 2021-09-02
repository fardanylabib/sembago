class Employee{
  String name;
  String email;
  Employee({this.name, this.email});
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
}