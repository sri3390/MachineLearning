#!/usr/bin/env python
#########################################################################
# Name : Srikant Iyengar
# Net ID: sxi140530
#########################################################################

from Point import Point
import sys
import random
import math
import os.path
from decimal import Decimal

def readFile(filepath):
    file = open(filepath,'r+')
    points = []

    for line in file:
        str = line.split("\t")
        if str[0] != 'id':
            p = Point(int(str[0]),Decimal(str[1]),Decimal(str[2]),int(-1),int(-1))
            points.append(p)

    return points

def selectRandom(k):
    points = readFile(sys.argv[2])
    centroid = []
    try:
        pos = random.sample(range(0,len(points)-1),k)
        for i in pos:
            centroid.append(points[i])
        return centroid,points
    except ValueError:
        print("Sample size exceeded population size.")


def euclidianDist(x1,y1,x2,y2):
    return math.hypot(x2-x1,y2-y1)

def mindist(p,centroid):
    temp = euclidianDist(p.x,p.y,centroid[0].x,centroid[0].y)
    cluster = 0
    for j in range(0,len(centroid)):
        temp1 = euclidianDist(p.x,p.y,centroid[j].x,centroid[j].y)
        if temp1 < temp:
            cluster = j
            temp = temp1

    return cluster

def computeDist(points,centroid):
    dist = {}
    k= len(centroid)
    for i in range(0,k):
        dist[i] = []

    for i in range(0,len(points)):
        cluster = mindist(points[i],centroid)
        points[i].prevcluster = points[i].currentcluster
        points[i].currentcluster = cluster
        dist[cluster].append(points[i])

    return dist

def displayDist(dist):

    completepath = sys.argv[3]
    outputfile = open(completepath,"w")

    for c in dist:
        line = ""
        line = line + str(c+1) + "          "
        for v in dist[c]:
            line = line + str(v.id) + ", "
        line = line[:-2]
        outputfile.write(line)
        outputfile.write("\n")

    outputfile.close()

def computeCentroid(dist):
    newcentroid = []
    for key in dist:
        c = Point(int(0),Decimal(0),Decimal(0),int(-1),int(-1))
        for point in dist[key]:
            c.x = c.x + point.x
            c.y = c.y + point.y
        c.x /= len(dist[key])
        c.y /= len(dist[key])
        newcentroid.append(c)

    return newcentroid


def checkCluster(dist):
    flag = True
    for key in dist:
        for val in dist[key]:
            if val.currentcluster != val.prevcluster:
                flag = False
                return flag

    return flag

def sse(centroid,dist):
    sse = 0
    for key in dist:
        c = centroid[key]
        for val in dist[key]:
            d = math.pow(euclidianDist(c.x,c.y,val.x,val.y),2)
            sse = sse + d
    return sse



def kmeans(k):
    centroid,points=selectRandom(k)
    dist = computeDist(points,centroid)
    for i in range(0,25):
        newcentroid = computeCentroid(dist)
        dist = computeDist(points,newcentroid)
        flag = checkCluster(dist)
        if flag == True: break
    error = sse(newcentroid,dist)
    displayDist(dist)
    with open(sys.argv[3],"a") as myfile:
        myfile.write("The SSE value is: ")
        myfile.write(str(error))


kmeans(int(sys.argv[1]))
