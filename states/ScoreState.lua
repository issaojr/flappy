--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

-- setting medal image variables
local BRONZE_MEDAL_IMAGE = love.graphics.newImage('bronze.png')
local SILVER_MEDAL_IMAGE = love.graphics.newImage('silver.png')
local GOLD_MEDAL_IMAGE = love.graphics.newImage('gold.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- set medal according to score    
    if self.score >= 20 then
        MEDAL_IMAGE = GOLD_MEDAL_IMAGE
    elseif self.score >= 15 then
        MEDAL_IMAGE = SILVER_MEDAL_IMAGE
    elseif self.score >= 10 then
        MEDAL_IMAGE = BRONZE_MEDAL_IMAGE
    else
        MEDAL_IMAGE = nil
    end    

    -- show medal on display
    if MEDAL_IMAGE then
        love.graphics.draw(MEDAL_IMAGE, VIRTUAL_WIDTH/2 - 8, 120)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end