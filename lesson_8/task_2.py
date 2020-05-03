# 2. Создайте собственный класс-исключение, обрабатывающий ситуацию деления на нуль. Проверьте его работу на данных,
# вводимых пользователем. При вводе пользователем нуля в качестве делителя программа должна корректно обработать эту
# ситуацию и не завершиться с ошибкой.


class ZeroDivExcept(Exception):
    def __init__(self, text):
        self.text = text

    def __str__(self):
        return self.text


user_num = list(map(float, input('Введите два числа через пробел: ').split(' ')))

try:
    if user_num[1] == 0:
        raise ZeroDivExcept('Деление на ноль!')
except ZeroDivExcept as my_error:
    print(my_error)
else:
    print(round(user_num[0] / user_num[1], 2))
