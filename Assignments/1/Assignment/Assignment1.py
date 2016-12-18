__author__ = 'srikant, sxi140530'

import random

def randomdice():
    dice1 = random.randint(1,6)
    dice2 = random.randint(1,6)
    return dice1+dice2

def evenwager():
    i=1
    balance = 1000
    while(i<=10 and balance>0):
        balance=balance-100
        newroll = 13
        diceval=randomdice()
        if(diceval==7 or diceval==11):
            balance+=200
        elif(diceval==4 or diceval==5 or diceval==6 or diceval==8 or diceval==9 or diceval==10):
            while(newroll!=7 and newroll!=diceval):
                newroll = randomdice()
            if newroll!=7:
                balance+=200
        i=i+1
    return balance,i

def martingalesystem():
    i=1
    balance=1000
    wager=100
    while(i<=10 and balance>0):
        win=False
        if(balance >= wager):
            balance=balance-wager
        else:
            wager=balance
            balance=0
        newroll=13
        diceval=randomdice()
        if(diceval==7 or diceval==11):
            win=True
            balance+=(2*wager)
        elif(diceval==4 or diceval==5 or diceval==6 or diceval==8 or diceval==9 or diceval==10):
            while(newroll!=7 and newroll!=diceval):
                newroll=randomdice()
            if newroll!=7:
                balance+=(2*wager)
                win=True
        i=i+1
        if win==False:
            wager=2*wager
        else:
            wager=100

    return balance,i

def reversemartingalesystem():
    i=1
    balance=1000
    wager=100
    while(i<=10 and balance>0):
        win=False
        if(balance >= wager):
            balance=balance-wager
        else:
            wager=balance
            balance=0
        newroll=13
        diceval=randomdice()
        if(diceval==7 or diceval==11):
            win=True
            balance+=(2*wager)
        elif(diceval==4 or diceval==5 or diceval==6 or diceval==8 or diceval==9 or diceval==10):
            while(newroll!=7 and newroll!=diceval):
                newroll=randomdice()
            if newroll!=7:
                balance+=(2*wager)
                win=True
        i=i+1
        if win==False:
            wager=100
        else:
            wager=2*wager

    return balance,i


j=1
file=open("Output.txt","w")

while(j<=5):
    balace1,eveni=evenwager()
    balance2,marti=martingalesystem()
    balance3,revmarti=reversemartingalesystem()
    file.write(" Round " + str(j) + "\n")
    file.write("Strategy " + "\t" + " Number of Games " + "\t" + " Ending Balance " + "\n")
    file.write(" 1 " + "\t\t\t" + str(eveni-1) + " \t\t\t" + str(balace1) + "\n")
    file.write(" 2 " + "\t\t\t" + str(marti-1) + " \t\t\t" + str(balance2) + "\n")
    file.write(" 3 " + "\t\t\t" + str(revmarti-1) + " \t\t\t" + str(balance3) + "\n")
    j=j+1

file.close()
