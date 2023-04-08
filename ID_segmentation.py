import numpy as np
import cv2


def angle_cos(p0, p1, p2):
    d1, d2 = (p0-p1).astype('float'), (p2-p1).astype('float')
    return abs( np.dot(d1, d2) / np.sqrt( np.dot(d1, d1)*np.dot(d2, d2) ) )

def getIdCard(img):
    img = cv2.GaussianBlur(img, (5, 5), 0)
    rects = []
    for gray in cv2.split(img):
        for thrs in range(0, 255, 26):
            if thrs == 0:
                bin = cv2.Canny(gray, 0, 50, apertureSize=5)
            else:
                retval, bin = cv2.threshold(gray, thrs, 255, cv2.THRESH_BINARY+ cv2.THRESH_OTSU)

            contours, hierarchy = cv2.findContours(bin, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)

            for cnt in contours:
                cnt_len = cv2.arcLength(cnt, True)
                cnt = cv2.approxPolyDP(cnt, 0.02*cnt_len, True)
                if len(cnt) == 4 and cv2.contourArea(cnt) > 1000 and cv2.isContourConvex(cnt):
                    cnt = cnt.reshape(-1, 2)
                    max_cos = np.max([angle_cos(cnt[i], cnt[(i+1) % 4], cnt[(i+2) % 4] ) for i in range(4)])
                    if max_cos < 0.1:
                        rects.append(cnt)

    largest_contour = max(rects, key=cv2.contourArea)

    mask = np.zeros_like(img)  # create blank image of same size as input
    cv2.drawContours(img, [largest_contour], -1, (0, 255, 0), 1)
    cv2.fillPoly(mask, [largest_contour], (255, 255, 255))  # draw square on mask
    masked = cv2.bitwise_and(img, mask)  # apply mask to input image


    gray_img = cv2.cvtColor(mask, cv2.COLOR_BGR2GRAY)
    # Threshold the image to get the white pixels
    ret, thresh_img = cv2.threshold(gray_img, 127, 255, cv2.THRESH_BINARY)
    # Count the number of white pixels
    num_white_pixels = cv2.countNonZero(thresh_img)
    return num_white_pixels

if __name__ == '__main__':
    img = cv2.imread('Orignal.jpg')
    idCard,whitePixels = getIdCard(img)
    print(whitePixels)



