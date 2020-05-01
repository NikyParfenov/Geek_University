# 1. Реализовать класс Matrix (матрица). Обеспечить перегрузку конструктора класса (метод init()), который должен
# принимать данные (список списков) для формирования матрицы.
# Подсказка: матрица — система некоторых математических величин, расположенных в виде прямоугольной схемы.
# Примеры матриц вы найдете в методичке.
# Следующий шаг — реализовать перегрузку метода str() для вывода матрицы в привычном виде.
# Далее реализовать перегрузку метода add() для реализации операции сложения двух объектов класса Matrix (двух матриц).
# Результатом сложения должна быть новая матрица.
# Подсказка: сложение элементов матриц выполнять поэлементно — первый элемент первой строки первой матрицы
# складываем с первым элементом первой строки второй матрицы и т.д.
from random import randint


class Matrix:
    def __init__(self, input_matrix_list: list):
        self.matrix = input_matrix_list
        self.rows = len(self.matrix)
        self.columns = len(self.matrix[0])

    def __str__(self):
        # Долго мучился со скобками, поэтому разбил по строкам для читабельности
        # Внутренний цикл по i - столбцы матрицы (вложенные списки), Внешний цикл по j - строки матрицы (сам список)
        general_print_format = '\n '.join([
                                           ' '.join([str(self.matrix[j][i]) for i in range(self.columns)])
                                           for j in range(self.rows)
                                          ])
        return general_print_format

    def __add__(self, other):
        # создаем суммарную матрицу
        result_matrix = []
        # строка матрицы (вложенный список суммарной матрицы)
        result_matrix_lines = []

        # Сумма элементов матриц идет построчно (по вложенным спискам)
        # Внешний цикл j пробегает по каждой из строк матриц, внутренний i - по столбцам (элементам строки матрицы)
        for j in range(self.rows):
            for i in range(self.columns):
                result_matrix_lines.append(self.matrix[j][i] + other.matrix[j][i])
            # заполненный вложенный список переносим в результирующую матрицу, обнуляем вложенный список
            result_matrix.append(result_matrix_lines)
            result_matrix_lines = []
        return Matrix(result_matrix)


# Задаем размерности для обеих матриц. По правилам сложения размерности суммируемых матриц должны быть равны.
matrix_rows = 3
matrix_columns = 5

# Собираем матрицу из того, что получится в randint
my_matrix = Matrix([[randint(-100, 100) for _ in range(matrix_columns)] for _ in range(matrix_rows)])
add_matrix = Matrix([[randint(-100, 100) for _ in range(matrix_columns)] for _ in range(matrix_rows)])

print('Первая матрица\n', my_matrix, '\n')
print('Вторая матрица\n', add_matrix, '\n')
print('Сумма матриц\n', my_matrix + add_matrix)
