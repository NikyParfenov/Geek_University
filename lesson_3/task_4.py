# 4. Программа принимает действительное положительное число x и целое отрицательное число y. Необходимо выполнить
# возведение числа x в степень y. Задание необходимо реализовать в виде функции my_func(x, y). При решении задания
# необходимо обойтись без встроенной функции возведения числа в степень. Подсказка: попробуйте решить задачу двумя
# способами. Первый — возведение в степень с помощью оператора **. Второй — более сложная реализация без оператора
# **, предусматривающая использование цикла.


def input_number(input_text: str) -> int:
    """
    Функция ввода и проверки целого числа
    :param input_text: str
    :return: int
    """
    while True:
        input_num = input(input_text)
        try:
            return int(input_num)
        except ValueError:
            print('Некорректное значение, повторите ввод.')
            continue


def my_func_1(a: int, b: int) -> float:
    """
    Функция возведения в степень
    :param a: int
    :param b: int
    :return: float
    """
    return a ** b


def my_func_2(a: int, b: int) -> float:
    """
    Функция возведения в степень
    :param a: int
    :param b: int
    :return: float
    """
    result = 1
    for i in range(abs(b)):
        result *= 1 / a if b < 0 else a  # если степень будет >0, код сработает
    return result


num_a = input_number('Введите первое число: ')
num_b = input_number('Введите второе число: ')
print('Первый вариант: ', my_func_1(num_a, num_b))
print('Второй вариант: ', my_func_2(num_a, num_b))
