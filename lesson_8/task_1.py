# 1. Реализовать класс «Дата», функция-конструктор которого должна принимать дату в виде строки формата
# «день-месяц-год». В рамках класса реализовать два метода. Первый, с декоратором @classmethod, должен извлекать
# число, месяц, год и преобразовывать их тип к типу «Число». Второй, с декоратором @staticmethod, должен проводить
# валидацию числа, месяца и года (например, месяц — от 1 до 12). Проверить работу полученной структуры на реальных
# данных.


class Date:
    def __init__(self, date: str):
        self.date = date

    @classmethod
    def num_extract(cls, date: str) -> list:
        cls.date_num = list(map(int, date.split('-')))
        return cls.date_num

    @staticmethod
    def date_check(date_list: list):
        month_day_check_list = [4, 6, 9, 11]
        error_date = f'Некорректно введена дата'

        # проверка корректности введенного месяца
        if 0 < date_list[1] < 13:

            # проверка даты месяцев 4, 6, 9, 11 = [1; 30], остальные = [1; 31]
            if month_day_check_list.count(date_list[1]):
                if not 0 < date_list[0] < 31:
                    print(error_date)
            elif not 0 < date_list[0] < 32:
                print(error_date)

            # проверка даты февраля, в том числе на високостный год (каждый 4-й год)
            if date_list[1] == 2:
                if date_list[2] % 4 == 0:
                    if not 0 < date_list[0] < 30:
                        print(error_date)
                elif not 0 < date_list[0] < 29:
                    print(error_date)

        else:
            print(error_date)

    def __str__(self) -> str:
        return f'{self.date_num}'


a = Date.num_extract('29-22-2020')
Date.date_check(a)
print(a)
