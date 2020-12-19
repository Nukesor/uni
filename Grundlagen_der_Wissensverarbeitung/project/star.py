#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import ast
import math
import random
import cProfile
import datetime
from heapq import heappop, heappush

# Performance Data
added_nodes = 0
closed_nodes = 0
omitted_nodes = 0
heuristic_calls = 0

# Global closedList:
closedList = set()
closedDict = {}

# Endstate for calculating manhattan distance
endState = {}
for y in range(0, 4):
    for x in range(0, 4):
        endState[(x+y*4)] = (x, y)

# goal Rows for computing linear conflicts
goalRows = {}
goalRows['x'] = []
goalRows['y'] = []


def read_input(_list):
    formatted = []
    for value in _list:
        if value == 0:
            formatted.append('')
        else:
            formatted.append(value-1)
    print(formatted)
    return formatted


class State():
    __slots__ = ('state', 'emptyTile', 'steps', 'path', 'estimateSteps', 'estimateCost')

    def __init__(self, other, steps, path, prevDistance=None):
        self.state = []
        # Initializing. The current state and matrix can be created by
        # providing a list or a string.
        if isinstance(other, list):
            self.state = other
        elif isinstance(other, str):
            self.state = self.fromString(other)
        else:
            print("{0}, {1}".format(other, type(other)))
            return NotImplemented

        self.discoverEmpty()
        self.steps = steps
        if len(path) == 0:
            path = [self.emptyTile]
        self.path = path
        self.estimateSteps = self.heuristic(prevDistance)
        self.estimateCost = self.estimateSteps + self.steps + self.getLinearConflicts()

    # Finds the empty Tile in the list
    def discoverEmpty(self):
        i = self.state.index('')
        x = i % 4
        y = math.floor(i/4)
        self.emptyTile = (x, y)

    # Get number at tuple (x,y)
    def getTile(self, position):
        x, y = position
        return self.state[int(x + y*4)]

    def heuristic(self, prevDistance):
        global heuristic_calls
        distance = 0
        if prevDistance is None:
            # Checking distance for every object.
            # This is done by comparing with endState and calculating manhattan distance
            for y in range(0, 4):
                for x in range(0, 4):
                    number = self.getTile((x, y))
                    distance += self.manhattanDistance((x, y), number)

        else:
            # Get heuristic of previous State
            distance = prevDistance
            # Get switched Tile position and number
            prev_empty = self.path[-2]
            number = self.getTile(prev_empty)

            # Compute the difference between previous number state and current
            current_number_distance = self.manhattanDistance(prev_empty, number)
            prev_number_distance = self.manhattanDistance(self.emptyTile, number)
            distance = distance + (current_number_distance - prev_number_distance)

            heuristic_calls += 1

        return distance

    def manhattanDistance(self, position, number):
        if number == '':
            return 0
        x_end, y_end = endState[number]
        return (math.fabs(position[0]-x_end) + math.fabs(position[1]-y_end))

    def getLinearConflicts(self):
        distance = 0
        global goalRows
        # Check for all Rows/Columns, if there are linear conflicts
        for runner in range(0, 4):
            # Get global dictionary, which contains the goal rows
            maxValue = 0
            for i in goalRows['x'][runner]:
                value = self.state[i]
                # Check if it's the empty tile, or if the current value belongs to this row
                if value != '' and value in goalRows['x'][runner]:
                    # If the value is in the correct row we set it as max Value.
                    # If there already has been a correct value in the row and it is higher
                    # as the current value, we know that there is a linear conflict.
                    if value >= maxValue:
                        maxValue = value
                    else:
                        distance += 2

            # The same procedure as above, but with columns
            maxValue = 0
            for i in goalRows['y'][runner]:
                value = self.state[i]
                if value != '' and value in goalRows['y'][runner]:
                    if value >= maxValue:
                        maxValue = value
                    else:
                        distance += 2
        return distance

    # Expects a positon tuple (x, y) and swaps the specified position with the empty tile
    def swapPositions(self, targetPosition):
        newState = list(self.state)
        x, y = self.emptyTile
        x_new, y_new = targetPosition

        # Generate new state with swapped empty tile position
        newState[int(x+y*4)] = newState[int(x_new+y_new*4)]
        newState[int(x_new+y_new*4)] = ''

        # Add next empty tile position in the path
        path = list(self.path)
        path.append((x_new, y_new))
        return State(newState, self.steps+1, path, self.estimateSteps)

    # Get States of the surrounding positions
    def getSurroundingStates(self):
        x, y = self.emptyTile
        surrounding = []
        if len(self.path) > 1:
            lastPosition = self.path[-2]
        else:
            lastPosition = (-1, -1)
        if (y+1) < 4:
            if y+1 != lastPosition[1]:
                surrounding.append(self.swapPositions((x, y+1)))
        if (y-1) >= 0:
            if y-1 != lastPosition[1]:
                surrounding.append(self.swapPositions((x, y-1)))
        if (x+1) < 4:
            if x+1 != lastPosition[0]:
                surrounding.append(self.swapPositions((x+1, y)))
        if (x-1) >= 0:
            if x-1 != lastPosition[0]:
                surrounding.append(self.swapPositions((x-1, y)))

        return surrounding

    # Exports the state list to a string
    def toString(self):
        return str(self.state)

    # Gets a state list from a string
    def fromString(self, string):
        return ast.literal_eval(string)

    # Check, if this state is in the closed list
    def inClosed(self):
        _hash = self.toString()
        global closedList
        return _hash in closedList

    def addToClosed(self, toDict=False):
        global closedList
        global closedDict
        string = self.toString()
        closedList.add(string)
        if toDict:
            closedDict[string] = self.estimateCost

    def __lt__(self, other):
        return True

    # This function formats the internal matrix for print output
    def __str__(self):
        string = ''
        string += '--------------\n'
        for y in range(0, 4):
            string += '|'
            for x in range(0, 4):
                number = str(self.getTile((x, y)))
                if len(number) < 1:
                    number += '  '
                elif len(number) < 2:
                    number += ' '
                string += number
                string += ' '
            string += '|\n'

        string += '--------------\n'
        return string


