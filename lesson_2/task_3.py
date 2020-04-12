# 3. Пользователь вводит месяц в виде целого числа от 1 до 12. Сообщить к какому времени года относится месяц (зима,
# весна, лето, осень). Напишите решения через list и через dict

# Ввод и проверка ввода числа от 1 до 12
user_month = input('Введите номер месяца от 1 до 12: ')
while True:
    if user_month.isdigit() and 1 <= int(user_month) <= 12:
        user_month = int(user_month)
        break
    else:
        user_month = input('Некорректный ввод. Введите номер месяца от 1 до 12: ')

# < БЛОК РЕШЕНИЯ ЧЕРЕЗ LIST >
season_list = ['Зима',
               'Весна',
               'Лето',
               'Осень']
# print(season_list, len(season_list), type(season_list))
if 1 <= user_month < 12:
    temp = season_list[user_month//3]
else:
    temp = season_list[0]
print(f'LIST: Ввденный месяц {user_month} относится ко времени года {temp}')


# < БЛОК РЕШЕНИЯ ЧЕРЕЗ DICT >
# Стандартный ввод словаря
# season_dict = {1: 'Зима',
#                2: 'Зима',
#                3: 'Весна',
#                4: 'Весна',
#                5: 'Весна',
#                6: 'Лето',
#                7: 'Лето',
#                8: 'Лето',
#                9: 'Осень',
#                10: 'Осень',
#                11: 'Осень',
#                12: 'Зима'}

# Решил попробовать оптимизировать задание словаря через введенный ранее list
season_dict = dict()
for i in range(3*len(season_list)):
    season_dict[i] = season_list[i//3]
season_dict[12] = season_dict.pop(0)
# print(season_dict, len(season_dict), type(season_dict))
print(f'DICT: Ввденный месяц {user_month} относится ко времени года {season_dict[user_month]}')
