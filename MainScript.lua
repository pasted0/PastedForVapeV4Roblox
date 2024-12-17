repeat task.wait() until game:IsLoaded()
local GuiLibrary
local baseDirectory = (shared.VapePrivate and "vapeprivate/" or "vape/")
local vapeInjected = true
local oldRainbow = false
local errorPopupShown = false
local redownloadedAssets = false
local profilesLoaded = false
local teleportedServers = false
local gameCamera = workspace.CurrentCamera
local textService = game:GetService("TextService")
local playersService = game:GetService("Players")
local inputService = game:GetService("UserInputService")
local isfile = isfile or function(file)
        local suc, res = pcall(function() return readfile(file) end)
        return suc and res ~= nil
end
local setidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end
local getidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 0 end
local vapeAssetTable = {
        ["vape/assets/AddItem.png"] = "rbxassetid://13350763121",
        ["vape/assets/AddRemoveIcon1.png"] = "rbxassetid://13350764147",
        ["vape/assets/ArrowIndicator.png"] = "rbxassetid://13350766521",
        ["vape/assets/BackIcon.png"] = "rbxassetid://13350767223",
        ["vape/assets/BindBackground.png"] = "rbxassetid://13350767577",
        ["vape/assets/BlatantIcon.png"] = "rbxassetid://13350767943",
        ["vape/assets/CircleListBlacklist.png"] = "rbxassetid://13350768647",
        ["vape/assets/CircleListWhitelist.png"] = "rbxassetid://13350769066",
        ["vape/assets/ColorSlider1.png"] = "rbxassetid://13350769439",
        ["vape/assets/ColorSlider2.png"] = "rbxassetid://13350769842",
        ["vape/assets/CombatIcon.png"] = "rbxassetid://13350770192",
        ["vape/assets/DownArrow.png"] = "rbxassetid://13350770749",
        ["vape/assets/ExitIcon1.png"] = "rbxassetid://13350771140",
        ["vape/assets/FriendsIcon.png"] = "rbxassetid://13350771464",
        ["vape/assets/HoverArrow.png"] = "rbxassetid://13350772201",
        ["vape/assets/HoverArrow2.png"] = "rbxassetid://13350772588",
        ["vape/assets/HoverArrow3.png"] = "rbxassetid://13350773014",
        ["vape/assets/HoverArrow4.png"] = "rbxassetid://13350773643",
        ["vape/assets/InfoNotification.png"] = "rbxassetid://13350774006",
        ["vape/assets/KeybindIcon.png"] = "rbxassetid://13350774323",
        ["vape/assets/LegitModeIcon.png"] = "rbxassetid://13436400428",
        ["vape/assets/MoreButton1.png"] = "rbxassetid://13350775005",
        ["vape/assets/MoreButton2.png"] = "rbxassetid://13350775731",
        ["vape/assets/MoreButton3.png"] = "rbxassetid://13350776241",
        ["vape/assets/NotificationBackground.png"] = "rbxassetid://13350776706",
        ["vape/assets/NotificationBar.png"] = "rbxassetid://13350777235",
        ["vape/assets/OnlineProfilesButton.png"] = "rbxassetid://13350777717",
        ["vape/assets/PencilIcon.png"] = "rbxassetid://13350778187",
        ["vape/assets/PinButton.png"] = "rbxassetid://13350778654",
        ["vape/assets/ProfilesIcon.png"] = "rbxassetid://13350779149",
        ["vape/assets/RadarIcon1.png"] = "rbxassetid://13350779545",
        ["vape/assets/RadarIcon2.png"] = "rbxassetid://13350779992",
        ["vape/assets/RainbowIcon1.png"] = "rbxassetid://13350780571",
        ["vape/assets/RainbowIcon2.png"] = "rbxassetid://13350780993",
        ["vape/assets/RightArrow.png"] = "rbxassetid://13350781908",
        ["vape/assets/SearchBarIcon.png"] = "rbxassetid://13350782420",
        ["vape/assets/SettingsWheel1.png"] = "rbxassetid://13350782848",
        ["vape/assets/SettingsWheel2.png"] = "rbxassetid://13350783258",
        ["vape/assets/SliderArrow1.png"] = "rbxassetid://13350783794",
        ["vape/assets/SliderArrowSeperator.png"] = "rbxassetid://13350784477",
        ["vape/assets/SliderButton1.png"] = "rbxassetid://13350785680",
        ["vape/assets/TargetIcon.png"] = "rbxassetid://13350786128",
        ["vape/assets/TargetIcon1.png"] = "rbxassetid://13350786776",
        ["vape/assets/TargetIcon2.png"] = "rbxassetid://13350787228",
        ["vape/assets/TargetIcon3.png"] = "rbxassetid://13350787729",
        ["vape/assets/TargetIcon4.png"] = "rbxassetid://13350788379",
        ["vape/assets/TargetInfoIcon1.png"] = "rbxassetid://13350788860",
        ["vape/assets/TargetInfoIcon2.png"] = "rbxassetid://13350789239",
        ["vape/assets/TextBoxBKG.png"] = "rbxassetid://13350789732",
        ["vape/assets/TextBoxBKG2.png"] = "rbxassetid://13350790229",
        ["vape/assets/TextGUIIcon1.png"] = "rbxassetid://13350790634",
        ["vape/assets/TextGUIIcon2.png"] = "rbxassetid://13350791175",
        ["vape/assets/TextGUIIcon3.png"] = "rbxassetid://13350791758",
        ["vape/assets/TextGUIIcon4.png"] = "rbxassetid://13350792279",
        ["vape/assets/ToggleArrow.png"] = "rbxassetid://13350792786",
        ["vape/assets/UpArrow.png"] = "rbxassetid://13350793386",
        ["vape/assets/UtilityIcon.png"] = "rbxassetid://13350793918",
        ["vape/assets/WarningNotification.png"] = "rbxassetid://13350794868",
        ["vape/assets/WindowBlur.png"] = "rbxassetid://13350795660",
        ["vape/assets/WorldIcon.png"] = "rbxassetid://13350796199",
        ["vape/assets/VapeIcon.png"] = "rbxassetid://13350808582",
        ["vape/assets/RenderIcon.png"] = "rbxassetid://13350832775",
        ["vape/assets/VapeLogo1.png"] = "rbxassetid://13350860863",
        ["vape/assets/VapeLogo3.png"] = "rbxassetid://13350872035",
        ["vape/assets/VapeLogo2.png"] = "rbxassetid://13350876307",
        ["vape/assets/VapeLogo4.png"] = "rbxassetid://13350877564"
}
if inputService:GetPlatform() ~= Enum.Platform.Windows then
        --mobile exploit fix
        getgenv().getsynasset = nil
        getgenv().getcustomasset = nil
        -- why is this needed
        getsynasset = nil
        getcustomasset = nil
