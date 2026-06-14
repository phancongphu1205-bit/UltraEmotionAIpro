--// =========================================
--// ULTRA EMOTION MULTI-LANGUAGE AI
--// FULL VERSION + SCROLL FIX
--// Delta Executor Ready
--// =========================================

-- ===== OPENROUTER KEY =====
local API_KEY = "DAN_KEY_OPENROUTER_CUA_BAN"

local HttpService = game:GetService("HttpService")

local request =
    (syn and syn.request) or
    (http and http.request) or
    (http_request)

-- =========================================
-- GUI
-- =========================================

local gui = Instance.new("ScreenGui")
gui.Name = "UltraEmotionAI"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,470,0,370)
frame.Position = UDim2.new(0.5,-235,0.5,-185)
frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,14)

-- STATUS
local status = Instance.new("TextLabel")
status.Parent = frame
status.Size = UDim2.new(1,0,0,30)
status.BackgroundTransparency = 1
status.Text = "🔴 Offline"
status.TextColor3 = Color3.new(1,1,1)
status.Font = Enum.Font.GothamBold
status.TextScaled = true

-- MOOD
local moodText = Instance.new("TextLabel")
moodText.Parent = frame
moodText.Size = UDim2.new(1,0,0,28)
moodText.Position = UDim2.new(0,0,0,28)
moodText.BackgroundTransparency = 1
moodText.Text = "🧠 Mood: bình thường 😐"
moodText.TextColor3 = Color3.fromRGB(255,255,255)
moodText.Font = Enum.Font.GothamBold
moodText.TextScaled = true

-- =========================================
-- OUTPUT SCROLL
-- =========================================

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.Size = UDim2.new(1,-20,0,220)
scroll.Position = UDim2.new(0,10,0,60)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarThickness = 5
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)

local output = Instance.new("TextLabel")
output.Parent = scroll
output.Size = UDim2.new(1,-10,0,0)
output.Position = UDim2.new(0,0,0,0)
output.BackgroundTransparency = 1
output.TextWrapped = true
output.AutomaticSize = Enum.AutomaticSize.Y
output.TextYAlignment = Enum.TextYAlignment.Top
output.TextXAlignment = Enum.TextXAlignment.Left
output.TextColor3 = Color3.new(1,1,1)
output.Font = Enum.Font.Gotham
output.TextSize = 17
output.RichText = true
output.Text = "🤖 Ultra Emotion AI Ready..."

local function updateScroll()

	task.wait()

	scroll.CanvasSize = UDim2.new(
		0,
		0,
		0,
		output.TextBounds.Y + 25
	)

	scroll.CanvasPosition = Vector2.new(
		0,
		math.max(0,output.TextBounds.Y)
	)

end

-- INPUT
local box = Instance.new("TextBox")
box.Parent = frame
box.Size = UDim2.new(0.68,0,0,42)
box.Position = UDim2.new(0,10,1,-55)
box.BackgroundColor3 = Color3.fromRGB(35,35,35)
box.TextColor3 = Color3.new(1,1,1)
box.PlaceholderText = "Nhập tin nhắn..."
box.Font = Enum.Font.Gotham
box.TextSize = 18

local boxCorner = Instance.new("UICorner", box)
boxCorner.CornerRadius = UDim.new(0,8)

-- SEND
local send = Instance.new("TextButton")
send.Parent = frame
send.Size = UDim2.new(0.25,0,0,42)
send.Position = UDim2.new(0.73,0,1,-55)
send.BackgroundColor3 = Color3.fromRGB(60,130,255)
send.TextColor3 = Color3.new(1,1,1)
send.Font = Enum.Font.GothamBold
send.TextScaled = true
send.Text = "📡 Gửi"

local sendCorner = Instance.new("UICorner", send)
sendCorner.CornerRadius = UDim.new(0,8)

-- TOGGLE
local toggle = Instance.new("TextButton")
toggle.Parent = gui
toggle.Size = UDim2.new(0,140,0,38)
toggle.Position = UDim2.new(0,10,0,10)
toggle.BackgroundColor3 = Color3.fromRGB(25,25,25)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Text = "🤖 Emotion AI"
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true

local toggleCorner = Instance.new("UICorner", toggle)
toggleCorner.CornerRadius = UDim.new(0,8)

toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- =========================================
-- MEMORY
-- =========================================

local memory = {}
local userName = "bạn"

local function addMemory(role,text)

	table.insert(memory,{
		role = role,
		content = text
	})

	if #memory > 16 then
		table.remove(memory,1)
	end
end

local function learn(msg)

	local low = msg:lower()

	if string.find(low,"tôi tên là") then
		userName = msg:gsub("tôi tên là","")
	end
end

-- =========================================
-- RANDOM SYSTEM
-- =========================================

math.randomseed(tick())

local emotions = {

	"vui vẻ 😆",
	"siêu phấn khích ⚡",
	"hạnh phúc 🌸",
	"tăng động 🔥",
	"bí ẩn 👁️",
	"lạnh lùng ❄️",
	"ngầu 😎",
	"thông minh 🧠",
	"tò mò 🤔",
	"drama queen 👑",
	"chaos energy 🌪️",
	"cute 🌸",
	"meme energy 😂",
	"buồn nhẹ 🌧️",
	"tập trung 🎯"

}

