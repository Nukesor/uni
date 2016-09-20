#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import util.statics as statics


class Tile(object):
    """ Represents one tile on the board and defines transitions"""
    def __init__(self, tile_id, init_position, grid_position, drawable, color=statics.COLORS["tile"], is_blank=False):
        super(Tile, self).__init__()
        self.id = tile_id
        self.is_blank = is_blank
        self.drawable = drawable
        self.position = init_position
        self.grid_position = grid_position
        self.color = color

    def __str__(self):
        return "Tile ID: {0}; Current position (x:{1}, y:{2})".format(self.id, self.pos_x, self.pos_y)

    def __lt__(self, other):
        if not isinstance(other, self):
            return TypeError("Can't compare '{0}' and '{1}' objects".format(other, self))
        return self.id < other.id