end
local getcustomasset = getsynasset or getcustomasset or function(location) return vapeAssetTable[location] or "" end
local customassetcheck = (getsynasset or getcustomasset) and true
local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
local delfile = delfile or function(file) writefile(file, "") end

local function displayErrorPopup(text, funclist)
        local oldidentity = getidentity()
        setidentity(8)
        local ErrorPrompt = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.ErrorPrompt)
        local prompt = ErrorPrompt.new("Default")
        prompt._hideErrorCode = true
        local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        prompt:setErrorTitle("Vape")
        local funcs
        if funclist then
                funcs = {}
                local num = 0
                for i,v in pairs(funclist) do
                        num = num + 1
                        table.insert(funcs, {
                                Text = i,
                                Callback = function()
                                        prompt:_close()
                                        v()
                                end,
                                Primary = num == #funclist
                        })
                end
        end
        prompt:updateButtons(funcs or {{
                Text = "OK",
                Callback = function()
                        prompt:_close()
                end,
                Primary = true
        }}, 'Default')
        prompt:setParent(gui)
        prompt:_open(text)
        setidentity(oldidentity)
end

local function vapeGithubRequest(scripturl)
        if not isfile("vape/"..scripturl) then
                local suc, res
                task.delay(15, function()
                        if not res and not errorPopupShown then
                                errorPopupShown = true
                                displayErrorPopup("The connection to github is taking a while, Please be patient.")
                        end
                end)
                suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/Pasted0/PastedForVapeV4Roblox/"..readfile("vape/commithash.txt").."/"..scripturl, true) end)
                if not suc or res == "404: Not Found" then
                        displayErrorPopup("Failed to connect to github : vape/"..scripturl.." : "..res)
                        error(res)
                end
                if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
                writefile("vape/"..scripturl, res)
        end
        return readfile("vape/"..scripturl)
end

local function downloadVapeAsset(path)
        if customassetcheck then
                if not isfile(path) then
                        task.spawn(function()
                                local textlabel = Instance.new("TextLabel")
                                textlabel.Size = UDim2.new(1, 0, 0, 36)
                                textlabel.Text = "Downloading "..path
                                textlabel.BackgroundTransparency = 1
                                textlabel.TextStrokeTransparency = 0
                                textlabel.TextSize = 30
                                textlabel.Font = Enum.Font.SourceSans
                                textlabel.TextColor3 = Color3.new(1, 1, 1)
                                textlabel.Position = UDim2.new(0, 0, 0, -36)
                                textlabel.Parent = GuiLibrary.MainGui
                                repeat task.wait() until isfile(path)
                                textlabel:Destroy()
                        end)
                        local suc, req = pcall(function() return vapeGithubRequest(path:gsub("vape/assets", "assets")) end)
                        if suc and req then
                                writefile(path, req)
                        else
                                return ""
                        end
                end
        end
        return getcustomasset(path)
