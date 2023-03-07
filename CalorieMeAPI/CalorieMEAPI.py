from flask import Flask, request, jsonify
import matplotlib.pyplot as plt
app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'CalorieMe API'


@app.route('/CalorieMe', methods=['POST'])
def predict():
    if 'image' not in request.files:
        return "No image file"

    if request.method == 'POST':
        file = request.files['image']
        # plt.imshow(file)
        # plt.show()
        return "Image received successfully."
    else :
        return "Invalid request method"

@app.route('/test', methods=['POST'])
def test():
    return request.form['text']

if __name__ == '__main__':
    app.run(debug=True)
