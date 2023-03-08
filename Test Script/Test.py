import numpy as np
import tensorflow

import Food_Model_Load
import ID_Model_Load

def getFoodWeight(imgpath='Images/mid2.png'):
    # imgpath = 'Images/mid2.png'

    #initiating ID Model
    ID_modelpath = 'ID_card Model/unet_model_whole_100epochs.h5'

    idModel = ID_Model_Load.IdModel(ID_modelpath, imgpath)
    id_pixel_count = idModel.predict()
    print("ID Pixels",id_pixel_count)


    #initiating Food Model
    foodImgPath="Images/mid2.png"
    Food_modelpath = 'Food_Model/cp2.h5'
    foodModel= Food_Model_Load.FoodModel(Food_modelpath, imgpath)
    model = foodModel.loadmodel()
    image = foodModel.read_image(foodImgPath)
    image = tensorflow.expand_dims(image, 0)
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



#Equation to calculate food volume
