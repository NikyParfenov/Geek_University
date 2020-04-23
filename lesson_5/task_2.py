# 2. Создать текстовый файл (не программно), сохранить в нем несколько строк, выполнить подсчет количества строк,
# количества слов в каждой строке.

my_file = open('text_file_task_2.txt', 'r', encoding='UTF-8')
line_list = my_file.read().splitlines()
print(f'Число строк в файле {my_file.name}: {len(line_list)}')
for line in range(len(line_list)):
    print(f'Число слов в строке {line + 1}: {len(line_list[line].split(" "))}')
my_file.close()
