from flask import Flask, request, jsonify
import Test, CaloriesEstimation,os
app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'CalorieMe API'


@app.route('/CalorieMe-V1', methods=['GET','POST'])
def predict():
    try:
        if request.method == 'POST':
            img_link = request.form['img_link']
            ref_pixels = request.form['ref_pixels']

            print(img_link, ref_pixels)

            label = Test.getFoodWeight(img_link, ref_pixels)
            json = CaloriesEstimation.getCalories(label)
            return jsonify(json)
    
    except Exception as e:
        return jsonify({'msg': 'error', 'error': str(e)})
    
@app.route('/CalorieMe-V2', methods=['GET','POST'])
def predictV2():
    try:
        if request.method == 'POST':
            img_link = request.form['img_link']
            ref_pixels = request.form['ref_pixels']

            print(img_link, ref_pixels)

            label = Test.getFoodWeightV2(img_link, ref_pixels)
            json = CaloriesEstimation.getCalories(label)
            return jsonify(json)
    
    except Exception as e:
        return jsonify({'msg': 'error', 'error': str(e)})


@app.route('/refresh', methods=['GET'])
def refresh():
    try:
        if request.method == 'GET':
            os.system('sudo reboot')
            return jsonify({'msg': 'success'})
    except Exception as e:
        return jsonify({'msg': 'error', 'error': str(e)})
    

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000 ,debug=True)
