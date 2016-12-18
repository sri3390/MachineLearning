from __future__ import division
from sys import stdout
import sys
import math
from Node import Node
import copy
import random

traindata=[]
copytraindata = []
validationdata=[]
testdata=[]
argumentlist=[]
copyargumentlist = []
set=[]
attributegain={}

def readFile():
    #reading training data
    training=open(arglist[3])
    line = training.readlines()
    argumentlist.append(line[0].replace('\n','').split(','))
    del argumentlist[0][len(argumentlist[0])-1]
    for i in range(1,len(line)):
        traindata.append(line[i].replace('\n','').split(','))
    #reading the validation data
    validation = open(arglist[4])
    line1=validation.readlines()
    for i in range(1, len(line1)):
        validationdata.append(line1[i].replace('\n','').split(','))
    #reading test data
    test=open(arglist[5])
    line2=test.readlines()
    for i in range(1,len(line2)):
        testdata.append(line2[i].replace('\n','').split(','))

def entropySet(set):
    if(set):
        count1=0
        count2=0
        for i in range(0,len(set)):
            temp = set[i]
            if temp[len(temp)-1]=='1':
                count1=count1+1
            elif temp[len(temp)-1]=='0':
                count2=count2+1
        total = count1+count2
        val1=count1/total
        val2=count2/total
        if val1==0 and val2>0:
            entropy=-(val2 * math.log(val2,2))
        elif val2==0 and val1>0:
            entropy=-(val1 * math.log(val1,2))
        elif val2==0 and val1==0:
            entropy=0
        else:
            entropy=-(val1*math.log(val1,2) + val2 * math.log(val2,2))
        return entropy
    else:
        return 1


def computegain(traindata):
    entropyset=entropySet(traindata)
    for i in range(0,len(argumentlist[0])):
        attset1=[]
        attset2=[]
        count1=0
        count2=0
        for j in range(0,len(traindata)):
            templist=traindata[j]
            if templist[i]=='0':
                attset1.append(templist[len(templist)-1])
                count1=count1+1
            elif templist[i]=='1':
                attset2.append(templist[len(templist)-1])
                count2=count2+1
        entropy1=entropySet(attset1)
        entropy2=entropySet(attset2)
        total=count1+count2
        val1=count1/ total
        val2=count2/ total
        gain = entropyset-(val1*entropy1+val2*entropy2)
        attributegain[argumentlist[0][i]] = gain


def getMax():
    if attributegain:
        temp=attributegain.itervalues().next()
        finalkey = attributegain.iterkeys().next()
        for key, value  in attributegain.iteritems():
            if(value>temp):
                temp=value
                finalkey=key
        return finalkey
    else:
        return "None"


def createSet(attribute,exisitingset):
    attri1=[]
    attri0=[]
    if not argumentlist[0]:
        return attri1,attri0
    else:
        index = argumentlist[0].index(attribute)
        for i in range(0,len(exisitingset)):
            if(exisitingset[i][index] == '1'):
                del exisitingset[i][index]
                attri1.append(exisitingset[i])
            elif (exisitingset[i][index] == '0'):
                del exisitingset[i][index]
                attri0.append(exisitingset[i])
        argumentlist[0].remove(attribute)
        del attributegain[attribute]
        return attri1, attri0


def check0(attri0):
    for i in range(0,len(attri0)):
        temp = attri0[i]
        if(temp[len(temp)-1] == '1'):
            return False
    return True

def check1(attri1):
    for i in range(0,len(attri1)):
        temp = attri1[i]
        if(temp[len(temp)-1] == '0'):
            return False
    return True

def buildTree(root,node,data):
    attri1,attri0=createSet(node.attribute,data)
    if not argumentlist[0]:
        return root
    if not attri1 and not attri0:
        return root
    if(check1(attri1) == True):
        leftleaf = Node()
        leftleaf.attribute = "leaf"
        leftleaf.data = copy.deepcopy(['1'])
        leftleaf.left=None
        leftleaf.right=None
        node.left=leftleaf
    else:
        if(attri1):
            computegain(attri1)
            finalkey=getMax()
            if finalkey != "None":
                newnode = Node()
                newnode.attribute = finalkey
                newnode.data = copy.deepcopy(attri1)
                node.left=newnode
                buildTree(root, newnode,attri1)
            else:
                return root
    if(check0(attri0) == True):
        rightleaf = Node()
        rightleaf.attribute = "leaf"
        rightleaf.data = copy.deepcopy('0')
        rightleaf.left = None
        rightleaf.right = None
        node.right=rightleaf
    else:
        if(attri0):
            computegain(attri0)
            finalkey=getMax()
            if finalkey != "None":
                newnode = Node()
                newnode.attribute = finalkey
                newnode.data = copy.deepcopy(attri0)
                node.right=newnode
                buildTree(root, newnode,attri0)
            else:
                return root

