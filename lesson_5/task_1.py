# 1. Создать программно файл в текстовом формате, записать в него построчно данные, вводимые пользователем. Об
# окончании ввода данных свидетельствует пустая строка.

my_file = open('text_file_task_1.txt', 'w', encoding='UTF-8')
while True:
    user_text = input('Введите текст: ')
    print(user_text, file=my_file)
    if user_text == '':
        break
my_file.close()