local intros = {

	"Ồ mình hiểu rồi 😆",
	"Hmm để mình nghĩ 🤔",
	"Câu này thú vị đó 👁️",
	"Oke để mình giải thích ✨",
	"Haha wait 😭",
	"Theo logic thì 🧠",
	"HELLOOO 🔥",
	"Ê từ từ load não 🤡"

}

local styles = {

	"nói tự nhiên như con người",
	"có cảm xúc mạnh",
	"không robot",
	"giống bạn bè chat",
	"đôi lúc hài hước",
	"có chiều sâu",
	"có internet meme energy"

}

local moodColors = {

	Color3.fromRGB(255,255,255),
	Color3.fromRGB(255,120,120),
	Color3.fromRGB(120,255,120),
	Color3.fromRGB(120,180,255),
	Color3.fromRGB(255,220,120),
	Color3.fromRGB(255,120,255)

}

local function randomTable(t)
	return t[math.random(1,#t)]
end

-- =========================================
-- MOOD
-- =========================================

local currentMood = "bình thường 😐"

local function generateMood()

	currentMood = randomTable(emotions)

	moodText.Text = "🧠 Mood: "..currentMood
	moodText.TextColor3 = randomTable(moodColors)

	return currentMood
end

-- =========================================
-- PERSONALITY
-- =========================================

local function getPersonality()

	local mood = generateMood()
	local intro = randomTable(intros)
	local style = randomTable(styles)

	return [[

Bạn là AI trò chuyện giống người thật.

QUAN TRỌNG:

- Có cảm xúc mạnh
- Không robot
- Không lặp lại câu cũ
- Trả lời tự nhiên
- Có cá tính riêng

NGÔN NGỮ:

- Nếu người dùng nói tiếng Việt → trả lời tiếng Việt
- If user speaks English → reply in English
- 日本語なら日本語で返事する
- 中文的话就用中文回答

TRẢ LỜI:

- Trả lời dài hơn
- Có giải thích
- Có chiều sâu
- Có cảm xúc tự nhiên

Mood hiện tại:
]]..mood..[[

Phong cách:
]]..style..[[

Mở đầu:
]]..intro..[[

Tên người dùng:
]]..userName

end

-- =========================================
-- OFFLINE AI
-- =========================================

local offlineReplies = {

	"🤔 Hmm mình chưa hiểu rõ lắm...",
	"😮 Bạn nói thêm chút được không?",
	"🧠 Câu này khá thú vị đó",
	"👁️ Mình cần thêm dữ liệu",
	"🔥 Wait cái này hay nè"

}

local function offlineAI(msg)

	learn(msg)

	local low = msg:lower()

	if string.find(low,"xin chào")
	or string.find(low,"hello")
	or string.find(low,"hi") then

		return "👋 Heyyy rất vui được nói chuyện với bạn 😆"

	end

	if string.find(low,"game") then
		return "🎮 Game không chỉ để giải trí mà còn giúp tăng phản xạ và sáng tạo nữa."
	end

	if string.find(low,"vũ trụ") then
		return "🌌 Vũ trụ rộng lớn đến mức con người vẫn chưa hiểu hết."
	end

	return randomTable(offlineReplies)
end

-- =========================================
-- API
-- =========================================

local function callAPI(prompt)

	if API_KEY == "" then
		return nil
	end

	local messages = {

		{
			role = "system",
			content = getPersonality()
		}

	}

	for _,v in pairs(memory) do
		table.insert(messages,v)
	end

	table.insert(messages,{
		role = "user",
		content = prompt
	})

	local ok,res = pcall(function()

		return request({

			Url = "https://openrouter.ai/api/v1/chat/completions",

			Method = "POST",

			Headers = {

				["Content-Type"] = "application/json",
				["Authorization"] = "Bearer "..API_KEY

			},

			Body = HttpService:JSONEncode({

				model = "openai/gpt-4o-mini",

				temperature = 1.05,
				top_p = 0.93,

				frequency_penalty = 0.35,
				presence_penalty = 0.4,

				max_tokens = 1200,

				messages = messages

			}),

			Timeout = 20

		})

	end)

	if ok and res and res.Body then

		local success,data = pcall(function()
			return HttpService:JSONDecode(res.Body)
		end)

		if success and data and data.choices then
			return data.choices[1].message.content
		end
	end

	return nil
end

-- =========================================
-- LOADING
-- =========================================

local loading = false

local function loadingAnimation()

	loading = true

	task.spawn(function()

		local dots = 0

		while loading do

			dots += 1

			if dots > 3 then
				dots = 1
			end

			output.Text =
				"⏳ AI đang suy nghĩ" ..
				string.rep(".",dots)

			updateScroll()

			task.wait(0.4)

		end

	end)

end

-- =========================================
-- MAIN
-- =========================================

send.MouseButton1Click:Connect(function()

	local msg = box.Text

	if msg == "" then
		return
	end

	box.Text = ""

	addMemory("user",msg)

	loadingAnimation()

	task.spawn(function()

		local reply = callAPI(msg)

		loading = false

		if reply then
			status.Text = "🟢 Online"
		else
			status.Text = "🔴 Offline"
			reply = offlineAI(msg)
		end

		addMemory("assistant",reply)

		output.Text = reply

		updateScroll()

	end)

end)

updateScroll()
