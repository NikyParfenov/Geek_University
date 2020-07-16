from PIL import Image

try:
    original_image = Image.open('Lenna_(test_image).png')
    # original_image = Image.open('tigers_ini.jpg')
except FileNotFoundError:
    print('Файл не найден')

# Просмотр изображения в программе по умолчанию
# original_image.show()

# Просмотр основной информации об изображении:
# format - расширение, size - кортеж (Ш, В) в pxl, mode - палитра изображения: L, RGB, CMYK и т.д.
print(f'{original_image.filename}\n'
      f'{original_image.width} x {original_image.height}\n'
      f'{original_image.size}\n'
      f'{original_image.mode}')

# параметры пикселя
# print(original_image.getpixel((50, 50)))
# ресайз изображения
# original_image.resize((256, 128)).show()
# байтизация изображения
# print(original_image.tobytes())

# Создание миниатюр
# mini_img = Image.open('Lenna_(test_image)_2.png')
# mini_img.thumbnail((128, 128))
# mini_img.show()
# mini_img.save('Lena.jpeg', 'JPEG')

# Обрезка изображений по координатам пикселей левого верхнего и нижнего правого углов crop((X1, Y1, X2, Y2))
# crop_img = original_image.crop((155, 155, 420, 420))
# crop_img.show()

# создание изображения
# new_img = Image.new('RGB', (512, 512), (250, 50, 50))
# new_img.show()
# new_img.save('red_square.png')

# смешение изображений (должен быть одинаковый размер)
# img1 = Image.open('red_square.png')
# img2 = Image.open('Lenna_(test_image).png')
# # img1 = Image.open('contoured.jpg')
# # img2 = Image.open('grey_img.jpeg')
# composite_image = Image.blend(img1, img2, 0.8)
# composite_image.show()

# *********************************************************************************************************************

from PIL import ImageFilter

# !!! FILTER IMAGE
# Размытие изображения
blurred_image = original_image.filter(ImageFilter.BLUR)
# blurred_image.show()
# blurred_image.save('blurred.png')

# Эффект сглаживания (слабое размытие)
smoothed_image = original_image.filter(ImageFilter.SMOOTH)
# smoothed_image.show()

# Эффект сглаживания (среднее размытие)
smoothed_more_image = original_image.filter(ImageFilter.SMOOTH_MORE)
# smoothed_more_image.show()

# Фильтра оконтуривания
contoured_image = original_image.filter(ImageFilter.CONTOUR)
# contoured_image.show()
# contoured_image.save('contoured.jpg', 'JPEG')

# Повышение резкости
sharped_image = original_image.filter(ImageFilter.SHARPEN)
# sharped_image.show()

# Повышение резкости мягкое
detailed_image = original_image.filter(ImageFilter.DETAIL)
# detailed_image.show()

# Повышение резкости жесткое
enhanced_image = original_image.filter(ImageFilter.EDGE_ENHANCE)
# enhanced_image.show()

# Повышение резкости жестое капец как
enhanced2_image = original_image.filter(ImageFilter.EDGE_ENHANCE_MORE)
# enhanced2_image.show()

# Эффект штамповки
embossed_image = original_image.filter(ImageFilter.EMBOSS)
# embossed_image.show()

# Эффект выделения границ
find_edged_image = original_image.filter(ImageFilter.FIND_EDGES)
# find_edged_image.show()

# *********************************************************************************************************************

from PIL import ImageDraw

# !!! Работа с графикой и пикселями
# ширина и высота изображения
width = original_image.size[0]
height = original_image.size[1]

# Значения пикселя в изображении задаются в формате: (x,y),(red, green, blue)
pix = original_image.load()
print(pix)

# создается объект раскраски изображения
grey_img = Image.open('Lenna_(test_image).png')
draw = ImageDraw.Draw(grey_img)
print(draw)

# Форматирование в оттенки серого
for x in range(width):
    for y in range(height):
        r = pix[x, y][0]
        g = pix[x, y][1]
        b = pix[x, y][2]
        av = (r + g + b) // 3
        draw.point((x, y), (av, av, av))
        # print(x, y, pix[x, y])
grey_img.save('grey_img.jpeg', 'JPEG')
# grey_img.show()

# инверсия цветов
for x in range(width):
    for y in range(height):
        r = pix[x, y][0]
        g = pix[x, y][1]
        b = pix[x, y][2]
        draw.point((x, y), (255 - r, 255 - g, 255 - b))
# grey_img.rotate(45).show()

original_image.close()