end

assert(not shared.VapeExecuted, "Vape Already Injected")
shared.VapeExecuted = true

for i,v in pairs({baseDirectory:gsub("/", ""), "vape", "vape/Libraries", "vape/CustomModules", "vape/Profiles", baseDirectory.."Profiles", "vape/assets"}) do
        if not isfolder(v) then makefolder(v) end
end
task.spawn(function()
        local success, assetver = pcall(function() return vapeGithubRequest("assetsversion.txt") end)
        if not isfile("vape/assetsversion.txt") then writefile("vape/assetsversion.txt", "0") end
        if success and assetver > readfile("vape/assetsversion.txt") then
                redownloadedAssets = true
                if isfolder("vape/assets") and not shared.VapeDeveloper then
                        if delfolder then
                                delfolder("vape/assets")
                                makefolder("vape/assets")
                        end
                end
                writefile("vape/assetsversion.txt", assetver)
        end
end)
if not isfile("vape/CustomModules/cachechecked.txt") then
        local isNotCached = false
        for i,v in pairs({"vape/Universal.lua", "vape/MainScript.lua", "vape/GuiLibrary.lua"}) do
                if isfile(v) and not readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                        isNotCached = true
                end
        end
        if isfolder("vape/CustomModules") then
                for i,v in pairs(listfiles("vape/CustomModules")) do
                        if isfile(v) and not readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                                isNotCached = true
                        end
                end
        end
        if isNotCached and not shared.VapeDeveloper then
                displayErrorPopup("Vape has detected uncached files, If you have CustomModules click no, else click yes.", {No = function() end, Yes = function()
                        for i,v in pairs({"vape/Universal.lua", "vape/MainScript.lua", "vape/GuiLibrary.lua"}) do
                                if isfile(v) and not readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                                        delfile(v)
                                end
                        end
                        for i,v in pairs(listfiles("vape/CustomModules")) do
                                if isfile(v) and not readfile(v):find("--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.") then
                                        local last = v:split('\\')
                                        last = last[#last]
                                        local suc, publicrepo = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/Pasted0/PastedForVapeV4Roblox/"..readfile("vape/commithash.txt").."/CustomModules/"..last) end)
                                        if suc and publicrepo and publicrepo ~= "404: Not Found" then
                                                writefile("vape/CustomModules/"..last, "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..publicrepo)
                                        end
                                end
                        end
                end})
        end
        writefile("vape/CustomModules/cachechecked.txt", "verified")
end

GuiLibrary = loadstring(vapeGithubRequest("GuiLibrary.lua"))()
shared.GuiLibrary = GuiLibrary

local saveSettingsLoop = coroutine.create(function()
        if inputService.TouchEnabled then return end
        repeat
                GuiLibrary.SaveSettings()
        task.wait(10)
        until not vapeInjected or not GuiLibrary
end)

task.spawn(function()
        local image = Instance.new("ImageLabel")
        image.Image = downloadVapeAsset("vape/assets/CombatIcon.png")
        image.Position = UDim2.new()
        image.BackgroundTransparency = 1
        image.Size = UDim2.fromOffset(100, 100)
        image.ImageTransparency = 0.999
        image.Parent = GuiLibrary.MainGui
    image:GetPropertyChangedSignal("IsLoaded"):Connect(function()
        image:Destroy()
        image = nil
    end)
        task.spawn(function()
                task.wait(15)
                if image and image.ContentImageSize == Vector2.zero and (not errorPopupShown) and (not redownloadedAssets) and (not isfile("vape/assets/check3.txt")) then
            errorPopupShown = true
            displayErrorPopup("Assets failed to load, Try another executor (executor : "..(identifyexecutor and identifyexecutor() or "Unknown")..")", {OK = function()
                writefile("vape/assets/check3.txt", "")
            end})
        end
        end)
end)

local GUI = GuiLibrary.CreateMainWindow()
local Combat = GuiLibrary.CreateWindow({
        Name = "Combat",
        Icon = "vape/assets/CombatIcon.png",
        IconSize = 15
})
local Blatant = GuiLibrary.CreateWindow({
        Name = "Blatant",
        Icon = "vape/assets/BlatantIcon.png",
        IconSize = 16
})
local Render = GuiLibrary.CreateWindow({
        Name = "Render",
        Icon = "vape/assets/RenderIcon.png",
        IconSize = 17
})
local Utility = GuiLibrary.CreateWindow({
        Name = "Utility",
        Icon = "vape/assets/UtilityIcon.png",
        IconSize = 17
})
local World = GuiLibrary.CreateWindow({
        Name = "World",
        Icon = "vape/assets/WorldIcon.png",
        IconSize = 16
})
local Friends = GuiLibrary.CreateWindow2({
        Name = "Friends",
        Icon = "vape/assets/FriendsIcon.png",
        IconSize = 17
})
local Targets = GuiLibrary.CreateWindow2({
        Name = "Targets",
        Icon = "vape/assets/FriendsIcon.png",
        IconSize = 17
})
local Profiles = GuiLibrary.CreateWindow2({
        Name = "Profiles",
        Icon = "vape/assets/ProfilesIcon.png",
        IconSize = 19
})
GUI.CreateDivider()
GUI.CreateButton({
        Name = "Combat",
        Function = function(callback) Combat.SetVisible(callback) end,
        Icon = "vape/assets/CombatIcon.png",
        IconSize = 15
})
GUI.CreateButton({
        Name = "Blatant",
        Function = function(callback) Blatant.SetVisible(callback) end,
        Icon = "vape/assets/BlatantIcon.png",
        IconSize = 16
})
GUI.CreateButton({
        Name = "Render",
        Function = function(callback) Render.SetVisible(callback) end,
        Icon = "vape/assets/RenderIcon.png",
        IconSize = 17
})
GUI.CreateButton({
        Name = "Utility",
        Function = function(callback) Utility.SetVisible(callback) end,
        Icon = "vape/assets/UtilityIcon.png",
        IconSize = 17
})
GUI.CreateButton({
        Name = "World",
        Function = function(callback) World.SetVisible(callback) end,
        Icon = "vape/assets/WorldIcon.png",
        IconSize = 16
})
GUI.CreateDivider("MISC")
GUI.CreateButton({
        Name = "Friends",
        Function = function(callback) Friends.SetVisible(callback) end,
})
GUI.CreateButton({
        Name = "Targets",
        Function = function(callback) Targets.SetVisible(callback) end,
})
GUI.CreateButton({
        Name = "Profiles",
        Function = function(callback) Profiles.SetVisible(callback) end,
})

local FriendsTextListTable = {
        Name = "FriendsList",
        TempText = "Username [Alias]",
        Color = Color3.fromRGB(5, 133, 104)
}
local FriendsTextList = Friends.CreateCircleTextList(FriendsTextListTable)
FriendsTextList.FriendRefresh = Instance.new("BindableEvent")
FriendsTextList.FriendColorRefresh = Instance.new("BindableEvent")
local TargetsTextList = Targets.CreateCircleTextList({
        Name = "TargetsList",
        TempText = "Username [Alias]",
        Color = Color3.fromRGB(5, 133, 104)
})
local oldFriendRefresh = FriendsTextList.RefreshValues
FriendsTextList.RefreshValues = function(...)
        FriendsTextList.FriendRefresh:Fire()
        return oldFriendRefresh(...)
end
local oldTargetRefresh = TargetsTextList.RefreshValues
TargetsTextList.RefreshValues = function(...)
        FriendsTextList.FriendRefresh:Fire()
        return oldTargetRefresh(...)
end
Friends.CreateToggle({
        Name = "Use Friends",
        Function = function(callback)
                FriendsTextList.FriendRefresh:Fire()
        end,
        Default = true
})
Friends.CreateToggle({
        Name = "Use Alias",
        Function = function(callback) end,
        Default = true,
})
Friends.CreateToggle({
        Name = "Spoof alias",
        Function = function(callback) end,
})
local friendRecolorToggle = Friends.CreateToggle({
        Name = "Recolor visuals",
        Function = function(callback) FriendsTextList.FriendColorRefresh:Fire() end,
        Default = true
})
local friendWindowFrame
Friends.CreateColorSlider({
        Name = "Friends Color",
        Function = function(h, s, v)
                local cachedColor = Color3.fromHSV(h, s, v)
                local addCircle = FriendsTextList.Object:FindFirstChild("AddButton", true)
                if addCircle then
                        addCircle.ImageColor3 = cachedColor
                end
                friendWindowFrame = friendWindowFrame or FriendsTextList.ScrollingObject and FriendsTextList.ScrollingObject:FindFirstChild("ScrollingFrame")
                if friendWindowFrame then
                        for i,v in pairs(friendWindowFrame:GetChildren()) do
                                local friendCircle = v:FindFirstChild("FriendCircle")
                                local friendText = v:FindFirstChild("ItemText")
                                if friendCircle and friendText then
                                        friendCircle.Background