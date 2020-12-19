#!/usr/bin/env python3
# -*- coding: utf-8 -*-


class Stack(list):

    """ Convenience methods to use list as stack. """

    def __init__(self, array=[]):
        super(Stack, self).__init__(array)

    def peek(self):
        return self[-1]

    def push(self, item):
        self.append(item)

    def is_empty(self):
        return len(self) == 0
