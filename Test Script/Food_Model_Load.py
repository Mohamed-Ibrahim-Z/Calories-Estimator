import cv2
import numpy as np
from tensorflow import keras
from keras.models import load_model
from keras.optimizers import  SGD
import numpy as np
from keras import backend as K
import matplotlib.pyplot as plt

class FoodModel:
    def __init__(self ,modelpath , imgpath):
        self.modelpath = modelpath
        self.imgpath = imgpath
    def loadmodel(self):
        learning_rate = 0.001
        decay_rate = 0.0005
        momentum = 0.9
        loss = keras.losses.SparseCategoricalCrossentropy(from_logits=True)
        optimizer = SGD(learning_rate=learning_rate, momentum=momentum, decay=decay_rate, nesterov=False)
        model = keras.models.load_model(self.modelpath, compile=False)
        model.compile(optimizer=optimizer, loss=loss, metrics=['accuracy'])
        return model

    def loadimg(self):
        img = cv2.imread(self.imgpath)
        card_h,card_w = img.shape[:2]
        img = cv2.resize(img, (256,256))
        img = img / 255.0
        return img, card_h, card_w

    def predict(self):
        model = self.loadmodel()
        img, card_h, card_w = self.loadimg()
        predict = model.predict(img.reshape(1,256,256,3))
        output = predict[0]
        output = cv2.resize(output, (card_w,card_h))
        plt.imsave('FoodMaskOutput.jpg', output)
        plt.imshow(output)
        white_pixels = np.count_nonzero(output == 1)
        return white_pixels

