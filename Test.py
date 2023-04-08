import numpy as np
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 
import tensorflow 
import os
import Food_Model_Load
import sys 
#sys.path.insert(1, '/home/calorieME/CalorieMe-aws/yolov5') 
#from detect import run

def getFoodWeight(foodImgPath='',id_pixel_count=0):
    # imgpath = 'Images/mid2.png'

    # #initiating ID Model
    # ID_modelpath = 'ID_card Model/unet_model_whole_100epochs.h5'

    # idModel = ID_Model_Load.IdModel(ID_modelpath, imgpath)
    # id_pixel_count = idModel.predict()
    # print("ID Pixels",id_pixel_count)


    #initiating Food Model
    Food_modelpath = 'Food_Model/cp2.h5'
    foodModel= Food_Model_Load.FoodModel(Food_modelpath, foodImgPath)
    model = foodModel.loadmodel()
    image, ah, aw = foodModel.read_image(foodImgPath)
    mask = foodModel.get_mask(image, model, ah, aw)
    print(mask.shape)
    cat_values = np.unique(mask)

    labels = {}
    categories = {}

    with open('category.txt', 'r') as f:
        categories = dict(enumerate(f.read().splitlines()))

    #Id card real dimensions in cm
    id_card_width = 8.56
    id_card_height = 5.398
    Density = 1.38

    print(cat_values)
    foodWhite_pixels = 0
    for cat in cat_values:
        if cat == 0:
            continue

        pixels = np.count_nonzero(mask == cat)
        Reference_Volume = id_card_height * id_card_width * 0.1
        Food_Size = (pixels / int(id_pixel_count)) * id_card_height * id_card_width
        Food_Weight = Food_Size**3 * Density / Reference_Volume

        labels[categories[cat]] = Food_Weight
        print("Pixels of ", categories[cat], pixels)
        foodWhite_pixels = max(foodModel.getSizeOfMask(mask, cat),foodWhite_pixels)

    print("Food Pixels",foodWhite_pixels)

    return labels


def getFoodWeightV2(imgLink, ref_pixels):

    # download image from link
    if os.path.exists('Food_Model/img.jpg'):
        os.system('rm Food_Model/img.jpg')
        os.system('wget -O Food_Model/img.jpg {}'.format(imgLink))
        print("Image Downloaded")
    else:
        os.system('wget -O Food_Model/img.jpg {}'.format(imgLink))
        print("Image Downloaded")

    if os.path.exists('yolov5/runs/detect/exp/'):
        os.system('rm -r yolov5/runs/detect/*')


    if not os.path.exists('Food_Model/img.jpg'):
        print("Image not found")
        return
    os.system('python3 yolov5/detect.py --source Food_Model/img.jpg --weights Food_Model/yolov5_best_2.pt --img 413 --augment --save-txt')
 #   run(source = "Food_Model/img.jpg", weights = "Food_Model/yolov5_best_2.pt", imgsz= (413,413), save_txt= True, augment= True)

    modelpath = 'Food_Model/cp2.h5'
    yolo_dir = 'yolov5'
    img_name = imgLink.split('/')[-1].split('.')[0]
    print(img_name)
    foodmodel= Food_Model_Load.FoodModel(modelpath, imgLink)

    model = foodmodel.loadmodel()
    image, ah, aw = foodmodel.read_image(imgLink)
    mask = foodmodel.get_mask(image, model, ah, aw)
    bbox = foodmodel.read_bbox_file('{}/runs/detect/exp/labels/img.txt'.format(yolo_dir))
    mask = foodmodel.match_mask_with_bbox(mask, bbox, ah, aw)
    img = tensorflow.image.resize(image, (ah, aw), method='nearest')
    img = img[0].numpy()


    #Id card real dimensions in cm
    id_card_width = 8.56
    id_card_height = 5.398
    Density = 1.38

    labels = {}
    categories = {}

    with open('category.txt', 'r') as f:
        categories = dict(enumerate(f.read().splitlines()))

    cat_values = np.unique(mask)
    print(cat_values)
    foodWhite_pixels = 0

    for cat in cat_values:
        if cat == 0: 
            continue
        white_pixels_percentage = foodmodel.get_cat_percentage(mask, cat)
        print("percentage of category {}: {}%".format(cat, white_pixels_percentage))

        if white_pixels_percentage < 0.1:
            continue

        pixels = np.count_nonzero(mask == cat)
        Reference_Volume = id_card_height * id_card_width * 0.1
        Food_Size = (pixels / int(ref_pixels)) * id_card_height * id_card_width
        Food_Weight = Food_Size**3 * Density / Reference_Volume
        
        labels[categories[cat-1]] = Food_Weight
        print("Pixels of ", categories[cat-1], pixels)
        foodWhite_pixels = max(foodmodel.getSizeOfMask(mask, cat),foodWhite_pixels)

    print("label", labels)
    return labels