def traverseTree(node,state,nooftabs):
    if(node == None):
        return
    elif(node.attribute == "leaf"):
        count1 = 0
        count0 = 0
        for i in range(0, len(node.data)-1):
            val = checkMajority(node.data)
            if (val == '1'):
                count1=count1+1
            else:
                count0 = count0+1
        if(count1>count0):
            for i in range(0,nooftabs):
                sys.stdout.write(" ")
            sys.stdout.write('1')
        else:
            for i in range(0,nooftabs):
                sys.stdout.write(" ")
            sys.stdout.write('0')
        print(" ")
    else:
        for i in range(0,nooftabs):
            sys.stdout.write(" ")
        nooftabs=nooftabs+1
        sys.stdout.write(node.attribute)
        sys.stdout.write(" = 1 : ")
        print(" ")
        if(node.left!=None):
            traverseTree(node.left,"left",nooftabs)
        else:
            count1 = 0
            count0 = 0
            for i in range(0, len(node.data)-1):
                val = checkMajority(node.data)
                if (val == '1'):
                    count1=count1+1
                else:
                    count0 = count0+1
            if(count1>count0):
                for i in range(0,nooftabs):
                    sys.stdout.write(" ")
                sys.stdout.write('1')
            else:
                for i in range(0,nooftabs):
                    sys.stdout.write(" ")
                sys.stdout.write('0')
            print(" ")
        for i in range(0,nooftabs):
            sys.stdout.write(" ")
        sys.stdout.write(node.attribute)
        sys.stdout.write(" = 0 : ")
        print(" ")
        if(node.right!=None):
            traverseTree(node.right,"right",nooftabs)
        else:
            count1 = 0
            count0 = 0
            for i in range(0, len(node.data)-1):
                val = checkMajority(node.data)
                if (val == '1'):
                    count1=count1+1
                else:
                    count0 = count0+1
            if(count1>count0):
                for i in range(0,nooftabs):
                    sys.stdout.write(" ")
                sys.stdout.write('1')
            else:
                for i in range(0,nooftabs):
                    sys.stdout.write(" ")
                sys.stdout.write('0')
            print(" ")


def checkMajority(list):
    c1 = 0
    c0 = 0
    for i in range(0,len(list)-1):
        if(list[i] == '1'):
            c1 = c1+1
        else:
            c0 = c0+1
    if(c1>c0):
        return '1'
    elif c1==c0:
        return 'same'
    else:
        return '0'


def validateTree(root,testdata):
    success = 0
    failure = 0
    for i in range(0,len(testdata)-1):
        node = root
        prevnode = Node()
        while(node != None):
            if(node.attribute == "leaf"):
                break
            index = copyargumentlist[0].index(node.attribute)
            value = testdata[i][index]
            if(value == '1'):
                prevnode=node
                node = node.left
            else:
                prevnode=node
                node=node.right

        if (node == None):
            stat = checkMajority(prevnode.data)
            if (stat == '1'):
                if(testdata[i][len(testdata[i])-1] == '1'):
                    success = success+1
                elif (stat == 'same'):
                    success=success+1
                else:
                    failure=failure+1
            else:
                if(testdata[i][len(testdata[i])-1] == '0'):
                    success=success+1
                elif (stat == 'same'):
                    success=success+1
                else:
                    failure=failure+1
        elif(node.attribute == "leaf"):
            stat = checkMajority(node.data)
            if (stat == '1'):
                if(testdata[i][len(testdata[i])-1] == '1'):
                    success = success+1
                elif (stat == 'same'):
                    success=success+1
                else:
                    failure=failure+1
            else:
                if(testdata[i][len(testdata[i])-1] == '0'):
                    success=success+1
                elif (stat == 'same'):
                    success=success+1
                else:
                    failure=failure+1

    percentage = success/(success+failure)
    percentage=percentage*100
    return percentage

def copyTree(node):
    newnode = copy.deepcopy(node)
    return newnode

def noofnonleaf(node):
    no = 0
    allnodes = []
    internalnodes = []
    allnodes.insert(0,node)
    while(allnodes):
        newnode = allnodes.pop(len(allnodes)-1)
        if(newnode.left != None and newnode.right!= None):
            no=no+1
            allnodes.insert(len(allnodes)-1,newnode.left)
            allnodes.insert(len(allnodes)-1,newnode.right)
            internalnodes.append(newnode.left)
            internalnodes.append(newnode.right)
        elif(newnode.left!=None):
            no=no+1
            allnodes.insert(len(allnodes)-1,newnode.left)
            internalnodes.append(newnode.left)
        elif(newnode.right!=None):
            no=no+1
            allnodes.insert(len(allnodes)-1,newnode.right)
            internalnodes.append(newnode.right)

    return no-1,internalnodes


def pruning():
    L = int(arglist[1])
    K = int(arglist[2])
    root = Node()
    computegain(traindata)
    finalkey=getMax()
    root.attribute=finalkey
    root.data = copy.deepcopy(traindata)
    root = buildTree(root,root,traindata)
    besttree = copyTree(root)
    percent = validateTree(root,copytraindata)
    newpercent = 100
    for i in range(1,L):
        newroot = copyTree(root)
        M = random.randint(1,K)
        for j in range(1,M):
            N,internalnodes = noofnonleaf(newroot)
            if N > 1:
                P = random.randint(1,N-1)
                node = internalnodes[P]
                node.left = None
                node.right = None
                val = checkMajority(node.data)
                if(val == '1' or val == 'same'):
                    node.data = copy.deepcopy(['1'])
                elif(val == '0'):
                    node.data = copy.deepcopy(['0'])
        newpercent = validateTree(newroot,validationdata)
        if(newpercent > percent):
            besttree = copyTree(newroot)

    newpercent = validateTree(besttree,testdata)
    if(arglist[6] == "yes"):
        print " The final tree "
        traverseTree(root,"root",0)

    return percent,newpercent



arglist=sys.argv
readFile()
copytraindata = copy.deepcopy(traindata)
copyargumentlist = copy.deepcopy(argumentlist)
per1,per2 = pruning()
print ("Accuracy Before Pruning: " + str(per1))
print ("Accuracy After Pruning: " + str(per2))
