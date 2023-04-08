import numpy as np
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 
import tensorflow as tf
from tensorflow import keras
import numpy as np
import requests
import warnings
warnings.filterwarnings("ignore")

class FoodModel:
    def __init__(self ,modelpath , imgpath):
        self.modelpath = modelpath
        self.imgpath = imgpath
        self.imgSize = (256,256)

    def loadmodel(self):
        model = keras.models.load_model(self.modelpath)
        return model

    def read_image(self,image_url):
        response = requests.get(image_url)
        image = tf.image.decode_png(response.content, channels=3)
        print(image.shape)
        h,w = image.shape[:2]
        image = tf.image.convert_image_dtype(image, tf.float32)
        image = tf.image.resize(image, (256,256), method='nearest')

        image = tf.expand_dims(image, 0)
        print(image.shape)

        return image, h, w

   
    def create_mask(self, pred_mask):
        pred_mask = tf.argmax(pred_mask, axis=-1)
        pred_mask = pred_mask[..., tf.newaxis]
        return pred_mask[0]
    
    
    def get_mask(self, image, model, h, w):
        print(image.shape)
        pred_mask = self.create_mask(model.predict(image))
        mask = tf.image.resize(pred_mask, (h, w), method='nearest')
        return mask.numpy().astype("uint8").squeeze(axis=2)
    
    def getSizeOfMask(self, mask, num):
        white_pixels = np.count_nonzero(mask == num)
        return white_pixels
    
    # read bounding box file 
    def read_bbox_file(self, file_path):
        with open(file_path, 'r') as f:
            lines = f.readlines()
            bbox_list = []
            for line in lines:
                bbox_list.append([int(line.split(' ')[0]), float(line.split(' ')[1]), float(line.split(' ')[2]), float(line.split(' ')[3]), float(line.split(' ')[4])])
        return bbox_list

    # matching the pixels of the mask with the bounding boxes class
    def match_mask_with_bbox(self, mask, bbox, ah, aw):
        for i in range(len(bbox)):
            x = int(bbox[i][1]*aw)
            y = int(bbox[i][2]*ah)
            w = int(bbox[i][3]*aw)
            h = int(bbox[i][4]*ah)
            for j in range(x-w//2, x+w//2):
                for k in range(y-h//2, y+h//2):
                    if(mask[k][j] != 0):
                        mask[k][j] = bbox[i][0] + 1
        return mask

    def get_cat_percentage(self, mask, cat):
        white_pixels = np.count_nonzero(mask == cat)
        total_pixels = mask.shape[0] * mask.shape[1]
        return white_pixels/total_pixels * 100 


if __name__ == "__main__":
    modelpath = '/mnt/00F26D4EF26D494C/college/gp/Calories-Estimator/Food_Model/cp2.h5'
    imgpath = '/mnt/00F26D4EF26D494C/college/gp/foodDetection/models_integration/fries.jpg'
    yolo_dir = '/home/bvm/Downloads/kaggle/working/yolov5'
    img_name = imgpath.split('/')[-1].split('.')[0]
    foodmodel = FoodModel(modelpath, imgpath)
    model = foodmodel.loadmodel()
    image, ah, aw = foodmodel.read_image(imgpath)
    image = tf.expand_dims(image, 0)
    mask = foodmodel.get_mask(image, model, ah, aw)
    bbox = foodmodel.read_bbox_file('{}/runs/detect/exp/labels/{}.txt'.format(yolo_dir, img_name))
    mask = foodmodel.match_mask_with_bbox(mask, bbox, ah, aw)
    img = tf.image.resize(image, (ah, aw), method='nearest')
    img = img[0].numpy()

    cat_values = np.unique(mask)
    print(cat_values)
    for cat in cat_values:
        white_pixels = foodmodel.get_cat_percentage(mask, cat)

        if cat == 0: 
            continue

        print("Number of white pixels in category {}: {}".format(cat, white_pixels))