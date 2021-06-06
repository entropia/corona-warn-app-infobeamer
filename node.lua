util.init_hosted()
hosted_init()
gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

local images = {}
local white = resource.create_colored_texture(1,1,1,1)
local cwa_logo = resource.load_image('cwa-logo.png')

node.event("content_update", function(filename, file)
    print('loading '..filename)
    if filename:find(".png$") then
        images[filename] = resource.load_image(file)
    end
end)

function node.render()
    gl.clear(0,0,0,1)

    qr_state, qr_width, qr_height = images['cwa-qr-code.png']:state()
    logo_state, logo_width, logo_height = cwa_logo:state()

    if logo_state == 'loaded' and qr_state == 'loaded' then
        qr_x = NATIVE_WIDTH/2-qr_width/2
        qr_y = NATIVE_HEIGHT/2-(logo_height+qr_height/2)-16

        logo_x = NATIVE_WIDTH/2-logo_width/2

        white:draw(qr_x, qr_y, qr_x+qr_width, qr_y+logo_height+qr_height+16)

        images['cwa-qr-code.png']:draw(qr_x, qr_y+logo_height+16, qr_x+qr_width, qr_y+logo_height+16+qr_height)

        cwa_logo:draw(logo_x, qr_y, logo_x+logo_width, qr_y+logo_height)
    end
end
