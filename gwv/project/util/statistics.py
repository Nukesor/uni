#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from time import time


class StatController(object):

    """docstring for StatController"""

    def __init__(self, ):
        super(StatController, self).__init__()
        self.used_steps = 0
        self.used_hints = 0
        self.max_step_count = 80
        self.start_time = None
        self.end_time = None

    def getPlayTime(self):
        if self.start_time and self.end_time:
            dt = self.end_time - self.start_time
            return dt
        print("Game has not yet finished")

    def computeScore(self):
        score = 10.0
        score -= (self.used_steps - self.max_step_count) / 10.0
        score -= self.used_hints / 7.5
        score -= (self.getPlayTime() - 60.0) / 10.0
        if score < 0.0:
            score = 0.0
        elif score > 10.0:
            score = 10.0
        return score

    def generateComment(self, score):
        if score >= 9.0:
            return "Teach me master!"
        elif score >= 7.0:
            return "Wow! You're really good at this"
        elif score >= 5.0:
            return "Not bad!"
        elif score >= 3.0:
            return "Meh..."
        else:
            return "Wow you suck!"

    def setStartTime(self):
        self.start_time = time()

    def setEndTime(self):
        self.end_time = time()

    def getStatistics(self):
        stats = {}
        score = self.computeScore()
        stats["time"] = "{0:.2f}".format(self.getPlayTime())
        stats["steps"] = str(self.used_steps)
        stats["hints"] = str(self.used_hints)
        stats["score"] = "{0:.2f}/10".format(score)
        stats["comment"] = self.generateComment(score)

        return stats

    def __str__(self):
        score = self.computeScore()

        out = "\n----- Game Stats -----"
        out += "\n Time needed: {0} sec.".format(str(self.getPlayTime())[0:6])
        out += "\n Steps needed: {0}".format(self.used_steps)
        out += "\n Max. number of steps to use: {0}".format(self.max_step_count)
        out += "\n Hints used: {0}".format(self.used_hints)
        out += "\n Overall score: {0}/10".format(str(score)[0:6])
        out += "\n"
        out += "\n \t{0}".format(self.generateComment(score))
        out += "\n----------------------"
        return out
