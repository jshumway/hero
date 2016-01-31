local shader = {}

function shader.init(game)
    shader._lights:send('font_width', game.font.width)
end

function shader.enable(selected)
    love.graphics.setShader(shader._lights)
end

function shader.disable()
    love.graphics.setShader()
end

function shader.lights(game)
    shader._lights:send("elapsed_time", game.elapsed_time)
    love.graphics.setShader(shader._lights)
end

shader._lights = love.graphics.newShader(
[[
    vec4 position(mat4 transform_projection, vec4 vertex_pos)
    {
        return transform_projection * vertex_pos;
    }
]],
[[
    extern number font_width;
    extern number elapsed_time;


    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_pos) {
        vec4 outFrag;
        vec4 inFrag = Texel(texture, texture_coords);

        number bright_dist = 100;
        number fade_dist = 70 + (30 * sin(elapsed_time)* sin(elapsed_time));
        number dark_dist = bright_dist + fade_dist;

        // The hero is always in the center, so hack the screen-space coords..
        vec2 hero_pos = 0.5 * vec2(love_ScreenSize.x + 3 * font_width,
                                   love_ScreenSize.y);

        number dist = distance(screen_pos, hero_pos);

        if (dist <= bright_dist) {
            outFrag = inFrag;
        }
        else if (dist <= dark_dist) {
            number brightness = (dist - bright_dist) / fade_dist;
            outFrag =  (1 - brightness) * inFrag;
        }
        else {
            outFrag = 0 * inFrag;
        }

        return outFrag;
    }
]])

return shader
