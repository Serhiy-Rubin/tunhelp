script_name("tunhelp")
script_author("Serhiy_Rubin")
script_version("21.1.4.1")

sampev, inicfg, dlstatus, vkeys =
    require "lib.samp.events",
    require "inicfg",
    require("moonloader").download_status,
    require "lib.vkeys"

local vehicle = {
	['N'] = {["Landstalker"] = 130000, ["Perenniel"] = 100000, ["Previon"] = 100000, ["Stallion"] = 150000, ["Solair"] = 120000, ["Glendale"] = 110000, ["Sabre"] = 190000, ["Walton"] = 100000, ["Regina"] = 110000, ["Greenwood"] = 140000, ["Nebula"] = 140000, ["Majestic"] = 150000, ["Buccaneer"] = 170000, ["Fortune"] = 110000, ["Cadrona"] = 100000, ["Clover"] = 120000, ["Salder"] = 100000, ["Intruder"] = 140000, ["Primo"] = 110000, ["Tampa"] = 120000, ["Savanna"] = 200000 },
	['D'] = {["Bravura"] = 340000, ["Sentinal"] = 400000, ["Voodoo"] = 390000, ["Bobcat"] = 310000, ["Premier"] = 420000, ["Oceanic"] = 390000, ["Hermes"] = 370000, ["Blista Compact"] = 480000, ["Elegant"] = 450000, ["Willard"] = 440000, ["Blade"] = 400000, ["Vincent"] = 330000, ["Sunrise"] = 480000, ["Merit"] = 480000, ["Tahoma"] = 340000, ["Broadway"] = 460000, ["Tornado"] = 350000, ["Emperor"] = 360000, ["Picador"] = 420000},
	['C'] = {["Moonbeam"] = 700000, ["Esperanto"] = 800000, ["Washington"] = 830000, ["Admiral"] = 810000, ["Rancher"] = 880000, ["Virgo"] = 800000, ["Feltzer"] = 920000, ["Remington"] = 760000, ["Yosemite"] = 840000, ["Windsor"] = 940000, ["Stratum"] = 910000, ["Huntley"] = 940000, ["Stafford"] = 1000000, ["Club"] = 770000, ["Phoenix"] = 750000, ["PCJ-600"] = 1000000, ["BF-400"] = 1000000, ["Wayfarer"] = 800000},
	['B'] = {["ZR-350"] = 2200000, ["Comet"] = 2400000, ["Slamvan"] = 2000000, ["Hustler"] = 1900000, ["Uranus"] = 2100000, ["Jester"] = 2200000, ["Sultan"] = 2250000, ["Elegy"] = 2200000, ["Flash"] = 2100000, ["Euros"] = 2100000, ["Alpha"] = 2000000, ["FCR-900"] = 1900000, ["Freeway"] = 2000000, ["Sanchez"] = 1900000, ["Quad"] = 2100000},
	['A'] = {["Buffalo"] = 4800000, ["Infernus"] = 6000000, ["Cheetah"] = 5600000, ["Banshee"] = 5400000, ["Turismo"] = 6000000, ["Super GT"] = 5100000, ["Bullet"] = 6000000, ["NRG-500"] = 4600000, ["Hotknife"] = 4800000, ["BF Injection"] = 5000000, ["Sandking"] = 5800000, ["Hotring Racer"] = 6000000}
}

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(0) end
    load_inifiles()
    load_picture()
    sampRegisterChatCommand(inifiles.Settings.CMD, cmd_tunhelp)
    while true do
    	wait(0)
    	doKeyCheck()
    	doDialogCheck()
    	doRender()
    end
end

