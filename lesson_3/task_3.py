# 3. Реализовать функцию my_func(), которая принимает три позиционных аргумента, и возвращает сумму наибольших двух
# аргументов


def num_isfloat(*args: any) -> bool:
    """
    Функция проверяет введенные параметры на тип float
    :param args: any
    :return: bool
    """
    for arg in args:
        try:
            float(arg)
        except ValueError:
            return False
    return True


def my_func(a: float, b: float, c: float) -> float:
    """
    Функци считает сумму 2х максимальных элементов из 3х введенных
    :param a:
    :param b:
    :param c:
    :return:
    """
    my_list = sorted([a, b, c], reverse=True)
    return my_list[0] + my_list[1]


while True:
    user_numbers = input('Введите 3 числа: ').split()
    if num_isfloat(*user_numbers) and len(user_numbers) == 3:
        break
    else:
        print('Некорректные значения, повторите ввод.')

user_numbers = [float(i) for i in user_numbers[:]]
print('Ответ:', my_func(user_numbers[0], user_numbers[1], user_numbers[2]))
