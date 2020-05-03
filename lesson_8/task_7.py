# 7. Реализовать проект «Операции с комплексными числами». Создайте класс «Комплексное число», реализуйте перегрузку
# методов сложения и умножения комплексных чисел. Проверьте работу проекта, создав экземпляры класса (комплексные
# числа) и выполнив сложение и умножение созданных экземпляров. Проверьте корректность полученного результата.


class ComplexNum:

    def __init__(self, a: float, b: float):
        self.complex_number = complex(a, b)

    def __add__(self, other) -> complex:
        return self.complex_number + other.complex_number

    def __mul__(self, other) -> complex:
        return self.complex_number * other.complex_number

    # по аналогии можно разность и деление вставить
    def __sub__(self, other) -> complex:
        return self.complex_number + other.complex_number

    def __truediv__(self, other) -> complex:
        return self.complex_number / other.complex_number

    # чтобы в print'е тела программы не городить обращения к атрибуту объекта
    def __str__(self) -> str:
        return f'{self.complex_number}'


x1 = ComplexNum(2, 4)
x2 = ComplexNum(1, 7)
print(f'Заданы числа: х1={x1} и x2={x2}\n'
      f'Сумма чисел:  x1+x2={x1 + x2}\n'
      f'Произведение: x1*x2={x1 * x2}\n'
      f'Разность:     x1-x2={x1 - x2}\n'
      f'Отношение:    x1/x2={x1 / x2}')
