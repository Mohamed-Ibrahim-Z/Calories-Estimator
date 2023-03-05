import ID_Model_Load

imgpath = 'ID_card Model/test.jpg'

#initiating ID Model
ID_modelpath = 'ID_card Model/unet_model_whole_100epochs.h5'

idModel = ID_Model_Load.IdModel(ID_modelpath, imgpath)
Model1 = idModel.loadmodel()
Model1.loadimg()
id_pixel_count = Model1.predict()

#initiating Food Model
Food_modelpath = ''
Food_pixel_count = 0

#Id card real dimensions in mm
id_card_width = 85.6
id_card_height = 53.98

#Equation to calculate food volume
food_volume = (id_card_height * id_card_width) * Food_pixel_count / id_pixel_count