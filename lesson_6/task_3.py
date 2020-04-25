# 3. Реализовать базовый класс Worker (работник), в котором определить атрибуты: name, surname, position (должность),
# income (доход). Последний атрибут должен быть защищенным и ссылаться на словарь, содержащий элементы: оклад и
# премия, например, {"wage": wage, "bonus": bonus}. Создать класс Position (должность) на базе класса Worker. В
# классе Position реализовать методы получения полного имени сотрудника (get_full_name) и дохода с учетом премии (
# get_total_income). Проверить работу примера на реальных данных (создать экземпляры класса Position,
# передать данные, проверить значения атрибутов, вызвать методы экземпляров).


class Worker:
    def __init__(self, name: str, surname: str, position: str, salary: int, bonus: int):
        self.name = name
        self.surname = surname
        self.position = position
        self._income = {'salary': salary,
                        'bonus': bonus,
                        }


class Position(Worker):
    def __init__(self, name: str, surname: str, position: str, salary: int, bonus: int):
        super().__init__(name, surname, position, salary, bonus)
        self.full_name = f'{name} {surname}'
        self.total_income = f"{self._income['salary'] + self._income['bonus']}"

    def get_full_name(self):
        return self.full_name

    def get_total_income(self):
        return self.total_income


ivan = Position(name='Ivan', surname='Ivanov', position='Seller', salary=40000, bonus=20000)
gena = Position(name='Gennady', surname='Gennadiev', position='Administrator', salary=60000, bonus=30000)
print(f'Name: {ivan.name}')
print(f'Surname: {ivan.surname}')
print(f'Position: {ivan.position}')
print(f'Income: {ivan._income}')
print(f'{ivan.get_full_name()} {ivan.get_total_income()}')
print(f'Name: {gena.name}')
print(f'Surname: {gena.surname}')
print(f'Position: {gena.position}')
print(f'Income: {gena._income}')
print(f'{gena.get_full_name()} {gena.get_total_income()}')
