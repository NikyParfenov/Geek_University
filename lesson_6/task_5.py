# 5. Реализовать класс Stationery (канцелярская принадлежность). Определить в нем атрибут title (название) и метод
# draw (отрисовка). Метод выводит сообщение “Запуск отрисовки.” Создать три дочерних класса Pen (ручка),
# Pencil (карандаш), Handle (маркер). В каждом из классов реализовать переопределение метода draw. Для каждого из
# классов методы должен выводить уникальное сообщение. Создать экземпляры классов и проверить, что выведет описанный
# метод для каждого экземпляра.


class Stationery:
    title = ''

    def __init__(self, title: str):
        self.title = title

    def draw(self):
        print('Запуск отрисовки')


class Pen(Stationery):
    def draw(self):
        print('Пишем диктант')


class Pencil(Stationery):
    def draw(self):
        print('Рисуем макет')


class Handle(Stationery):
    def draw(self):
        print('Набрасываем Mind-Mapping')


parker = Pen('Parker')
centropen = Handle('Centropen')
stabilo = Pencil('Stabilo')
print(parker.title)
parker.draw()
print(centropen.title)
centropen.draw()
print(stabilo.title)
stabilo.draw()
