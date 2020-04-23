# 5. Создать (программно) текстовый файл, записать в него программно набор чисел, разделенных пробелами. Программа
# должна подсчитывать сумму чисел в файле и выводить ее на экран.


from random import randint


# создание файла и запись в него случайного набора чисел
my_file = open('text_file_task_5.txt', 'w+', encoding='UTF-8')
print(' '.join([str(randint(-100, 100)) for i in range(randint(10, 20))]), file=my_file)
my_file.seek(0)

# чтение файла (предположим, программная запись была отдельно) и подсчет суммы чисел
num_list = my_file.read().split(' ')
result = 0
for num in num_list:
    result += int(num)
print(f'Сумма чисел в файле: {result}')
my_file.close()
