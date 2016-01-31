local Textbox = {}
Textbox.__index = Textbox

function Textbox:new()
    local newTextbox = {
        text = '',
        finalText = '',
        finalLength = 0,
        writing = false,
        finished = true,
        elapsedTime = 0,
        DRAW_TIME = .1, -- seconds per character drawn
        HANG_TIME = 1 -- seconds the full message displays for
    }
    return setmetatable(newTextbox, self)
end

function Textbox:update(dt)
    -- Ensure the textbox is currently trying to display some message.
    if self.finished then
        return
    end

    self.elapsedTime = self.elapsedTime + dt

    -- Ensure the textbox hasn't been around too long.
    if not self.writing then
        self.finished = self.elapsedTime >= self.HANG_TIME
        return
    end

    -- Ensure it's time to draw another character of the message.
    if self.elapsedTime < self.DRAW_TIME then
        return
    end
    self.elapsedTime = 0

    -- Ensure there are still characters left to draw.
    local currentLength = string.len(self.text)
    if currentLength == self.finalLength then
        self.writing = false
        return
    end

    self.text = string.sub(self.finalText, 1, currentLength + 1)
end

function Textbox:write(text)
    self.finalText = text
    self.finalLength = string.len(text)
    self.text = ''
    self.writing = true
    self.finished = false
    self.elapsedTime = 0
end

function Textbox:draw(game)
    -- Ensure the textbox is currently trying to display some message.
    if self.finished then
        return
    end

    local relativeOrigin =  {
        x = game.hero.pos.x - (game.screen.width / 2),
        y = game.hero.pos.y - (game.screen.height / 2)
    }
    local borderWidth = .5 * game.font.width
    local leftMargin = relativeOrigin.x + 2 * game.font.width
    local rightMargin = relativeOrigin.x + game.screen.width - (2 * game.font.width)
    local bottomMargin = relativeOrigin.y + game.screen.height - (2 * game.font.height)
    -- 3 rows of text, plus 1-ish row of border
    local topMargin = bottomMargin - (4 * game.font.height)

    local function drawBorder()
        love.graphics.rectangle(
            "fill",
            leftMargin,
            topMargin,
            rightMargin - leftMargin,
            bottomMargin - topMargin)
    end

    local function drawTextbox()
        love.graphics.rectangle(
            "fill",
            leftMargin + borderWidth,
            topMargin + borderWidth,
            (rightMargin - borderWidth) - (leftMargin + borderWidth),
            (bottomMargin - borderWidth) - (topMargin + borderWidth))
    end

    local function drawText()
        love.graphics.print(
            self.text,
            leftMargin + borderWidth + game.font.width,
            topMargin + borderWidth + game.font.height)
    end

    local function useBlack()
        love.graphics.setColor(0, 0, 0)
    end

    local function useWhite()
        love.graphics.setColor(255, 255, 255)
    end

    useWhite()
    drawBorder(self, game)

    useBlack()
    drawTextbox(self, game)

    useWhite()
    drawText(self, game)
end

return Textbox
