class Employee

  attr_reader :name, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    add_children_to_boss
  end

  def bonus(multiplier)
    @salary = @salary * multiplier
  end

  def salary
    @salary
  end

  def add_children_to_boss
    @boss.employees = self unless @boss.nil?
  end
end

class Manager < Employee

  def initialize(name, title, salary, boss = nil)
    @employees = []
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    @salary = sum_salary * multiplier
  end

  def sum_salary
    total_salary = 0

    @employees.each do |employee|
      if employee.is_a?(Manager)
        total_salary += employee.sum_salary
      end

      total_salary += employee.salary
    end
    total_salary
  end

  def employees
    @employees
  end

  def employees=(employee)
    @employees << employee
  end
end

ned = Manager.new("Ned", "Founder", 1000000)
daren = Manager.new("Daren", "TA Manager", 78000, ned)
shawna = Employee.new("Shawna", "TA", 12000, daren)
david = Employee.new("David", "TA", 10000, daren)
