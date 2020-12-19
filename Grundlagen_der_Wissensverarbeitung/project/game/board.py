#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import util.statics as statics
from util.worker import Worker


class Board(object):
    """ Represents the playing board that holds the base image, an array of
        'Tile' objects and the current game state"""
    def __init__(self, tile_positions, tiles):
        super(Board, self).__init__()
        self.state = self.initializeBoardState(tile_positions, tiles)
        self.is_won = False
        self.workers = []

    # Read a string of randomly initialized tiles into an array and convert it
    # to a 2-dimensional array of 'Tile' objects
    def initializeBoardState(self, tile_positions, tiles):
        for i in range(0, 16):
            if tile_positions[i] != '':
                tiles[i].id = tile_positions[i]
                tiles[i].is_blank = False
                tiles[i].color = statics.COLORS['tile']
            else:
                tiles[i].id = -1
                tiles[i].is_blank = True
                tiles[i].color = statics.COLORS['blank']

        # start game timer
        statics.STATS.setStartTime()
        return tiles

    def startSearchThread(self):
        out_state = [self.state[x].id for x in range(0, len(self.state))]
        out_state[out_state.index(-1)] = ''
        # if worker exists kill it first...
        if self.workers:
            self.killWorker()
        # then spawn new worker
        self.spawnWorker(out_state)

    def spawnWorker(self, state):
        w = Worker(state, task="ida*")
        self.workers.append(w)
        w.start()
        print("New Worker: {0}, alive: {1}, pid: {2}".format(w, w.is_alive(), w.pid))

    def killWorker(self):
        w_old = self.workers.pop()
        print("Killing old Worker {0}, with pid {1}".format(w_old, w_old.pid))
        w_old.kill()
        w_old.join()  # make thread wait for worker to die
        print("Old worker alive? {0}".format(w_old.is_alive()))

    def handleQuitClick(self):
        if self.workers:
            self.killWorker()

    def swapTiles(self, tile, blank):
        # log 1 step
        statics.STATS.used_steps += 1

        blank.id = tile.id
        blank.color = statics.COLORS['tile']
        blank.is_blank = False

        tile.id = -1
        tile.color = statics.COLORS['blank']
        tile.is_blank = True

        # check if we've won
        if self.isGoalState():
            statics.STATS.setEndTime()
            print(statics.STATS)
            self.is_won = True
            return

        if not self.currentStepIsNextHinted(tile):
            self.startSearchThread()
        else:
            path = statics.HINTS.peek()  # get the current hinted path to goal
            path.pop()  # remove the step made from the hint path
            print("Current optimal path to goal:\n{0}".format(path))

    def currentStepIsNextHinted(self, clicked_tile):
        if not statics.HINTS.is_empty():
            path = statics.HINTS.peek()
            if not path.is_empty():
                step = path.peek()
                print("Hinted = {0}, actual = {1}".format(step, clicked_tile.grid_position))
                return step == clicked_tile.grid_position
        return False

    def getBlankNeighbour(self, tile):
        actual_pos = self.state.index(tile)

        if actual_pos > 2:
            up = self.state[actual_pos - 4]
            if up.is_blank:
                return up
        if actual_pos < 12:
            down = self.state[actual_pos + 4]
            if down.is_blank:
                return down
        if actual_pos > 0:
            left = self.state[actual_pos - 1]
            if left.is_blank:
                return left
        if actual_pos < 15:
            right = self.state[actual_pos + 1]
            if right.is_blank:
                return right

        return False

    def isGoalState(self):
        current_state = [self.state[x].id for x in range(0, len(self.state))]
        return current_state == statics.GOAL_STATE

    def showHint(self, step):
        # log 1 hint used
        statics.STATS.used_hints += 1

        for tile in self.state:
            if tile.grid_position == step:
                tile.color = statics.COLORS['hintcolor']

    def handleTileClick(self, click_pos):
        for tile in self.state:
            if tile.drawable.collidepoint(click_pos):
                print("Clicked tile {0}, grid position {1}".format(tile.id, tile.grid_position))
                blank = self.getBlankNeighbour(tile)
                if blank:
                    self.swapTiles(tile, blank)