def getRandomInitState():
    # Create random start sequence
    while True:  # Repeat until valid init state is found
        random_init_state = []
        for value in range(0, 16):
            if value == 15:
                random_init_state.append('')
            else:
                random_init_state.append(value)
        random.shuffle(random_init_state)

        if isSolvable(random_init_state):
            return random_init_state


def findBlankRow(init_state):
    rows = [range(0, 4), range(4, 8), range(8, 12), range(12, 16)]
    blank_field = init_state.index('')
    for row in rows:
        if row.count(blank_field) != 0:
            return rows.index(row)


def isSolvable(init_state):
    inversions = 0
    blank_row = findBlankRow(init_state)
    state = list(init_state)
    state.remove('')  # strip blank field to easily process list of numbers
    for i in range(0, len(state)):
        current_head = state[i]
        current_tail = state[i:]
        for number in current_tail:
            if current_head > number:
                inversions += 1

    # if blank is in even row AND inversions are odd ==> solvable
    # if blank is in odd row AND inversions are even ==> solvable
    return (blank_row % 2 == 0 and inversions % 2 != 0) or (blank_row % 2 != 0 and inversions % 2 == 0)


# A* Implementation
def astar(start_state=None):
    # Globals
    global goalRows
    global added_nodes
    global omitted_nodes
    global closed_nodes
    global closedList

    # Precompute globals for less on the fly computing in linear conflict
    rowSelector = [0, 1, 2, 3]
    columnSelector = [0, 4, 8, 12]
    for i in range(0, 4):
        goalRow = list(map(lambda x: x+i*4, rowSelector))
        goalRows['x'].append(goalRow)
        goalColumn = list(map(lambda x: x+i, columnSelector))
        goalRows['y'].append(goalColumn)

    # Create a random, solvable init state
    if start_state is None:
        start_state = getRandomInitState()
    # start_state = [9, 4, 1, 5, 6, 3, 12, 0, 13, 11, '', 7, 8, 10, 14, 2]

    # Create start state and remember start state for later usage
    startState = State(start_state, 0, [])
    print(startState)

    startTime = datetime.datetime.now()
    start = datetime.datetime.now()
    stop = datetime.datetime.now()

    heap = []
    running = True
    heappush(heap, (startState.estimateCost, startState))
    while running:

        # Get next State from Heap
        largest = heappop(heap)
        current = largest[1]

        # Get next nodes
        surrounding = current.getSurroundingStates()
        for item in surrounding:
            if item.estimateSteps == 0:
                # Set True to enable debugging
                if True:
                    stop = datetime.datetime.now()
                    delta = (stop - startTime).microseconds / 1000
                    deltaSecs = (stop - startTime).seconds

                    print("\nTarget Found: ")
                    print(item)
                    print("\nPath to Target: ", item.path)
                    print("\nSteps: ", item.steps)
                    print("\nAdded nodes: ", added_nodes)
                    print("Closed nodes: ", closed_nodes)
                    print("Ommited Nodes: ", omitted_nodes)
                    print("Heap Length: ", len(heap))
                    print("Overall computed Heuristics: ", heuristic_calls)
                    print("Overall used Time: {}s {}ms".format(deltaSecs, delta))
                    print('')

                # Stop loop
                running = False
                break
            else:
                if not item.inClosed():
                    heappush(heap, (item.estimateCost, item))
                    added_nodes += 1
                    if added_nodes % 10000 == 0:
                        stop = datetime.datetime.now()
                        delta = (stop - start).microseconds / 1000
                        deltaSecs = (stop - start).seconds
                        start = datetime.datetime.now()
                        # Set True to enable debugging
                        if False:
                            print("\nCurrent State: ")
                            print(item)
                            print("\nUsed Steps: ", item.steps)
                            print("\nPath to Target: ")
                            print(item.path)
                            print("\nEstimate Steps: ", item.estimateSteps)
                            print("\nEstimate Costs: ", item.estimateCost)
                            print("\nAdded nodes: ", added_nodes)
                            print("Closed nodes: ", closed_nodes)
                            print("Ommited Nodes: ", omitted_nodes)
                            print("Heap Length: ", len(heap))
                            print("Overall computed Heuristics: ", heuristic_calls)
                            print('')
                            print("Used Time: {}s {}ms".format(deltaSecs, delta))

                else:
                    omitted_nodes += 1

        # Close current State
        current.addToClosed()
        closed_nodes += 1

    # Return node if found
    return item.path


