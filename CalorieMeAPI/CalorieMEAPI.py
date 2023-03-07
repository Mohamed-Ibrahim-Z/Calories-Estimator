from flask import Flask, request
import matplotlib.pyplot as plt
app = Flask(__name__)


@app.route('/CalorieMe', methods=['POST'])
def predict():
    # Get the image file from the HTTP request
    file = request.files['image']

    # plot the image
    plt.imshow(file)
    plt.show()

    return "Image received successfully."
