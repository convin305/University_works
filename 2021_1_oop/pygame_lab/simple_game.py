import pygame
import random
import sys

class SimpleGame:
    def __init__(self,b_color='white'):
        pygame.init()

        self.screen = pygame.display.set_mode((640,480))    # 디스플레이
        pygame.display.set_caption("Generate Random Blocks")

        self.background = pygame.Surface(self.screen.get_size()).convert()  # 배경
        self.background.fill(b_color)

        self.block = pygame.Surface((10,10)).convert()  # 블록
        self.block.fill('red')

        self.clock = pygame.time.Clock()    # Clock 객체

    def render(self,pos):
        '''
        갱신한 화면을 보여주는 기능의 매소드
        :param pos: block의 위치좌표
        :return: None
        '''
        self.screen.blit(self.background,(0,0))     # 스크린에 배경 배치
        self.screen.blit(self.block,pos)            # 스크린에 블록을 배치

        pygame.display.flip()                       # 화면 업데이트

    def generate_blocks(self):
        self.clock.tick(3)

        block_pos = (random.randint(0,630),random.randint(0,470))
        keep_going = True

        while keep_going:
            self.clock.tick(3)

            for event in pygame.event.get():    # 이벤트들에 대해서
                if event.type == pygame.QUIT :   # QUIT 이벤트는 ~
                    keep_going = False

            block_pos = (random.randint(0,630),random.randint(0,470))
            self.render(block_pos)  # 화면 갱신하는 매소드

if __name__ == '__main__':
    game = SimpleGame()
    game.generate_blocks()