# IDA* Implementation
def idastar(start_state=None):
    # Globals
    global goalRows
    global added_nodes
    global omitted_nodes
    global closed_nodes
    global closedList
    global closedDict

    # Precompute globals for less on the fly computing in linear conflict
    rowSelector = [0, 1, 2, 3]
    columnSelector = [0, 4, 8, 12]
    for i in range(0, 4):
        goalRow = list(map(lambda x: x+i*4, rowSelector))
        goalRows['x'].append(goalRow)
        goalColumn = list(map(lambda x: x+i, columnSelector))
        goalRows['y'].append(goalColumn)

    # Create a random, solvable init state
    if start_state is None:
        start_state = getRandomInitState()
    # Create state that needs 42 steps and 2s to solve
    # start_state = [13, 7, 3, 0, 8, 4, 2, 10, '', 1, 5, 6, 14, 9, 12, 11]

    # Create start state and remember start state for later usage
    startState = State(start_state, 0, [])
    print(startState)

    # Get modulo 2
    for value in startState.state:
        if value == '':
            index = startState.state.index(value)
            x = index % 4
            y = math.floor(index/4)
            x_end, y_end = endState[15]
            modulo = (math.fabs(x-x_end) + math.fabs(y-y_end)) % 2

    startTime = datetime.datetime.now()
    start = datetime.datetime.now()
    stop = datetime.datetime.now()

    stack = []
    running = True
    limit = startState.heuristic(None) - 1
    while running:
        if limit % 2 != modulo:
            limit += 1
        else:
            limit += 2
        closedList = set()
        closedDict = {}
        stack.append(startState)

        while len(stack) != 0 and running:
            # Get next State from Stack
            current = stack.pop()

            # Get next nodes
            surrounding = current.getSurroundingStates()
            for item in surrounding:
                if item.estimateSteps == 0:
                    stop = datetime.datetime.now()
                    delta = (stop - startTime).microseconds / 1000
                    deltaSecs = (stop - startTime).seconds

                    print("\nStart State:")
                    print(startState)
                    print(startState.toString())
                    print('\nTarget found:')
                    print("\nPath to Target: ", item.path)
                    print("\nSteps: ", item.steps)
                    print("Limit: ", limit)
                    print("\nAdded nodes: ", added_nodes)
                    print("Closed nodes: ", closed_nodes)
                    print("Ommited Nodes: ", omitted_nodes)
                    print("Stack Length: ", len(stack))
                    print("Overall computed Heuristics: ", heuristic_calls)
                    print("Overall used Time: {}s {}ms".format(deltaSecs, delta))
                    print('')

                    running = False
                    break
                else:
                    if item.estimateCost <= limit:
                        inclosed = item.inClosed()
                        if not inclosed or (inclosed and closedDict[item.toString()] > item.estimateCost):
                            stack.append(item)
                            added_nodes += 1
                            if added_nodes % 10000 == 0:
                                stop = datetime.datetime.now()
                                delta = (stop - start).microseconds / 1000
                                deltaSecs = (stop - start).seconds
                                start = datetime.datetime.now()
                                # Set True to enable debugging
                                if False:
                                    print("\nCurrent State: ")
                                    print(item)
                                    print("\nPath to Target: ")
                                    print(item.path)
                                    print("\nUsed Steps: ", item.steps)
                                    print("Limit: ", limit)
                                    print("Estimate Steps: ", item.estimateSteps)
                                    print("Estimate Costs: ", item.estimateCost)
                                    print("Added nodes: ", added_nodes)
                                    print("Closed nodes: ", closed_nodes)
                                    print("Ommited Nodes: ", omitted_nodes)
                                    print("Stack Length: ", len(stack))
                                    print("Overall computed Heuristics: ", heuristic_calls)
                                    print('')
                                    print("Used Time: {}s {}ms".format(deltaSecs, delta))
                        else:
                            omitted_nodes += 1
                    else:
                        omitted_nodes += 1

            # Close current State
            current.addToClosed(True)
            closed_nodes += 1

    return item

if __name__ == '__main__':
    if False:
        cProfile.run('main()')
    else:
        idastar()
