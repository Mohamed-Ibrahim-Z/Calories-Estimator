import cv2
import numpy as np
from tensorflow import keras
from keras.models import load_model
from keras.optimizers import Adam
import numpy as np
from keras import backend as K
import matplotlib.pyplot as plt

class IdModel:
    def __init__(self ,modelpath , imgpath):
        self.modelpath = modelpath
        self.imgpath = imgpath

    def IoU(self,y_true, y_pred, eps=1e-6):
        if np.max(y_true) == 0.0:
            return self.IoU(1-y_true, 1-y_pred)
        intersection = K.sum(y_true * y_pred, axis=[1,2,3])
        union = K.sum(y_true, axis=[1,2,3]) + K.sum(y_pred, axis=[1,2,3]) - intersection
        return -K.mean( (intersection + eps) / (union + eps), axis=0)

    def loadmodel(self):
        model = keras.models.load_model(self.modelpath, compile=False)
        model.compile(optimizer=Adam(1e-4), loss=self.IoU, metrics=['binary_accuracy'])
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
        plt.imsave('output.jpg', output, cmap='gray')
        plt.imshow(output)
        white_pixels = np.count_nonzero(output == 1)
        return white_pixels

