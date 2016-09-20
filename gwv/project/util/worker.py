#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import star
import signal
import multiprocessing
import util.statics as statics
from util.stack import Stack


class Worker(multiprocessing.Process):
    """
        Worker thread to asynchronously fetch the next best step without locking
        the main loop
    """
    def __init__(self, state, task="ida*"):
        super(Worker, self).__init__()
        self.current_state = state
        self.task = task

    def run(self):
        solution = None
        if self.task == "ida*":
            solution = star.idastar(self.current_state)
        elif self.task == "a*":
            solution = star.astar(self.current_state)
        self.queueResult(solution)

    def queueResult(self, solution):
        # get path list from solution - 1st element (empty tile position)
        pathList = solution.path[1:]
        pathList.reverse()  # reverse pathList for stack-like access
        statics.THREADED_QUEUE.put(Stack(pathList))

    def kill(self):
        if self.is_alive():
            os.kill(self.pid, signal.SIGKILL)
