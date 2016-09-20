#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
from util.stack import Stack
from multiprocessing import SimpleQueue
from util.statistics import StatController

""" Static variables """

COLORS = {
    'tile': (220, 255, 240, 255),
    'blank': (100, 100, 100),
    'text': (100, 100, 100),
    'toolbar': (120, 120, 120),
    'background': (155, 155, 155),
    'button': (220, 255, 240),
    'hintcolor': (175, 100, 100)
    }
GOAL_STATE = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, -1]
USER_HOME = os.path.expanduser('~')
SCREEN_W = 600
SCREEN_H = 600
CLOSE_CLICKED = False

""" Singletons """

THREADED_QUEUE = SimpleQueue()
HINTS = Stack()
STATS = StatController()
