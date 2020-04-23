# 7. Создать (не программно) текстовый файл, в котором каждая строка должна содержать данные о фирме: название,
# форма собственности, выручка, издержки.
# Пример строки файла: firm_1 ООО 10000 5000.
# Необходимо построчно прочитать файл, вычислить прибыль каждой компании, а также среднюю прибыль. Если фирма получила
# убытки, в расчет средней прибыли ее не включать.
# Далее реализовать список. Он должен содержать словарь с фирмами и их прибылями, а также словарь со средней прибылью.
# Если фирма получила убытки, также добавить ее в словарь (со значением убытков).
# Пример списка: [{“firm_1”: 5000, “firm_2”: 3000, “firm_3”: 1000}, {“average_profit”: 2000}].
# Итоговый список сохранить в виде json-объекта в соответствующий файл.
# Пример json-объекта:
#
# [{"firm_1": 5000, "firm_2": 3000, "firm_3": 1000}, {"average_profit": 2000}]
# Подсказка: использовать менеджеры контекста.
import json


with open('text_file_task_7.txt', 'r', encoding='UTF-8') as ini_file:
    file_list = ini_file.read().splitlines()
    file_list.pop(0)  # в файле первая строка - шаблон оформления, её убираем

# на основе списка из файла создаем словарь с key = фирма, value = прибыль
company_profit = {}
profits_list = []  # временный список прибылей для оценки среднего
for line in range(len(file_list)):
    temp = list(file_list[line].split(' '))
    company_profit[temp[0]] = int(temp[2]) - int(temp[3])
    if company_profit[temp[0]] >= 0:
        profits_list.append(company_profit[temp[0]])

# создаем словарь со средней прибылью неубыточных компаний и собираем все в виде list в файл json
average_profit = {'average_profit': sum(profits_list) / len(profits_list)}
result_list = [company_profit, average_profit]
print(result_list)
with open('text_file_task_7.json', 'w', encoding='UTF-8') as new_file:
    json.dump(result_list, new_file)
