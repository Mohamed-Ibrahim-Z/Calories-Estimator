import Food_Model_Load
import ID_Model_Load

imgpath = 'ID_card Model/test.jpg'

#initiating ID Model
ID_modelpath = 'ID_card Model/unet_model_whole_100epochs.h5'

idModel = ID_Model_Load.IdModel(ID_modelpath, imgpath)
id_pixel_count = idModel.predict()


#initiating Food Model
Food_modelpath = 'Food_Model/cp2.h5'
foodModel= Food_Model_Load.FoodModel(Food_modelpath, imgpath)
foodModel.predict()


#Id card real dimensions in mm
id_card_width = 85.6
id_card_height = 53.98

#Equation to calculate food volume
#food_volume = (id_card_height * id_card_width) * Food_pixel_count / id_pixel_count