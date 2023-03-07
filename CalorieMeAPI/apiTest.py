# post local image to localhost:5000/CalorieMe

import requests
import matplotlib.pyplot as plt

# post local image to localhost:5000/CalorieMe
url = 'http://localhost:5000/CalorieMe'
# Sent image file as a multipart/form-data
files = {'image': open('test.jpg', 'rb')}
r = requests.post(url, files=files)
print(r.text)

# plot the image
plt.imshow(files['image'])
plt.show()