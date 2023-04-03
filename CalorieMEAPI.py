from flask import Flask, request, jsonify
import Test, CaloriesEstimation
app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'CalorieMe API'


@app.route('/CalorieMe', methods=['GET','POST'])
def predict():
    if request.method == 'POST':
        img_link = request.form['img_link']
        img_pixels = request.form['img_pixels']

        print(img_link, img_pixels)

        label = Test.getFoodWeight(img_link, img_pixels)
        json = CaloriesEstimation.getCalories(label)
        return jsonify(json)
        return jsonify({'msg': 'success', 'size': [img_link, img_pixels]})


@app.route('/test', methods=['POST'])
def test():
    return request.form['text']

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000 ,debug=True)
