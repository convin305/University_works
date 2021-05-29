import sys
import random
import pygame

SCREEN = pygame.display.set_mode((822,457))

class Paddle(pygame.sprite.Sprite):
    def __init__(self,gamer,filename):
        super().__init__()

        self.image = pygame.image.load(filename).convert()

        self.rect = self.image.get_rect()

        # self.rect.x = (SCREEN.get_width() - self.rect.width) if gamer != 'blue' else 0
        if gamer == "blue":
            self.rect.x = 0             # 게이머가 blue이면 왼쪽에 위치시킨다.
        else :
            self.rect.x = SCREEN.get_width() - self.rect.width

        # (self.rect.x, self.rect.y) : 패들 이미지의 좌측 상단점
        # self.rect.x, self.rect.centerx, self.rect.right
        # self.rect.y, self.rect.centery, self.rect.bottom

        self.rect.y = random.randint(0,SCREEN.get_height() - self.rect.height)
        self.rect.bottom = random.randint(0,SCREEN.get_height())

        self.dy = 2

    def paddle_down(self):
        self.rect.y += self.dy          # 한번에 2픽셀씩 밑으로 이동
        if self.rect.centery >= SCREEN.get_height():
            self.rect.centery = SCREEN.get_height()

    def paddle_up(self):
        self.rect.y -= self.dy          # 한번에 2픽셀씩 위로 이동
        if self.rect.centery <= 0 :
            self.rect.centery = 0


class Ball(pygame.sprite.Sprite):
    def __init__(self,filename):
        super().__init__()

        self.image = pygame.image.load(filename).convert_alpha()
        self.rect = self.image.get_rect()

    # 서브권을 가진 플레이어에 따른 최초 공의 위치
    def prepare_ball(self,player):
        self.rect.centerx = SCREEN.get_width() // 2     # 화면의 중앙
        # 공 위치 범위 제한
        min_y = int(SCREEN.get_height()*0.2)
        max_y = int(SCREEN.get_height()*0.8)
        self.rect.centery = random.randint(min_y,max_y)
        
        # 왼쪽에 있으면 오른쪽으로 공을 보내고, 오른쪽에 있으면 왼쪽으로 공을 보낸다. 
        if player == 0:
            self.dx = 2
        else : 
            self.dx = -2
            
        self.dy = random.choice([-1,1])     # 위, 중간, 아래 중 선택

    def bounce_wall(self,wall_grp):
        # t라는 이름의 스프라이트 리스트
        t = pygame.sprite.spritecollide(self,wall_grp, False)
        if len(t) > 0 :
            pygame.mixer.Sound('sounds/wall_beep.ogg').play()
            self.dy *= -1
            return True
        else :
            return False
        
    def bounce_paddle(self,paddle_grp):
        # 스프라이트 그룹과 스프라이트 객체 하나와의 충돌감지해서 리스트 반환
        paddle = pygame.sprite.spritecollide(self, paddle_grp, False)
        if len(paddle) > 0:
            self.dx *= -1
            ratio = 2*(self.rect.centery - paddle[0].rect.centery)/paddle[0].rect.height    # 변경필요
            self.dy = self.dy + int(self.dy * ratio)

            pygame.mixer.Sound('sounds/paddle_beep.ogg').play()
            return True

        return False

    def update(self):
        self.rect.x += self.dx
        self.rect.y += self.dy


class Wall(pygame.sprite.Sprite):
    def __init__(self,position):
        super().__init__()

        self.image = pygame.Surface((SCREEN.get_width(),1)).convert()
        self.rect = self.image.get_rect().move(0,0)
        self.rect.y = SCREEN.get_height() if position == 'bottom' else 0

class ScoreBoard(pygame.sprite.Sprite):
    def __init__(self):
        super().__init__()

        self.score = {'blue' : 0, 'red' : 0}
        self.font = pygame.font.SysFont(None, 50)

        self.image = self.font.render(f'{self.score["blue"]}    {self.score["red"]}',True, 'white')

        self.rect = self.image.get_rect()
        self.rect.centerx = SCREEN.get_width()//2
        self.rect.y = 5

    def update_score(self):
        self.text = f'{self.score["blue"]}    {self.score["red"]}'
        self.image = self.font.render(self.text, True, 'white')

