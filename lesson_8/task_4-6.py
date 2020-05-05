# 4. Начните работу над проектом «Склад оргтехники». Создайте класс, описывающий склад. А также класс «Оргтехника»,
# который будет базовым для классов-наследников. Эти классы — конкретные типы оргтехники (принтер, сканер,
# ксерокс). В базовом классе определить параметры, общие для приведенных типов. В классах-наследниках реализовать
# параметры, уникальные для каждого типа оргтехники.
# 5. Продолжить работу над первым заданием. Разработать методы, отвечающие за приём оргтехники на склад и передачу в
# определенное подразделение компании. Для хранения данных о наименовании и количестве единиц оргтехники,
# а также других данных, можно использовать любую подходящую структуру, например словарь.
# 6. Продолжить работу над вторым заданием. Реализуйте механизм валидации вводимых пользователем данных. Например,
# для указания количества принтеров, отправленных на склад, нельзя использовать строковый тип данных.
# Подсказка: постарайтесь по возможности реализовать в проекте «Склад оргтехники» максимум возможностей,
# изученных на уроках по ООП.


class Storage:
    # словарь из списков словарей
    __equipment = {'printer': [],
                   'scanner': [],
                   'xerox': []}

    # добавляем любимый @property, чтобы смотреть на __equipment
    @property
    def get_equip(self):
        return self.__equipment

    # добавляем оборудование на склад
    def receive_equipment_to_storage(self, equip_type: str, equip_description: dict):
        # проверяем, нет ли уже этой техники в списке, иначе добавляем
        if self.__equipment[equip_type].count(equip_description) == 0:
            self.__equipment[equip_type].append(equip_description)
        # обнуляем владельца, если передаем оборудование на склад из отдела
        equip_index = self.__equipment[equip_type].index(equip_description)
        self.__equipment[equip_type][equip_index]['_OfficeEquipment__owner'] = None

    # передача оборудования в отдел
    def deliver_equipment_to_unit(self, company_unit: str, equip_type: str, equip_description: dict):
        equip_index = self.__equipment[equip_type].index(equip_description)  # индекс запрашиваемой техники
        tmp = self.__equipment[equip_type][equip_index]['_OfficeEquipment__owner']  # текущий владелец
        if tmp is None:
            self.__equipment[equip_type][equip_index]['_OfficeEquipment__owner'] = company_unit
        else:
            print(f'Запрошенный <{equip_type}> уже находится в <{tmp}> и не может быть передан в <{company_unit}>\n')


class OfficeEquipment:
    def __init__(self, equip_id: int, company_name: str, country: str):
        self.equip_id = equip_id
        self.company_name = company_name
        self.country = country
        self.__owner = None


class Printer(OfficeEquipment):
    equip_type = 'printer'

    def __init__(self, equip_id: int, company_name: str, country: str, color: bool, laser_paint: str):
        super().__init__(equip_id, company_name, country)
        self.color = color
        self.laser_paint = laser_paint


class Scanner(OfficeEquipment):
    equip_type = 'scanner'

    def __init__(self, equip_id: int, company_name: str, country: str, extension_type: bool, dpi: int):
        super().__init__(equip_id, company_name, country)
        self.dpi = dpi
        self.extension_type = extension_type


class Xerox(OfficeEquipment):
    equip_type = 'xerox'

    def __init__(self, equip_id: int, company_name: str, country: str, color: bool, dpi: int, laser_paint: str):
        super().__init__(equip_id, company_name, country)
        self.color = color
        self.dpi = dpi
        self.laser_paint = laser_paint


printer_1 = Printer(12345, 'Dell', 'China', True, 'paint')
printer_2 = Printer(67890, 'Lenovo', 'China', False, 'laser')
scanner_1 = Scanner(11123, 'hp', 'Germany', False, 400)
xerox_1 = Xerox(14156, 'Dell', 'Italy', True, 600, 'laser')
Storage().receive_equipment_to_storage(printer_1.equip_type, printer_1.__dict__)
Storage().receive_equipment_to_storage(printer_2.equip_type, printer_2.__dict__)
Storage().receive_equipment_to_storage(scanner_1.equip_type, scanner_1.__dict__)
Storage().receive_equipment_to_storage(xerox_1.equip_type, xerox_1.__dict__)
Storage().deliver_equipment_to_unit('Отдел HR', printer_2.equip_type, printer_2.__dict__)
Storage().deliver_equipment_to_unit('Отдел HR', xerox_1.equip_type, xerox_1.__dict__)
Storage().deliver_equipment_to_unit('Охрана', printer_1.equip_type, printer_1.__dict__)
Storage().deliver_equipment_to_unit('Охрана', printer_2.equip_type, printer_2.__dict__)
Storage().receive_equipment_to_storage(printer_2.equip_type, printer_2.__dict__)
# print(Storage().get_equip)

# вывод списка техники для проверки работы скрипта
for equipment_type_in_storage in Storage().get_equip.keys():
    print(f'ТЕХНИКА КЛАССА {equipment_type_in_storage}:\n')
    for equipment_list_in_storage in range(len(Storage().get_equip[equipment_type_in_storage])):
        for key, value in Storage().get_equip[equipment_type_in_storage][equipment_list_in_storage].items():
            print(f'{key}: {value}')
        print('\n')
