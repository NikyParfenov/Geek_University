# 4. Создать (не программно) текстовый файл со следующим содержимым:
# One — 1
# Two — 2
# Three — 3
# Four — 4
# Необходимо написать программу, открывающую файл на чтение и считывающую построчно данные. При этом английские
# числительные должны заменяться на русские. Новый блок строк должен записываться в новый текстовый файл.

with open('text_file_task_4.txt', 'r', encoding='UTF-8') as ini_file:
    file_list = ini_file.read().splitlines()

# создание словаря-переводчика key = "Английский", value = "Русский"
translate_dict = {'One': 'Один',
                  'Two': 'Два',
                  'Three': 'Три',
                  'Four': 'Четыре',
                  }

# создание словаря и перевод числительных: key = "number", value = "text"
file_dict = {}
for line in range(len(file_list)):
    temp = list(file_list[line].split(' — '))
    file_dict[temp[1]] = translate_dict[temp[0]]

# запись результата в новый файл
with open('text_file_task_4_new.txt', 'w', encoding='UTF-8') as new_file:
    for key, value in file_dict.items():
        print(value, ' — ', key, file=new_file)
