#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import star
import math
import pygame
import pygame.locals

import util.statics as statics
from game.tile import Tile
from game.board import Board


def initGameScreen():
    screen = pygame.display.set_mode((statics.SCREEN_W, statics.SCREEN_H))
    pygame.display.set_caption("15 Tile – Game")
    return screen


def initBackground(screen):
    background = pygame.Surface(screen.get_size())
    background = background.convert()
    background.fill(statics.COLORS['background'])
    return background


def initToolbar():
    toolbar = pygame.Surface((statics.SCREEN_W, 50))
    toolbar = toolbar.convert()
    toolbar.fill(statics.COLORS['toolbar'])
    hint_btn = pygame.Rect((5, 5), (100, 40))
    reset_btn = pygame.Rect((statics.SCREEN_W - 160, 5), (150, 40))

    pygame.draw.rect(toolbar, statics.COLORS['button'], hint_btn)
    pygame.draw.rect(toolbar, statics.COLORS['hintcolor'], reset_btn)
    return toolbar, hint_btn, reset_btn


def initStatScreen(screen):
    margin = 20
    line_height = 40
    stat_screen = pygame.Surface((statics.SCREEN_W, statics.SCREEN_H-50))
    stat_screen.convert()
    stat_screen.fill(statics.COLORS['background'])
    start_x = stat_screen.get_rect().midtop[0] - 150
    start_y = stat_screen.get_rect().midtop[1] + 50
    stat_positions = {}
    stat_positions["title"] = ((start_x, start_y + margin))
    stat_positions["time"] = ((start_x, start_y + (line_height) + (margin)*2))
    stat_positions["steps"] = ((start_x, start_y + (line_height)*2 + (margin)*3))
    stat_positions["hints"] = ((start_x, start_y + (line_height)*3 + (margin)*4))
    stat_positions["score"] = ((start_x, start_y + (line_height)*4 + (margin)*5))
    stat_positions["comment"] = ((start_x, start_y + (line_height)*5 + (margin)*8))
    return stat_screen, stat_positions


def handleHintClick(click_pos, btn, board):
    if btn.collidepoint(click_pos) and not board.is_won:
        if not statics.HINTS.is_empty():
            path = statics.HINTS.peek()
            if path:
                hint = path.peek()
                board.showHint(hint)
        else:
            print("DEBUG: Still waiting for hint...")


def resetClick(click_pos, btn):
    return btn.collidepoint(click_pos)

def makeTiles():
    margin = 10
    width = statics.SCREEN_W / 4 - 3 * margin
    height = statics.SCREEN_H / 4 - 3 * margin
    tiles = []
    for i in range(0, 16):
        x = i % 4
        y = int(math.floor(i/4))
        x_pos = x * (width + margin) + (margin*4)
        y_pos = y * (height + margin) + (margin*2) + 50
        drawable = pygame.Rect(x_pos, y_pos, width, height)
        if i == 15:
            tiles.append(Tile(i, (x_pos, y_pos), (x, y), drawable, statics.COLORS['blank'], True))
        else:
            tiles.append(Tile(i, (x_pos, y_pos), (x, y), drawable))
    return tiles


def runGameLoop(screen, background, stat_screen, stat_positions, toolbar, hint_btn, reset_btn, font, board):
    running = True
    clock = pygame.time.Clock()
    # game loop
    while running:
        # check the queue for new hints and put them in a stack
        if not statics.THREADED_QUEUE.empty():
            statics.HINTS.push(statics.THREADED_QUEUE.get())

        # handle user input
        for event in pygame.event.get():
            if event.type == pygame.MOUSEBUTTONDOWN:
                handleHintClick(event.pos, hint_btn, board)
                board.handleTileClick(event.pos)
                if resetClick(event.pos, reset_btn):
                    board.handleQuitClick()
                    running = False
            elif event.type == pygame.QUIT:
                board.handleQuitClick()
                running = False
                statics.CLOSE_CLICKED = True

        # draw background and toolbar to screen
        background.blit(toolbar, (0, 0))
        background.blit(font.render('Hint', True, statics.COLORS['text']), (24, 8))
        background.blit(font.render('Reset', True, statics.COLORS['text']), (statics.SCREEN_W-124, 8))
        screen.blit(background, (0, 0))

        # draw numbers onto tiles
        for tile in board.state:
            pygame.draw.rect(background, tile.color, tile.drawable)
            if tile.id != -1:
                background.blit(font.render(str(tile.id + 1), True, statics.COLORS['text']), (tile.drawable.center[0] - 15, tile.drawable.center[1] - 15))

        # if winning state is entered, draw statistics
        if board.is_won:
            stats = statics.STATS.getStatistics()
            stat_screen.blit(font.render("You Won!", True, statics.COLORS['text']), stat_positions["title"])
            stat_screen.blit(font.render("Time used: " + stats["time"], True, statics.COLORS['text']), stat_positions["time"])
            stat_screen.blit(font.render("Steps needed: " + stats["steps"], True, statics.COLORS['text']), stat_positions["steps"])
            stat_screen.blit(font.render("Hints used: " + stats["hints"], True, statics.COLORS['text']), stat_positions["hints"])
            stat_screen.blit(font.render("Your Score: " + stats["score"], True, statics.COLORS['text']), stat_positions["score"])
            stat_screen.blit(font.render(stats["comment"], True, statics.COLORS['text']), stat_positions["comment"])

            screen.blit(stat_screen, (0, 51))

        # ensure a maximum framerate of 60fps
        clock.tick(60)

        # redraw screen
        pygame.display.flip()


# Entry point for tile game
def main(image_source):
    pygame.init()
    screen = initGameScreen()
    background = initBackground(screen)
    stat_screen, stat_positions = initStatScreen(screen)
    toolbar, hint_btn, reset_btn = initToolbar()
    font = pygame.font.SysFont('Arial', 30)

    while not statics.CLOSE_CLICKED:
        # create a 4x4 tile grid
        tiles = makeTiles()
        init_state = star.getRandomInitState()
        # init_state = [9, 4, 1, 5, 6, 3, 12, 0, 13, 11, '', 7, 8, 10, 14, 2]
        # initialize the game board with our tile grid and random state
        board = Board(init_state, tiles)
        runGameLoop(screen, background, stat_screen, stat_positions, toolbar, hint_btn, reset_btn, font, board)


if __name__ == '__main__':
    # TODO: handle console input and pass specified image to main
    image = statics.USER_HOME + "/Pictures/NSA-killed-my-Internet.jpg"
    main(image)
