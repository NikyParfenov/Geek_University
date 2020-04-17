# 1. Реализовать функцию, принимающую два числа (позиционные аргументы) и выполняющую их деление. Числа запрашивать у
# пользователя, предусмотреть обработку ситуации деления на ноль


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


def elem_div(a: float, b: float) -> float:
    """
    Функция деления a/b
    :param a: float
    :param b: float
    :return: float
    """
    try:
        return round(float(a) / float(b), 2)
    except ZeroDivisionError:
        return None


while True:
    user_num = input('Введите через пробел числа <a> и <b> для деления <a/b>: ').split(' ')
    if len(user_num) == 2 and num_isfloat(*user_num):
        print(f'Ответ {elem_div(user_num[0], user_num[1])}')
        break
    else:
        print('Некорректный ввод чисел, повторите ввод.')
