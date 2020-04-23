# 3. Создать текстовый файл (не программно), построчно записать фамилии сотрудников и величину их окладов.
# Определить, кто из сотрудников имеет оклад менее 20 тыс., вывести фамилии этих сотрудников. Выполнить подсчет
# средней величины дохода сотрудников.

# предполагается, что файл с ФИО - ЗП собран корректно и проверок не требует
with open('text_file_task_3.txt', 'r', encoding='UTF-8') as my_file:
    file_lines = my_file.read().splitlines()

# создание словаря key = фамилия, value = оклад
salary_dict = {}
for line in range(len(file_lines)):
    temp = list(file_lines[line].split(' '))
    salary_dict[temp[0]] = temp[1]

# вывод результата
salary_average = 0
print(f'Сотрудники с окладом ниже 20 тыс.₽:')
for key, value in salary_dict.items():
    if int(value) < 20000:
        print(str(key))
    salary_average += int(value)
print(f'Средняя зарплата всех сотрудников: {salary_average / len(salary_dict)} ₽')
