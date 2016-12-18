class Point:

    def __init__(self,id,x,y,prevcluster,currentcluster):
        self.id = id
        self.x = x
        self.y = y
        self.prevcluster = prevcluster
        self.currentcluster = currentcluster

    def displayPoint(self):
        print " The x-coordinate is : " + str(self.x) + " and the y-coordnate is : " + str(self.y) + "\n"

