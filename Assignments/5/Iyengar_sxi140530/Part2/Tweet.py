class Tweet:

    def __init__(self,id,tweet,prevcluster,currentcluster):
        self.id = id
        self.tweet = tweet
        self.prevcluster = prevcluster
        self.currentcluster = currentcluster

    def display(self):
        print("ID : ", str(self.id))
        print("Tweet : ", self.tweet)