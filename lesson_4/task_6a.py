# 6. Реализовать два небольших скрипта:
# # а) бесконечный итератор, генерирующий целые числа, начиная с указанного,
# # б) бесконечный итератор, повторяющий элементы некоторого списка, определенного заранее.
# # Подсказка: использовать функцию count() и cycle() модуля itertools.

from itertools import count
from time import sleep


while True:
    user_num = input(f'Введите целое число: ')
    try:
        user_num = int(user_num)
        break
    except ValueError:
        print('Некорректное значение, повторите ввод.')

for i in count(user_num):
    sleep(0.5)
    print(i)
