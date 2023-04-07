import numpy as np
import tensorflow as tf

import Food_Model_Load

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
    image = foodModel.read_image(foodImgPath)
    image = tf.expand_dims(image, 0)
    mask = foodModel.get_mask(image, model)
    cat_values = np.unique(mask)

    # create dictionary of categories and weights
    labels = {}


    with open('category.txt', 'r') as f:
        categories = f.read()

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
        Food_Size = (pixels / id_pixel_count) * id_card_height * id_card_width
        Food_Weight = Food_Size**3 * Density / Reference_Volume
        
        labels[cat+1] = Food_Weight
        print("Pixels of ",cat,pixels)
        foodWhite_pixels = max(foodModel.getSizeOfMask(mask, cat),foodWhite_pixels)

    print("Food Pixels",foodWhite_pixels)

    return labels

def getFoodWeightV2(imgLink, img_size):
    modelpath = 'Food_Model/cp2.h5'
    yolo_dir = 'yolov5'
    img_name = imgLink.split('/')[-1].split('.')[0]
    foodmodel= Food_Model_Load.FoodModel(modelpath, imgLink)

    model = foodmodel.loadmodel()
    image, ah, aw = foodmodel.read_image(imgLink)
    image = tf.expand_dims(image, 0)
    mask = foodmodel.get_mask(image, model, ah, aw)
    bbox = foodmodel.read_bbox_file('{}/runs/detect/exp/labels/{}.txt'.format(yolo_dir, img_name))
    mask = foodmodel.match_mask_with_bbox(mask, bbox, ah, aw)
    img = tf.image.resize(image, (ah, aw), method='nearest')
    img = img[0].numpy()


    #Id card real dimensions in cm
    id_card_width = 8.56
    id_card_height = 5.398
    Density = 1.38

    labels = {}

    cat_values = np.unique(mask)
    print(cat_values)
    foodWhite_pixels = 0

    for cat in cat_values:
        if cat == 0: 
            continue

        white_pixels_percentage = foodmodel.get_cat_percentage(mask, cat)
        print("Number of white pixels in category {}: {}%".format(cat, white_pixels_percentage))

        pixels = np.count_nonzero(mask == cat)
        Reference_Volume = id_card_height * id_card_width * 0.1
        Food_Size = (pixels / img_size) * id_card_height * id_card_width
        Food_Weight = Food_Size**3 * Density / Reference_Volume
        
        labels[cat+1] = Food_Weight
        print("Pixels of ",cat,pixels)
        foodWhite_pixels = max(foodmodel.getSizeOfMask(mask, cat),foodWhite_pixels)


    return labels



#Equation to calculate food volume
