push = require 'push'
Class = require 'class'
require 'Player'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
speed=80

gameState = 'play'
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync= true

    })

    big_font = love.graphics.newFont('font.ttf', 36)
    love.graphics.setFont(big_font)

    ball = Ball(0, VIRTUAL_HEIGHT/2-25, 25, 25)

    player1 = Player(10,20,40,40)
    player2 = Player(50,50,40,40)


end

function love.keypressed(key)
    if key == 'q' then
        love.event.quit()
    end
    if key == 'space' and gameState == 'play' then
        gameState = 'paused'
    elseif  key == 'space' and gameState == 'paused' then
        gameState = 'play'
    end
end

function love.update(dt)
    ball.x = ball.x + speed * ball.dir * dt

    if ball.dir == 1 and (ball.x >= VIRTUAL_WIDTH  or ball:collides(player2) ) then
        ball.dir = -1
    elseif ball.dir == -1  and ball.x <= 0 or ball:collides(player1)  then
        ball.dir = 1
    end
   
    
    if gameState == 'play' then 
        -- player1
        if love.keyboard.isDown('d') and (not player1:collides(player2) or not (player2.x + player2.width > player1.x)) then
            player1.x = math.min( VIRTUAL_WIDTH-40, player1.x + speed * dt ) 
        end
        if love.keyboard.isDown('a') and  (not player1:collides(player2) or not (player2.x + player2.width > player1.x))   then
            player1.x = math.max (0, player1.x - speed * dt )
        end
        if love.keyboard.isDown('w') and (not player1:collides(player2) or not (player2.y + player2.height > player1.y)) then
            player1.y = math.max( 0, player1.y - speed * dt) 
        end

        if love.keyboard.isDown('s') and (not player1:collides(player2) or not (player2.y + player2.height > player1.y)) then
            player1.y = math.min( VIRTUAL_HEIGHT-40, player1.y + speed * dt) 
        end
        -- player2
        if love.keyboard.isDown('right') and (not player2:collides(player1) or not (player1.x + player1.width > player2.x)) then
            player2.x = math.min( VIRTUAL_WIDTH-40, player2.x + speed * dt )
        end
        if love.keyboard.isDown('left') and (not player2:collides(player1) or not (player1.x + player1.width > player2.x))  then
            player2.x = math.max (0, player2.x - speed * dt )
        end

        if love.keyboard.isDown('up') and (not player2:collides(player1) or not (player1.y + player1.height > player2.y)) then
            player2.y = math.max( 0, player2.y - speed * dt) 
        end

        if love.keyboard.isDown('down') and (not player1:collides(player2) or not (player1.y < player2.y + player2.height)) then
            player2.y = math.min( VIRTUAL_HEIGHT-40, player2.y + speed * dt) 
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(100/255, 0/255, 200/255, 255/255)
    
    

    player1:render()
    player2:render()
    ball:render()
    push:apply('end')
end
