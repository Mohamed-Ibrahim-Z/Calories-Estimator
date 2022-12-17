import matplotlib.pyplot as plt

import tensorflow as tf
import tensorflow_hub as hub

MODEL_URL = 'https://tfhub.dev/google/seefood/segmenter/mobile_food_segmenter_V1/1'

# # load the model
# def load_model():
#     model = hub.KerasLayer(MODEL_URL, trainable=False, name='food_segmenter', output_key='food_group_segmenter:semantic_predictions')
#     return model

# # get a test image
# def get_test_image():
#     image_path = 'Red Apple.jpeg'
#     image = tf.io.read_file(image_path)
#     image = tf.image.decode_jpeg(image)
#     image = tf.image.resize(image , (513, 513))
#     image = tf.cast(image, tf.float32)
#     image = image / 255.0
#     image = tf.expand_dims(image, axis=0)

    
#     return image

# def main():
#     model = load_model()
#     image = get_test_image()
    
#     model = tf.keras.Sequential([model])
#     result = model(image)
    
#     # segment the food from the image
#     result = tf.image.resize(result, (image.shape[1], image.shape[2]))
#     result = tf.cast(result, tf.float32)
#     result = tf.expand_dims(result, axis=-1)
    
#     # plot the results
#     plt.figure(figsize=(10, 10))
#     plt.subplot(1, 2, 1)
#     plt.imshow(image[0])
#     plt.title('Original image')
#     plt.axis('off')
    
#     plt.subplot(1, 2, 2)
#     plt.imshow(result[0])
#     plt.title('Segmented food')
#     plt.axis('off')
    
#     plt.show()
# if __name__ == '__main__':
#     main()

def load_model():
    model = hub.KerasLayer(MODEL_URL, trainable=False, name='food_segmenter', output_key='food_group_segmenter:semantic_probabilities')
    return model

def get_test_image():
    image_path = 'Red Apple.jpeg'
    image = tf.io.read_file(image_path)
    image = tf.image.decode_jpeg(image)
    image = tf.image.resize(image , (513, 513))
    image = tf.cast(image, tf.float32)
    image = image / 255.0
    image = tf.expand_dims(image, axis=0)
    
    return image

def main():
    model = load_model()
    image = get_test_image()
    
    model = tf.keras.Sequential([model])
    result = model(image)
    
    # segment the food from the image
    result = tf.image.resize(result, (image.shape[1], image.shape[2]))
    
    result = tf.argmax(result, axis=-1)
    result = tf.squeeze(result, axis=0)
    # plot the results
    
    
    plt.figure(figsize=(10, 10))
    plt.subplot(1, 2, 1)
    plt.imshow(image[0])
    plt.title('Original image')
    plt.axis('off')
    
    plt.subplot(1, 2, 2)
    plt.imshow(result)
    plt.title('Predicted class')
    plt.axis('off')
    
    plt.show()
    
if __name__ == '__main__':
    main()