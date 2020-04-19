# 7. Реализовать генератор с помощью функции с ключевым словом yield, создающим очередное значение. При вызове
# функции должен создаваться объект-генератор. Функция должна вызываться следующим образом: for el in fibo_gen().
# Функция отвечает за получение факториала числа, а в цикле необходимо выводить только первые 15 чисел. Подсказка:
# факториал числа n — произведение чисел от 1 до n. Например, факториал четырёх 4! = 1 * 2 * 3 * 4 = 24.
# from math import factorial


def fibo_gen(fact_number):
    result = 1
    for i in range(1, fact_number+1, 1):
        result *= i
        yield result
        # yield factorial(i)


while True:
    user_num = input(f'Введите целое число: ')
    try:
        user_num = int(user_num)
        break
    except ValueError:
        print('Некорректное значение, повторите ввод.')


j = 1
for el in fibo_gen(user_num):
    if j < 16 or j == user_num:
        print(f'{j}! = {el}')
    elif j == user_num - 1:
        print('...')
    j += 1