function load_inifiles()
	inifiles_name = string.format("tunhelp.ini")
	local x, y = getScreenResolution()
    inifiles =
        inicfg.load(
        {
            Settings = {
            	CMD = 'tunhelp',
            	KeyDialog = 'VK_F3',
            	KeyColor1 = 'VK_B',
            	KeyColor2 = 'VK_N',
            	KeyWheel = 'VK_M',
            	KeyProc = 'VK_P',
            	Count = 1000
            },
            Size = {
            	Color1X = 600,
            	Color1Y = 600,
            	Color2X = 600,
            	Color2Y = 600,
            	WheelX = 600,
            	WheelY = 600
        	},
            Pos = {
            	Color1X = (x / 2) - (600/ 2),
            	Color1Y = (y / 2) - (600 / 2),
            	Color2X = (x / 2) - (600 / 2),
            	Color2Y = (y / 2) - (600 / 2),
            	WheelX = (x / 2) - (600 / 2),
            	WheelY = (y / 2) - (600 / 2)
        	}
        },
        inifiles_name
    )
    save_inifiles()
end

function save_inifiles()
	inicfg.save(inifiles, inifiles_name)
end

function load_picture()
    if not doesDirectoryExist(getGameDirectory() .. "\\moonloader\\resource") then
        createDirectory(getGameDirectory() .. "\\moonloader\\resource")
    end
    if not doesDirectoryExist(getGameDirectory() .. "\\moonloader\\resource\\tunhelp") then
        createDirectory(getGameDirectory() .. "\\moonloader\\resource\\tunhelp")
    end
    dn("Color1.jpg")
    dn("Color2.jpg")
    dn("Wheel.png")
    local x, y = getScreenResolution()
    texture = { 
    	Color1 = { false, renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/resource/tunhelp/Color1.jpg")}, 
    	Color2 = { false, renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/resource/tunhelp/Color2.jpg")}, 
    	Wheel = { false, renderLoadTextureFromFile(getGameDirectory() .. "/moonloader/resource/tunhelp/Wheel.png")}, 
    }
end

function dn(nam)
  	local file = getGameDirectory() .. "\\moonloader\\resource\\tunhelp\\" .. nam
    if not doesFileExist(file) then
        downloadUrlToFile(
            "https://raw.githubusercontent.com/Serhiy-Rubin/tunhelp/master/resource/" .. nam,
            file
        )
    end
end

function cmd_tunhelp(param)
	ShowDialog({1})
end

function doKeyCheck()
	if sampIsDialogActive() or sampIsChatInputActive() or sampIsCursorActive() or isSampfuncsConsoleActive() then return end
	if wasKeyPressed(vkeys[inifiles.Settings.KeyDialog]) then
		cmd_tunhelp()
	end
	if wasKeyPressed(vkeys[inifiles.Settings.KeyProc]) then
		ShowDialog({3})
	end
	local x, y = getScreenResolution()
	texture.Color1[1] = (isKeyDown(vkeys[inifiles.Settings.KeyColor1]) and true or false)
	texture.Color2[1] = (isKeyDown(vkeys[inifiles.Settings.KeyColor2]) and true or false)
	texture.Wheel[1] = (isKeyDown(vkeys[inifiles.Settings.KeyWheel]) and true or false)
end

function doDialogCheck()
	if dialog_data == nil then return end
	local result, button, list, input = sampHasDialogRespond(dialog_data.id)
	if result then
		local caption = sampGetDialogCaption()
		if caption == dialog_data.caption then
			if dialog_data.func[list + 1] ~= nil then
				dialog_data.func[list + 1](button, list, input)
			end
		end
	end
end

function doRender()
	if texture == nil then return end
	if texture.Color1[1] then
		local delta = getMousewheelDelta()
        if delta ~= 0 then
            if delta > 0 then
            	inifiles.Size.Color1X = inifiles.Size.Color1X + 10
            	inifiles.Size.Color1Y = inifiles.Size.Color1Y + 10
            else
            	inifiles.Size.Color1X = inifiles.Size.Color1X - 10
            	inifiles.Size.Color1Y = inifiles.Size.Color1Y - 10
            end
            save_inifiles()
        end
        if isKeyDown(1) then
        	sampSetCursorMode(2)
			local x, y = getCursorPos()
			inifiles.Pos.Color1X = x - (inifiles.Size.Color1X / 2)
			inifiles.Pos.Color1Y = y - (inifiles.Size.Color1Y / 2)
			save_inifiles()
		else
			sampSetCursorMode(0)
		end
		renderDrawTexture(texture.Color1[2], inifiles.Pos.Color1X, inifiles.Pos.Color1Y, inifiles.Size.Color1X, inifiles.Size.Color1Y, 0, -1)
	end
	if texture.Color2[1] then
		local delta = getMousewheelDelta()
        if delta ~= 0 then
            if delta > 0 then
            	inifiles.Size.Color2X = inifiles.Size.Color2X + 10
            	inifiles.Size.Color2Y = inifiles.Size.Color2Y + 10
            else
            	inifiles.Size.Color2X = inifiles.Size.Color2X - 10
            	inifiles.Size.Color2Y = inifiles.Size.Color2Y - 10
            end
            save_inifiles()
        end
        if isKeyDown(1) then
        	sampSetCursorMode(2)
			local x, y = getCursorPos()
			inifiles.Pos.Color2X = x - (inifiles.Size.Color2X / 2)
			inifiles.Pos.Color2Y = y - (inifiles.Size.Color2Y / 2)
			save_inifiles()
		else
			sampSetCursorMode(0)
		end
		renderDrawTexture(texture.Color2[2], inifiles.Pos.Color2X, inifiles.Pos.Color2Y, inifiles.Size.Color2X, inifiles.Size.Color2Y, 0, -1)
	end
	if texture.Wheel[1] then
		local delta = getMousewheelDelta()
        if delta ~= 0 then
            if delta > 0 then
            	inifiles.Size.WheelX = inifiles.Size.WheelX + 10
            	inifiles.Size.WheelY = inifiles.Size.WheelY + 10
            else
            	inifiles.Size.WheelX = inifiles.Size.WheelX - 10
            	inifiles.Size.WheelY = inifiles.Size.WheelY - 10
            end
            save_inifiles()
        end
        if isKeyDown(1) then
        	sampSetCursorMode(2)
			local x, y = getCursorPos()
			inifiles.Pos.WheelX = x - (inifiles.Size.WheelX / 2)
			inifiles.Pos.WheelY = y - (inifiles.Size.WheelY / 2)
			save_inifiles()
		else
			sampSetCursorMode(0)
		end
		renderDrawTexture(texture.Wheel[2], inifiles.Pos.WheelX, inifiles.Pos.WheelY, inifiles.Size.WheelX, inifiles.Size.WheelY, 0, -1)
	end
end

function ShowDialog(param)
	if param[1] == 1 then
		dialog_data = {
			id = 712,
			caption = 'TunHelp',
			text = string.format('{ff8826}>>  Цены на тюнинг {FFFFFF}[Цена за продукт: %d]\nДиски (Wheels) - %d вирт\nСпойлеры (Spoiler) - %d вирт\nЗакись азота (Nitro) - X2 - %d вирт | X5 - %d вирт | X10 - %d вирт\nБампера (Bumper) - %d вирт\nПороги (Sideskirt) - %d вирт\nВыхлопные трубы (Exhaust) - %d вирт\nГидравлика (Hydraulics) - %d вирт\nВоздухозаборники (Roof) - %d вирт\nОстальное от %d до %d вирт\n\n{ff8826}>>  Настройки{FFFFFF}\nКнопка вызова диалога: {ff8826}%s\nКнопка вызова палитры #1: {ff8826}%s\nКнопка вызова палитры #2: {ff8826}%s\nКнопка вызова всех видов дисков: {ff8826}%s\nКнопка вызова стоимости процентов: {ff8826}%s\n \n{ff8826}Для перемещения картинки - Правая Кнопка Мыши\n{ff8826}Для увеличения/уменьшения - Колёсико мыши\n \n         Автор скрипта Rubin Mods aka Serhiy_Rubin\n                  При поддержке Allon Dellon',
			inifiles.Settings.Count, (250 * inifiles.Settings.Count), (50 * inifiles.Settings.Count), (50 * inifiles.Settings.Count), (150 * inifiles.Settings.Count), (200 * inifiles.Settings.Count), (100 * inifiles.Settings.Count), (50 * inifiles.Settings.Count), (25 * inifiles.Settings.Count), (250 * inifiles.Settings.Count), (60 * inifiles.Settings.Count), (50 * inifiles.Settings.Count), (100 * inifiles.Settings.Count), inifiles.Settings.KeyDialog:gsub('VK_', ''), inifiles.Settings.KeyColor1:gsub('VK_', ''), inifiles.Settings.KeyColor2:gsub('VK_', ''), inifiles.Settings.KeyWheel:gsub('VK_', ''), inifiles.Settings.KeyProc:gsub('VK_', '')),
			func = {}
		}

		for string in string.gmatch(dialog_data.text, '[^\n]+') do
			dialog_data.func[#dialog_data.func + 1] = function(button, list, input)
				if button == 1 then
					if string:find('Цены на тюнинг') then
						ShowDialog({2})
					elseif string:find('вызова диалога') then
						SetKeyActivation('KeyDialog')
						ShowDialog({1})
					elseif string:find('вызова палитры #1') then
						SetKeyActivation('KeyColor1')
						ShowDialog({1})
					elseif string:find('вызова палитры #2') then
						SetKeyActivation('KeyColor2')
						ShowDialog({1})
					elseif string:find('всех видов дисков') then
						SetKeyActivation('KeyWheel')
						ShowDialog({1})
					elseif string:find('процентов') then
						SetKeyActivation('KeyProc')
						ShowDialog({1})
					else
						ShowDialog({1})
					end
				end
			end
		end

		sampShowDialog(dialog_data.id, dialog_data.caption, dialog_data.text, 'Выбрать', 'Закрыть', 2)
	end
	if param[1] == 2 then
		dialog_data = {
			id = 712,
			caption = 'TunHelp: Цена продуктов',
			text = string.format('{FFFFFF}Введите цену продуктов в СТО, либо откройте /tinfo чтобы скрипт узнал цену.'),
			func = {}
		}

		for string in string.gmatch(dialog_data.text, '[^\n]+') do
			dialog_data.func[#dialog_data.func + 1] = function(button, list, input)
				if button == 1 then
					if input:find('(%d+)') then
						inifiles.Settings.Count = tonumber( input:match('(%d+)') )
						save_inifiles()
						ShowDialog({1})
					else
						ShowDialog({2})
					end
				else
					ShowDialog({1})
				end
			end
		end

		sampShowDialog(dialog_data.id, dialog_data.caption, dialog_data.text, 'Выбрать', 'Назад', 1)
	end
	if param[1] == 3 then
		local array_text = {}
		for k,v in pairs(vehicle) do
			array_text[k] = ''
			for i,s in pairs(v) do
				local proc = ((s / 1000) * 12) - (((s / 1000) / 5)*2) + ((inifiles.Settings.Count - 800) * (((s / 1000) / 5) / 100))
				array_text[k] = string.format('%s%s\t%s\n', array_text[k], i, math.ceil(proc))
			end
		end
		sampShowDialog(0, 'Цены восстановления машин за процент', string.format('Цена за продукты\t%s\n%s\n \n%s\n \n%s\n \n%s\n \n%s', inifiles.Settings.Count, array_text['N'], array_text['D'], array_text['C'], array_text['B'], array_text['A']), 'Выбрать', 'Закрыть', 5)
	end
end

function SetKeyActivation(inikey)
	wait(200)
	local key = ""
	repeat
		wait(0)
		if not sampIsDialogActive() then
			sampShowDialog(0, 'TunHelp: Смена активации', "{FFFFFF}Нажмите на нужную клавишу", "Выбрать", "Назад", 0)
		end
		for k, v in pairs(vkeys) do
			if wasKeyPressed(v) and k ~= "VK_ESCAPE" and k ~= "VK_RETURN" then 
				key = k 
			end
		end
	until key ~= "" 
	inifiles.Settings[inikey] = key
	save_inifiles()
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	if text:find('Цена продукта:  (%d+)') then
		inifiles.Settings.Count = tonumber(text:match('Цена продукта:  (%d+)'))
		save_inifiles()
	end
end