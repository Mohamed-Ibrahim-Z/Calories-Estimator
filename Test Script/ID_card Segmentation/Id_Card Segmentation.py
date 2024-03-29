import numpy as np
import cv2


def angle_cos(p0, p1, p2):
    d1, d2 = (p0-p1).astype('float'), (p2-p1).astype('float')
    return abs( np.dot(d1, d2) / np.sqrt( np.dot(d1, d1)*np.dot(d2, d2) ) )

def getContours(img,rects):
    imgArea =img.shape[0] * img.shape[1]
    for gray in cv2.split(img):
        for thrs in range(0, 255, 26):

            if thrs == 0:
                bin = cv2.Canny(gray, 0, 50, apertureSize=5)
            else:
                _ , bin = cv2.threshold(gray, thrs, 255, cv2.THRESH_BINARY+ cv2.THRESH_OTSU)
            
            contours, _ = cv2.findContours(bin, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
            for cnt in contours:
                cnt_len = cv2.arcLength(cnt, True)
                cnt = cv2.approxPolyDP(cnt, 0.02*cnt_len, True)
                cntArea = cv2.contourArea(cnt)
                if len(cnt) == 4 and  cntArea > 1000 and cv2.isContourConvex(cnt):
                    cnt = cnt.reshape(-1, 2)
                    max_cos = np.max([angle_cos(cnt[i], cnt[(i+1) % 4], cnt[(i+2) % 4] ) for i in range(4)])
                    if max_cos < 0.1 and cntArea/imgArea<0.75:
                        rects.append(cnt)


def getIdCard(img):

    img=cv2.imread(img)

    img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    channels_hsv = cv2.split(img_hsv)

    channel_s = channels_hsv[1]
    channel_s = cv2.GaussianBlur(channel_s, (9, 9), 2, 2)

    imf = channel_s.astype(np.float32)
    imf = cv2.convertScaleAbs(imf, alpha=0.5, beta=0.5)

    sobx = cv2.Sobel(imf, cv2.CV_32F, 1, 0)
    soby = cv2.Sobel(imf, cv2.CV_32F, 0, 1)
    sobx = cv2.multiply(sobx, sobx) 
    soby = cv2.multiply(soby, soby)

    grad_abs_val_approx = cv2.pow(sobx + soby, 0.5)    
    filtered = cv2.GaussianBlur(grad_abs_val_approx, (9, 9), 2, 2)
    
    sobelImg=cv2.cvtColor((filtered).astype(np.uint8), cv2.COLOR_RGB2BGR)

    # Adjust the kernel size for desired thickness
    kernel = np.ones((3, 3), dtype=np.uint8)  
    # Dilate the edges
    sobelImg= cv2.dilate(sobelImg, kernel, iterations=3)

    rects = []
    getContours(img,rects)
    getContours(sobelImg,rects)
    largest_contour = max(rects, key=cv2.contourArea)

    mask = np.zeros_like(img)  # create blank image of same size as input
    cv2.drawContours(img, [largest_contour], -1, (0, 255, 0), 1)
    cv2.fillPoly(mask, [largest_contour], (255, 255, 255))  # draw square on mask
    
    #masked = cv2.bitwise_and(img, mask)  # apply mask to input image
    #cv2.imwrite('IdCard.png', img)
    #cv2.imwrite('maskImg.png', mask)
    #cv2.imwrite('maskedImg.png', masked)

    gray_img = cv2.cvtColor(mask, cv2.COLOR_BGR2GRAY)
    # Threshold the image to get the white pixels
    _, thresh_img = cv2.threshold(gray_img, 127, 255, cv2.THRESH_BINARY)
    # Count the number of white pixels
    num_white_pixels = cv2.countNonZero(thresh_img)
    return num_white_pixels

if __name__ == '__main__':
    whitePixels = getIdCard('Ps/p2.jpg')
    print(whitePixels)