class Message(pygame.sprite.Sprite):
    def __init__(self,msg):
        super().__init__()
        my_font = pygame.font.Font(None,50)
        self.image = my_font.render(msg,True,'white')
        self.rect = self.image.get_rect()
        self.rect.centerx = SCREEN.get_width()//2
        self.rect.centery = SCREEN.get_height()//2

class Pingpong:
    def __init__(self):
        pygame.init()
        
        self.background = pygame.Surface(SCREEN.get_size())
        self.background.fill("black")
        pygame.draw.line(self.background,'gray',(SCREEN.get_width()//2,0),
                         (SCREEN.get_width()//2,SCREEN.get_height()))
        pygame.draw.rect(self.background, 'white',
                         (0,0,SCREEN.get_width(),SCREEN.get_height()), width=10)
        SCREEN.blit(self.background,(0,0))

        self.paddle = {'blue': Paddle('blue','images/blue_paddle.jpg'),
                       'red': Paddle('red','images/red_paddle.jpg')}
        self.wall = {'top' : Wall('top'),
                     'bottom': Wall('bottom')}
        self.ball = Ball('images/ball2.png')
        self.score_board = ScoreBoard()
        self.message = Message("Press any key to start.")


        # 스프라이트 그룹
        self.sp_grps = {'paddle' : pygame.sprite.Group(self.paddle['blue'],self.paddle['red']),
                        'wall' : pygame.sprite.Group(self.wall['top'],self.wall['bottom']),
                        'ball' : pygame.sprite.Group(self.ball),
                        'scoreboard' : pygame.sprite.Group(self.score_board),
                        'message' : pygame.sprite.Group(self.message)}
        self.clock = pygame.time.Clock()

    def render(self):
        for name in self.sp_grps:
            self.sp_grps[name].clear(SCREEN, self.background)
            self.sp_grps[name].update()
            self.sp_grps[name].draw(SCREEN)

        pygame.display.flip()

    def show_message(self):
        self.sp_grps['message'].update()
        self.sp_grps['message'].draw(SCREEN)
        pygame.display.flip()

    def do_serve(self):
        offence = sum(self.score_board.score.values())//5
        self.ball.prepare_ball(offence%2)
        self.show_message()

        
        while True:
            event = pygame.event.wait()
            if event.type == pygame.QUIT:
                sys.exit()
            # red 나 blue가 15점을 얻으면 게임 종료
            elif self.score_board.score['red'] == 15 :
                sys.exit()
            elif self.score_board.score['blue'] == 15 :
                sys.exit()
            elif event.type == pygame.KEYDOWN:
                self.sp_grps['message'].remove(self.message)        # 키 다운을 누르면 메시지 삭제
                break

    def is_ball_alive(self):
        flag = True         # 공이 살아있는 경우

        if self.ball.rect.x < 0:            # red wins
            pygame.mixer.Sound('sounds/dying_ball.mp3').play()
            self.score_board.score['red'] += 1
            self.score_board.update_score()
            flag = False    # 공이 죽음..
        elif self.ball.rect.x > SCREEN.get_width():     # blue wins
            pygame.mixer.Sound('sounds/dying_ball.mp3').play()
            self.score_board.score['blue'] += 1
            self.score_board.update_score()
            flag = False

        return flag

    def game_loop(self):
        fps = 1000

        self.do_serve()
        while True:
            self.clock.tick(fps)

            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    sys.exit(0)

            # 키보드를 무엇을 눌렀느냐에 따라서 패들의 위치 조절
            press_key = pygame.key.get_pressed()
            if press_key[pygame.K_q]:
                self.paddle['blue'].paddle_up()
            elif press_key[pygame.K_a]:
                self.paddle['blue'].paddle_down()
            elif press_key[pygame.K_p]:
                self.paddle['red'].paddle_up()
            elif press_key[pygame.K_l]:
                self.paddle['red'].paddle_down()

            # 공이 살아있으면
            if self.is_ball_alive():
                self.ball.bounce_paddle(self.sp_grps['paddle'])
                self.ball.bounce_wall(self.sp_grps['wall'])
            else :
                self.do_serve()

            self.render()


if __name__ == "__main__":
    game = Pingpong()
    game.game_loop()
