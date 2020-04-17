# 2. Реализовать функцию, принимающую несколько параметров, описывающих данные пользователя: имя, фамилия,
# год рождения, город проживания, email, телефон. Функция должна принимать параметры как именованные аргументы.
# Реализовать вывод данных о пользователе одной строкой


def input_check(*args: list) -> None:
    """
    Функция добавляет в список пустой элемент при отсутствии ввода какого-либо параметра
    :param args: list
    :return: None
    """
    for user_list in args:
        while len(user_list) < 2:
            user_list.append(' ')


def user_info(name: str, surname: str, birth: str, city: str, phone: str, email: str) -> None:
    """
    Функция выводит информацию о пользователе
    :param name: str
    :param surname: str
    :param birth: str
    :param city: str
    :param phone: str
    :param email: str
    :return: None
    """
    print(f'ФИО: {name} {surname}, место/дата рождения: {city} {birth}, контакты: {phone} {email}')


full_name = input('Введите имя и фамилию: ').split(' ')
birth_info = input('Введите дату и город рождения: ').split(' ')
contact_info = input('Введите email и номер телефона: ').split(' ')
input_check(full_name, birth_info, contact_info)

user_info(name=full_name[0],
          surname=full_name[1],
          birth=birth_info[0],
          city=birth_info[1],
          phone=contact_info[0],
          email=contact_info[1])
