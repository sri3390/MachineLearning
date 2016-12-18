#!/usr/bin/env python
#########################################################################
# Name : Srikant Iyengar
# Net ID: sxi140530
#########################################################################

from __future__ import division
import urllib2
import json
from Tweet import Tweet
from operator import itemgetter
import math
import sys

def readFile(url):
    file = open(url,'r+')
    data=[]
    tweets = []

    for line in file:
        data.append(json.loads(line))

    for entry in data:
        t = Tweet(entry['id'],entry['text'],int(-1),int(-1))
        tweets.append(t)

    return tweets

def gettweet(id,tweets):
    for i in tweets:
        if id == i.id:
            return i


def selectInitial(k):
    tweets = readFile(sys.argv[3])
    cen = open(sys.argv[2],'r+')
    centroids = []

    for id in cen:
        id = id.replace(",","")
        id = id.replace("\n","")
        tweet = gettweet(int(id),tweets)
        centroids.append(tweet)

    return centroids,tweets

def jacobian(tweet,centroid):
    t = tweet.tweet.split(" ")
    c = centroid.tweet.split(" ")
    common = set(t).intersection(set(c))
    intersect = len(common)

    union = len(t)
    union = union + len(c)
    union = union - intersect

    if union == 0:
        union = 1

    dist = 1-(intersect/union)

    return dist

def mindist(tweet,centroids):
    temp = jacobian(tweet,centroids[0])
    cluster = 0
    for j in range(0,len(centroids)):
        temp1 = jacobian(tweet,centroids[j])
        if temp1< temp:
            cluster = j
            temp = temp1

    return cluster


def computeDist(tweets,centroids):
    dist = {}
    k= len(centroids)
    for i in range(0,k):
        dist[i] = []

    for i in range(0,len(tweets)):
        cluster = mindist(tweets[i],centroids)
        tweets[i].prevcluster = tweets[i].currentcluster
        tweets[i].currentcluster = cluster
        dist[cluster].append(tweets[i])

    return dist

def displaydist(dist):

    completepath = sys.argv[4]
    outputfile = open(completepath,"w")
    for key in dist:
        line = ""
        line = line + str(key+1)+ "     "
        for t in dist[key]:
            line = line+str(t.id)+", "
        line = line[:-2]
        outputfile.write(line)
        outputfile.write("\n")

    outputfile.close()


def mintweet(cluslist):
    minimum = []

    for tw in cluslist:
        d=0
        for tw2 in cluslist:
            if tw != tw2:
                d = d + jacobian(tw,tw2)
        minimum.append(d)
    index = min(enumerate(minimum), key=itemgetter(1))[0]
    return cluslist[index]


def computeCentroid(dist):
    newcentroid = []

    for clus in dist:
        newclus = mintweet(dist[clus])
        newcentroid.append(newclus)

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
            d = math.pow(jacobian(val,c),2)
            sse = sse + d
    return sse

def kmeans(k):
    centroids,tweets = selectInitial(k)
    dist = computeDist(tweets,centroids)
    for i in range(0,25):
        newcentroid = computeCentroid(dist)
        dist = computeDist(tweets,newcentroid)
        flag = checkCluster(dist)
        if flag == True: break

    error = sse(newcentroid,dist)
    displaydist(dist)
    with open(sys.argv[4],"a") as myfile:
        myfile.write("The SSE value is: ")
        myfile.write(str(error))


kmeans(int(sys.argv[1]))
