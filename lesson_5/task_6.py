# 6. Необходимо создать (не программно) текстовый файл, где каждая строка описывает учебный предмет и наличие
# лекционных, практических и лабораторных занятий по этому предмету и их количество. Важно, чтобы для каждого
# предмета не обязательно были все типы занятий. Сформировать словарь, содержащий название предмета и общее
# количество занятий по нему. Вывести словарь на экран.
# # Примеры строк файла:
# #
# # Информатика: 100(л) 50(пр) 20(лаб).
# # Физика: 30(л) — 10(лаб)
# # Физкультура: — 30(пр) —
# # Пример словаря:
# #
# # {“Информатика”: 170, “Физика”: 40, “Физкультура”: 30}


def extract_numbers(var_str: str) -> str:
    """
    Функция оставляет в строке только цифры и удаляет все другие символы. Если цифр нет, то возвращает 0
    :param var_str: str
    :return: str
    """
    result_str = ''
    for var_char in var_str:
        if var_char.isdigit():
            result_str += var_char
    return result_str if result_str else 0


with open('text_file_task_6.txt', 'r', encoding='UTF-8') as my_file:
    file_lines = my_file.read().splitlines()

# создание словаря key = предмет, value = список из кол-во часов + типа занятий
subjects_dict = {}
for line in range(len(file_lines)):
    temp = list(file_lines[line].split(': '))
    subjects_dict[temp[0]] = temp[1].split(' ')

# Т.к. ввод часов может сопровождаться разношестными "мусорными" символами,
# то с помощью extract_numbers подчищаем список часов, а далее суммируем часы и выводим результат
for i in subjects_dict.keys():
    total_hours = 0
    for j in range(len(subjects_dict[i])):
        total_hours += int(extract_numbers(subjects_dict[i][j]))
    subjects_dict[i] = total_hours
print(subjects_dict)
