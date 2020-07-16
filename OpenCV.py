import matplotlib.pyplot as plt
import numpy as np
import cv2


def viewImage(image, name_of_window='Image'):
    # cv2.namedWindow(name_of_window, cv2.WINDOW_NORMAL)
    cv2.imshow(name_of_window, image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()


# загрузка изображения
image = cv2.imread('Lenna_(test_image).png')
# cv2.imshow("Image of Lena", image)
# cv2.waitKey(0)
# cv2.destroyAllWindows()

# вырезка изображения
cropped_lena = image[155:420, 155:420]
# viewImage(cropped_lena, 'Cropped Lena')
# plt.imshow(cropped_lena)
# plt.show()

# OpenCV работает с BGR, а matplotlib c RGB! Надо перевести в RGB
cropped_lena = cv2.cvtColor(cropped_lena, cv2.COLOR_BGR2RGB)
# plt.imshow(cropped_lena)
# plt.show()

# Изменение размеров
# print(image.shape)  # height, width, channels
# scale_percent = 50  # Процент от изначального размера
# width = int(image.shape[1] * scale_percent / 100)
# height = int(image.shape[0] * scale_percent / 100)
# dim = (width, height)
# resized = cv2.resize(image, dim, interpolation=cv2.INTER_AREA)
# viewImage(resized, "После изменения размера на 20 %")

# Поворот изображения
# h, w, c = image.shape
# rotation_center = (w // 3, h // 3)
# # центр ротации, угол поворота, масштаб повернутого изображения
# rotation_matrix = cv2.getRotationMatrix2D(rotation_center, 180, 1.0)
# rotated_img = cv2.warpAffine(image, rotation_matrix, (w, h))
# viewImage(rotated_img, 'Rotated image')

# очернение Лены :)
# grey_img = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
# viewImage(grey_img, 'Grey Lena')
# # замена на 0 всего, что меньше 127 и больше 255
# ret, thr_img = cv2.threshold(grey_img, 127, 255, 0)
# ret2, thr_img2 = cv2.threshold(grey_img, 150, 200, 10)
# viewImage(thr_img, 'Black_Lena')
# viewImage(thr_img2, 'Black_Lena2')

# Размытие изображения (изображение, сила сглаживания (нечетные натуральные числа!), станд. откл.)
# blurred_img = cv2.GaussianBlur(image, (51, 51), 0)
# blurred_img = cv2.medianBlur(image, 9)
# blurred_img = cv2.bilateralFilter(image, 9, 75, 75)
# viewImage(blurred_img, 'Blurred Image')

#**********************************************************************************************************************

draw_img = image.copy()
# рисуем квадратики: изображение, левый верхний угол, правый нижний, цвет прямоугольника, толщина
# cv2.rectangle(draw_img, (155, 155), (420, 420), (0, 255, 255), 5)
# viewImage(draw_img)

# рисуем линии: изображение, левый верхний угол, правый нижний, цвет прямоугольника, толщина
# cv2.line(draw_img, (155, 155), (420, 420), (0, 255, 255), 5)
# cv2.line(draw_img, (155, 420), (420, 155), (0, 255, 255), 5)
# viewImage(draw_img)

# пишем на рисунках: изображение, текст, координаты ЛН угла, шрифт, размер шрифта, цвет, толщина линий
# cv2.putText(draw_img, "This is Lena", (110, 450), cv2.FONT_HERSHEY_SIMPLEX, 1.5 , (0, 255, 255), 4)
# viewImage(draw_img)

#**********************************************************************************************************************
# image = cv2.imread('tigers_ini.jpg')
image = cv2.imread('photo_with_me.jpeg')
scale_percent = 50  # Процент от изначального размера
width = int(image.shape[1] * scale_percent / 100)
height = int(image.shape[0] * scale_percent / 100)
dim = (width, height)
image = cv2.resize(image, dim, interpolation=cv2.INTER_AREA)

# Распознаем лица
# используем встроенную базу классификаторов
face_cascade = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")
# face_cascade = cv2.CascadeClassifier("haarcascade_eye.xml")
grey_img = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
# функция распознавания:
# изображение, размрер разных лиц, кол-во объектов лица (мало - ложный, много - требовательный), мин размер областей
faces = face_cascade.detectMultiScale(
    grey_img,
    scaleFactor=1.1,
    minNeighbors=5,
    minSize=(10, 10)
)
# сколько лиц нашли?
faces_detected = "Face detected: " + format(len(faces))
print(faces_detected)
# print(faces)

# Рисуем квадраты вокруг лиц
for (x, y, w, h) in faces:
    cv2.rectangle(image, (x, y), (x+w, y+h), (255, 255, 0), 2)
viewImage(image, faces_detected)

# cv2.imwrite('Lena_OpenCV.jpeg', image)
