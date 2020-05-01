# 2. Реализовать проект расчета суммарного расхода ткани на производство одежды. Основная сущность (класс) этого
# проекта — одежда, которая может иметь определенное название. К типам одежды в этом проекте относятся пальто и
# костюм. У этих типов одежды существуют параметры: размер (для пальто) и рост (для костюма). Это могут быть обычные
# числа: V и H, соответственно. Для определения расхода ткани по каждому типу одежды использовать формулы: для пальто
# (V/6.5 + 0.5), для костюма (2 * H + 0.3). Проверить работу этих методов на реальных данных. Реализовать общий
# подсчет расхода ткани. Проверить на практике полученные на этом уроке знания: реализовать абстрактные классы для
# основных классов проекта, проверить на практике работу декоратора @property.
from abc import ABC, abstractmethod


class Clothes(ABC):

    # Обязательно задать формулу расчета расхода ткани для "дочек"
    @abstractmethod
    def fabric_consumption(self):
        pass

    # запрос уникального параметра для расчета расхода ткани
    def __init__(self, name, parameter):
        self.parameter = parameter
        self.name = name

    @property
    def param_check(self):
        if self.__class__.__name__ == 'Coat':
            return f'Для пальто <{self.name}> задан размер: {self.parameter}'
        elif self.__class__.__name__ == 'Costume':
            return f'Для костюма <{self.name}> задан рост: {self.parameter}'


class Coat(Clothes):
    def fabric_consumption(self):
        return round(self.parameter / 6.5 + 0.5, 2)


class Costume(Clothes):
    def fabric_consumption(self):
        return round(2 * self.parameter + 0.3, 2)


cloth_1 = Coat('весеннее пальто', 635)
cloth_2 = Coat('пальто межсезонное', 456)
cloth_3 = Costume('костюм "стиляги"', 161)

print(f'{cloth_1.param_check}, расход ткани: {cloth_1.fabric_consumption()}')
print(f'{cloth_2.param_check}, расход ткани: {cloth_2.fabric_consumption()}')
print(f'{cloth_3.param_check}, расход ткани: {cloth_3.fabric_consumption()}')
