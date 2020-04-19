# 2. Представлен список чисел. Необходимо вывести элементы исходного списка, значения которых больше предыдущего
# элемента. Подсказка: элементы, удовлетворяющие условию, оформить в виде списка. Для формирования списка
# использовать генератор.
import random


var_list = [random.randrange(0, 100) for element in range(random.randint(10, 20))]
new_list = [var_list[i] for i in range(len(var_list)) if var_list[i] > var_list[i-1]]
print(f'Исх-й список: {var_list}\nНовый список: {new_list}')
