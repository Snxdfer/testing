--// Nurysium last build  💖
--// [FIXED] All bugs annotated with --[FIX N]

local RobloxReplicatedStorage = cloneref(game:GetService('RobloxReplicatedStorage'))
local RbxAnalyticsService     = cloneref(game:GetService('RbxAnalyticsService'))
local ReplicatedStorage       = cloneref(game:GetService('ReplicatedStorage'))
local UserInputService        = cloneref(game:GetService('UserInputService'))
local NetworkClient           = cloneref(game:GetService("NetworkClient"))
local TweenService            = cloneref(game:GetService('TweenService'))
local VirtualUser             = cloneref(game:GetService('VirtualUser'))
local HttpService             = cloneref(game:GetService('HttpService'))
local RunService              = cloneref(game:GetService('RunService'))
local LogService              = cloneref(game:GetService('LogService'))
local Lighting                = cloneref(game:GetService('Lighting'))
local CoreGui                 = cloneref(game:GetService('CoreGui'))
local Players                 = cloneref(game:GetService('Players'))
local Debris                  = cloneref(game:GetService('Debris'))
local Stats                   = cloneref(game:GetService('Stats'))

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local crypter = loadstring(game:HttpGet('https://raw.githubusercontent.com/Egor-Skriptunoff/pure_lua_SHA/master/sha2.lua', true))()
local notify  = loadstring(game:HttpGet('https://raw.githubusercontent.com/flezzpe/Nurysium/main/notify_UI.lua'))()

notify.__init({ parent = cloneref(game:GetService('CoreGui')) })

setfpscap(200)

local LocalPlayer = Players.LocalPlayer
local client_id   = RbxAnalyticsService:GetClientId()

local names_map = {
    ['protected'] = crypter.sha3_384(client_id,              'sha3-256'),
    ['Pillow']    = crypter.sha3_384(client_id .. 'Pillow',  'sha3-256'),
    ['Touhou']    = crypter.sha3_384(client_id .. 'Touhou',  'sha3-256'),
    ['Shion']     = crypter.sha3_384(client_id .. 'Shion',   'sha3-256'),
    ['Miku']      = crypter.sha3_384(client_id .. 'Miku',    'sha3-256'),
    ['Sino']      = crypter.sha3_384(client_id .. 'Sino',    'sha3-256'),
    ['Soi']       = crypter.sha3_384(client_id .. 'Soi',     'sha3-256'),
}

local interface = loadstring(game:HttpGet('https://raw.githubusercontent.com/flezzpe/EvadeAutoBHOP/main/libs/ef.java'))()

local Assets  = game:GetObjects("rbxassetid://80458844232530")[1]
Assets.Parent = RobloxReplicatedStorage
Assets.Name   = names_map["protected"]

local effects_folder  = Assets:WaitForChild("effects")
local sounds_folder   = effects_folder:WaitForChild("sounds")
local plushes_folder  = effects_folder:WaitForChild("plushes")
local skyboxes_folder = effects_folder:WaitForChild("skyboxes")

local HitEffect   = effects_folder:WaitForChild("HitEffect")
local ObjectBeam  = effects_folder:WaitForChild("ObjectBeam")
local ObjectTrail = effects_folder:WaitForChild("ObjectTrail")
local JumpCircle  = effects_folder:WaitForChild("JumpCircle")

--[FIX 1] gui_folder nunca fue definido → watermark viene de Assets directamente
local watermark_asset = Assets:FindFirstChild("watermark")
local watermark       = watermark_asset and watermark_asset:Clone()

--[FIX 2] 'assets' (lowercase) no existe → es 'Assets' (capital A)
local color_shift_effect        = Instance.new('ColorCorrectionEffect')
color_shift_effect.Parent       = Assets

local RunTime = workspace.Runtime
local Alive   = workspace.Alive
local Dead    = workspace.Dead

-- ────────────────────────────── Tables ────────────────────────────────

local AutoParry = { ball = nil, target = nil, entity_properties = nil }

local Player = {
    Entity     = nil,
    properties = { grab_animation = nil },
}

Player.Entity = {
    properties = {
        sword           = '',
        server_position = Vector3.zero,
        velocity        = Vector3.zero,
        position        = Vector3.zero,
        is_moving       = false,
        speed           = 0,
        ping            = 0,
    }
}

local World = {}

AutoParry.ball = {
    training_ball_entity = nil,
    client_ball_entity   = nil,
    ball_entity          = nil,
    properties = {
        aero_dynamic_time   = tick(),
        hell_hook_completed = true,
        last_position       = Vector3.zero,
        last_curve_position = Vector3.zero,  --[FIX 3] campo referenciado pero nunca inicializado
        rotation            = Vector3.zero,
        position            = Vector3.zero,
        last_warping        = tick(),
        parry_remote        = nil,
        is_curved           = false,
        last_tick           = tick(),
        auto_spam           = false,
        cooldown            = false,
        respawn_time        = 0,
        parry_range         = 0,
        spam_range          = 0,
        maximum_speed       = 0,
        old_speed           = 0,
        parries             = 0,
        direction           = 0,
        distance            = 0,
        velocity            = 0,
        last_hit            = 0,
        lerp_radians        = 0,
        radians             = 0,
        speed               = 0,
        dot                 = 0,
    }
}

AutoParry.target = { current = nil, from = nil, aim = nil }

AutoParry.entity_properties = {
    server_position = Vector3.zero,
    velocity        = Vector3.zero,
    is_moving       = false,
    direction       = 0,
    distance        = 0,
    speed           = 0,
    dot             = 0,
}

-- ─────────────────────────── create_animation ─────────────────────────

--[FIX 4] La versión original bloqueaba el hilo llamador con task.wait(info.Time)
-- y después de Debris:AddItem llamaba Destroy() (redundante).
-- Ahora: cancela el tween anterior sobre el mismo objeto para evitar conflictos
-- acumulados, y la limpieza ocurre en un task.spawn separado sin bloquear.
local active_tweens = {}

function create_animation(object: Instance, info: TweenInfo, value: table)
    if active_tweens[object] then
        active_tweens[object]:Cancel()
        active_tweens[object] = nil
    end

    local anim           = TweenService:Create(object, info, value)
    active_tweens[object] = anim
    anim:Play()

    task.spawn(function()
        anim.Completed:Wait()
        if active_tweens[object] == anim then
            active_tweens[object] = nil
        end
        Debris:AddItem(anim, 0)
    end)
end

-- ─────────────────────────── ConnectionsManager ───────────────────────

local ConnectionsManager = {}

--[FIX 5] El método original definía :disconnect() con ':', lo que hacía
-- que self = la key string cuando se llamaba como .disconnect('key').
-- Se convierte en función regular con parámetro explícito para mayor claridad.
function ConnectionsManager.disconnect(key: string)
    if not ConnectionsManager[key] then return end
    ConnectionsManager[key]:Disconnect()
    ConnectionsManager[key] = nil
end

function ConnectionsManager.abadone()
    interface.flags = {}

    for key, connection in ConnectionsManager do
        if typeof(connection) == 'function' then continue end
        connection:Disconnect()
        ConnectionsManager[key] = nil
    end
end

ConnectionsManager['controller'] = RunService.Heartbeat:Connect(function()
    if not interface.disconnected then return end
    ConnectionsManager.abadone()
end)

-- ─────────────────────────── Utilities ────────────────────────────────

local function linear_predict(a: any, b: any, t: number)
    return a + (b - a) * t
end

function World.get_pointer()
    local ml  = UserInputService:GetMouseLocation()
    local ray = workspace.CurrentCamera:ScreenPointToRay(ml.X, ml.Y, 0)
    return CFrame.lookAt(ray.Origin, ray.Origin + ray.Direction)
end

function AutoParry.get_ball()
    for _, ball in workspace.Balls:GetChildren() do
        if ball:GetAttribute("realBall") then return ball end
    end
end

function AutoParry.get_client_ball()
    for _, ball in workspace.Balls:GetChildren() do
        if not ball:GetAttribute("realBall") then return ball end
    end
end

function Player.get_aim_entity()
    local closest_entity   = nil
    local min_dot          = -math.huge
    local camera_direction = workspace.CurrentCamera.CFrame.LookVector

    for _, player in Alive:GetChildren() do
        if not player or player.Name == LocalPlayer.Name then continue end
        if not player:FindFirstChild('HumanoidRootPart') then continue end

        local dir = (player.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).Unit
        local dot = camera_direction:Dot(dir)

        if dot > min_dot then
            min_dot        = dot
            closest_entity = player
        end
    end

    return closest_entity
end

function Player.get_closest_player_to_cursor()
    local closest_player = nil
    local min_dot        = -math.huge

    for _, player in workspace.Alive:GetChildren() do
        if player == LocalPlayer.Character then continue end
        if player.Parent ~= Alive then continue end
        if not player.PrimaryPart then continue end

        local dir     = (player.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Unit
        local pointer = World.get_pointer()
        local dot     = pointer.LookVector:Dot(dir)

        if dot > min_dot then
            min_dot        = dot
            closest_player = player
        end
    end

    return closest_player
end

function AutoParry.get_parry_remote()
    for _, object in {cloneref(game:GetService('VirtualInputManager'))} do
        local temp_remote = object:FindFirstChildOfClass('RemoteEvent')
        if not temp_remote then continue end
        if not temp_remote.Name:find('\n') then continue end
        AutoParry.ball.properties.parry_remote = temp_remote
    end
end

AutoParry.get_parry_remote()

function AutoParry.perform_grab_animation()
    local animation          = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild('GrabParry')
    local currently_equipped = Player.Entity.properties.sword

    if not currently_equipped or currently_equipped == 'Titan Blade' then return end
    if not animation then return end

    local sword_data = ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(currently_equipped)
    if not sword_data or not sword_data['AnimationType'] then return end

    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild('Humanoid') then return end

    for _, object in ReplicatedStorage.Shared.SwordAPI.Collection:GetChildren() do
        if object.Name ~= sword_data['AnimationType'] then continue end
        if not (object:FindFirstChild('GrabParry') or object:FindFirstChild('Grab')) then continue end

        --[FIX 6] 'object[type]' usaba la función built-in type() de Lua como key
        -- → debe ser object[sword_animation_type]
        local sword_animation_type = object:FindFirstChild('Grab') and 'Grab' or 'GrabParry'
        animation = object[sword_animation_type]
    end

    if not animation then return end

    Player.properties.grab_animation = character.Humanoid:LoadAnimation(animation)
    Player.properties.grab_animation:Play()
end

function AutoParry.perform_parry()
    local ball_properties = AutoParry.ball.properties

    if ball_properties.cooldown and not ball_properties.auto_spam then return end

    ball_properties.parries  += 1
    ball_properties.last_hit  = tick()

    local camera           = workspace.CurrentCamera
    local camera_direction = camera.CFrame.Position
    local direction        = camera.CFrame
    local target_position  = AutoParry.entity_properties.server_position

    if not ball_properties.auto_spam then
        AutoParry.perform_grab_animation()
        ball_properties.cooldown = true

        local current_curve = interface.flags['curve_method']

        if current_curve == 'Linear' then
            direction = CFrame.new(LocalPlayer.Character.PrimaryPart.Position, target_position)
        elseif current_curve == 'Backwards' then
            direction = CFrame.new(camera_direction, (camera_direction + (-camera.CFrame.LookVector * 10000)) + Vector3.new(0, 1000, 0))
        elseif current_curve == 'Random' then
            direction = CFrame.new(LocalPlayer.Character.PrimaryPart.Position, Vector3.new(math.random(-1000, 1000), math.random(-350, 1000), math.random(-1000, 1000)))
        elseif current_curve == 'Accelerated' then
            direction = CFrame.new(LocalPlayer.Character.PrimaryPart.Position, target_position + Vector3.new(0, 150, 0))
        end
    else
        direction = CFrame.new(camera_direction, target_position + Vector3.new(0, 60, 0))

        ball_properties.parry_remote:FireServer(
            0,
            direction,
            { [AutoParry.target.aim.Name] = target_position },
            { target_position.X, target_position.Y },
            false
        )

        task.delay(0.25, function()
            if ball_properties.parries > 0 then ball_properties.parries -= 1 end
        end)
        return
    end

    ball_properties.parry_remote:FireServer(
        0.5,
        direction,
        { [AutoParry.target.aim.Name] = target_position },
        { target_position.X, target_position.Y },
        false
    )

    task.delay(0.25, function()
        if ball_properties.parries > 0 then ball_properties.parries -= 1 end
    end)
end

function AutoParry.reset()
    AutoParry.ball.properties.is_curved              = false
    AutoParry.ball.properties.auto_spam              = false
    AutoParry.ball.properties.cooldown               = false
    AutoParry.ball.properties.maximum_speed          = 0
    AutoParry.ball.properties.parries                = 0
    AutoParry.entity_properties.server_position      = Vector3.zero
    AutoParry.target.current = nil
    AutoParry.target.from    = nil
end

ReplicatedStorage.Remotes.PlrHellHooked.OnClientEvent:Connect(function(hooker: Model)
    if hooker.Name == LocalPlayer.Name then
        AutoParry.ball.properties.hell_hook_completed = true
        return
    end
    AutoParry.ball.properties.hell_hook_completed = false
end)

ReplicatedStorage.Remotes.PlrHellHookCompleted.OnClientEvent:Connect(function()
    AutoParry.ball.properties.hell_hook_completed = true
end)

function AutoParry.is_curved()
    local target = AutoParry.target.current
    if not target then return false end

    local bp             = AutoParry.ball.properties
    local current_target = target.Name

    if target.PrimaryPart:FindFirstChild('MaxShield') and current_target ~= LocalPlayer.Name and bp.distance < 50 then
        return false
    end

    local ball = AutoParry.ball.ball_entity

    if ball:FindFirstChild('TimeHole1') and current_target ~= LocalPlayer.Name and bp.distance < 100 then
        bp.auto_spam = false
        return false
    end

    if ball:FindFirstChild('WEMAZOOKIEGO') and current_target ~= LocalPlayer.Name and bp.distance < 100 then
        return false
    end

    if ball:FindFirstChild('At2') and bp.speed <= 0 then return true end

    if ball:FindFirstChild('AeroDynamicSlashVFX') then
        Debris:AddItem(ball.AeroDynamicSlashVFX, 0)
        bp.auto_spam        = false
        bp.aero_dynamic_time = tick()
    end

    if RunTime:FindFirstChild('Tornado') then
        if bp.distance > 5 and (tick() - bp.aero_dynamic_time) < (RunTime.Tornado:GetAttribute("TornadoTime") or 1) + 0.314159 then
            return true
        end
    end

    if not bp.hell_hook_completed and target.Name == LocalPlayer.Name and bp.distance > 5 - math.random() then
        return true
    end

    local ball_direction  = bp.velocity.Unit
    local ball_speed      = bp.speed
    local speed_threshold = math.min(ball_speed / 100, 40)
    local angle_threshold = 40 * math.max(bp.dot, 0)
    local player_ping     = Player.Entity.properties.ping

    local accurate_direction   = bp.velocity.Unit * ball_direction
    local direction_difference = (accurate_direction - bp.velocity).Unit
    local accurate_dot         = bp.direction:Dot(direction_difference)
    local dot_difference       = bp.dot - accurate_dot
    local dot_threshold        = 0.5 - player_ping / 1000

    local reach_time             = bp.distance / bp.maximum_speed - (player_ping / 1000)
    local enough_speed           = bp.maximum_speed > 100
    local ball_distance_threshold = 15 - math.min(bp.distance / 1000, 15) + angle_threshold + speed_threshold

    if enough_speed and reach_time > player_ping / 10 then
        ball_distance_threshold = math.max(ball_distance_threshold - 15, 15)
    end

    if bp.distance < ball_distance_threshold then return false end
    if dot_difference < dot_threshold then return true end

    if bp.lerp_radians < 0.018 then
        bp.last_curve_position = bp.position
        bp.last_warping        = tick()
    end

    if (tick() - bp.last_warping) < (reach_time / 1.5) then return true end

    return bp.dot < dot_threshold
end

local old_from_target = nil

--[FIX 7] Definido con '.' y parámetro explícito en lugar de ':' para evitar
-- confusión: el caller pasaba una tabla como primer arg (que era self con ':').
function AutoParry.is_spam(self)
    local target = AutoParry.target.current
    if not target then return false end

    if AutoParry.target.from ~= LocalPlayer.Character then
        old_from_target = AutoParry.target.from
    end

    if self.parries < 3 and AutoParry.target.from == old_from_target then return false end

    local player_ping        = Player.Entity.properties.ping
    local distance_threshold = 18 + (player_ping / 80)
    local bp                 = AutoParry.ball.properties
    local reach_time         = bp.distance / bp.maximum_speed - (player_ping / 1000)

    if (tick() - self.last_hit) > 0.8 and self.entity_distance > distance_threshold and self.parries < 3 then
        self.parries = 1; return false
    end

    if bp.lerp_radians > 0.028 then
        if self.parries > 3 then self.parries = 1 end
        return false
    end

    if (tick() - bp.last_warping) < (reach_time / 1.3) and self.entity_distance > distance_threshold and self.parries < 4 then
        if self.parries > 3 then self.parries = 1 end
        return false
    end

    if math.abs(self.speed - self.old_speed) < 5.2 and self.entity_distance > distance_threshold and self.speed < 60 and self.parries < 3 then
        if self.parries > 3 then self.parries = 0 end
        return false
    end

    if self.speed < 10 then self.parries = 1; return false end

    if self.maximum_speed < self.speed and self.entity_distance > distance_threshold then
        self.parries = 1; return false
    end

    if self.entity_distance > self.range and self.entity_distance > distance_threshold then
        if self.parries > 2 then self.parries = 1 end
        return false
    end

    if self.ball_distance > self.range and self.entity_distance > distance_threshold then
        if self.parries > 2 then self.parries = 2 end
        return false
    end

    if self.last_position_distance > self.spam_accuracy and self.entity_distance > distance_threshold then
        if self.parries > 4 then self.parries = 2 end
        return false
    end

    if self.ball_distance > self.spam_accuracy and self.ball_distance > distance_threshold then
        if self.parries > 3 then self.parries = 2 end
        return false
    end

    if self.entity_distance > self.spam_accuracy and self.entity_distance > (distance_threshold - math.pi) then
        if self.parries > 3 then self.parries = 2 end
        return false
    end

    return true
end

function Player.claim_rewards()
    --[FIX 8] El repeat original podía quedar infinito si auto_spam nunca se desactivaba
    local deadline = tick() + 30
    repeat
        task.wait(1)
    until not AutoParry.ball.properties.auto_spam or tick() > deadline

    local net = ReplicatedStorage:WaitForChild("Packages")['_Index']['sleitnick_net@0.1.0'].net

    ReplicatedStorage:WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer('ClaimLoginReward')

    task.defer(function()
        for day = 1, 30 do
            task.wait()
            ReplicatedStorage.Remote.RemoteFunction:InvokeServer('ClaimNewDailyLoginReward', day)
            net:WaitForChild("RE/SummerWheel/ProcessRoll"):FireServer()
            net:WaitForChild("RE/SummerWheel/ClaimReward"):FireServer()
            net:WaitForChild("RE/ProcessTournamentEventRoll"):FireServer()
            net:WaitForChild("RE/CyborgWheel/ProcessRoll"):FireServer()
            net:WaitForChild("RE/SynthWheel/ProcessRoll"):FireServer()
            net:WaitForChild("RE/ProcessTournamentRoll"):FireServer()
            net:WaitForChild("RE/RolledReturnCrate"):FireServer()
            net:WaitForChild("RE/ProcessLTMRoll"):FireServer()
        end
    end)

    task.defer(function()
        for reward = 1, 6 do
            net:WaitForChild("RF/ClaimPlaytimeReward"):InvokeServer(reward)
            net:WaitForChild("RE/ClaimSeasonPlaytimeReward"):FireServer(reward)
            ReplicatedStorage:WaitForChild("Remote"):WaitForChild("RemoteFunction"):InvokeServer('SpinWheel')
            net:WaitForChild("RE/SpinFinished"):FireServer()
        end
    end)

    task.defer(function()
        for reward = 1, 5 do
            net:WaitForChild("RF/RedeemQuestsType"):InvokeServer('SummerClashEvent', 'Daily', reward)
        end
    end)

    task.defer(function()
        for reward = 1, 4 do
            net:WaitForChild("RE/SummerWheel/ClaimStreakReward"):FireServer(reward)
        end
    end)
end

-- ────────────────────────── RunService Loops ──────────────────────────

RunService:BindToRenderStep('server position simulation', 1, function()
    local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
    if not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return end

    local old_position = LocalPlayer.Character.PrimaryPart.Position

    task.delay(ping / 1000, function()
        Player.Entity.properties.server_position = old_position
    end)
end)

RunService.PreSimulation:Connect(function()
    NetworkClient:SetOutgoingKBPSLimit(math.huge)

    local character = LocalPlayer.Character
    if not character or not character.PrimaryPart then return end

    local props     = Player.Entity.properties
    props.sword     = character:GetAttribute('CurrentlyEquippedSword')
    props.ping      = Stats.Network.ServerStatsItem['Data Ping']:GetValue()
    props.velocity  = character.PrimaryPart.AssemblyLinearVelocity
    props.speed     = props.velocity.Magnitude
    props.is_moving = props.speed > 30
end)

AutoParry.ball.ball_entity        = AutoParry.get_ball()
AutoParry.ball.client_ball_entity = AutoParry.get_client_ball()

RunService.PreSimulation:Connect(function()
    local ball = AutoParry.ball.ball_entity
    if not ball then return end

    local zoomies = ball:FindFirstChild('zoomies')
    local bp      = AutoParry.ball.properties

    bp.position = ball.Position
    bp.velocity = ball.AssemblyLinearVelocity

    if zoomies then
        bp.velocity = zoomies.VectorVelocity
    end

    bp.distance  = (Player.Entity.properties.server_position - bp.position).Magnitude
    bp.speed     = bp.velocity.Magnitude
    bp.direction = (Player.Entity.properties.server_position - bp.position).Unit
    bp.dot       = bp.direction:Dot(bp.velocity.Unit)

    --[FIX 9] math.asin requiere valores en [-1,1]; sin clamp puede producir NaN
    bp.radians      = math.rad(math.asin(math.clamp(bp.dot, -1, 1)))
    bp.lerp_radians = linear_predict(bp.lerp_radians, bp.radians, 0.8)

    if bp.lerp_radians ~= bp.lerp_radians then  -- NaN guard
        bp.lerp_radians = 0.027
    end

    bp.maximum_speed = math.max(bp.speed, bp.maximum_speed)

    --[FIX 10] is_mobile nunca fue definido → se usa interface.mobile
    AutoParry.target.aim = (not interface.mobile and Player.get_closest_player_to_cursor() or Player.get_aim_entity())

    local ball_from   = ball:GetAttribute('from')
    local ball_target = ball:GetAttribute('target')

    if ball_from ~= nil then
        AutoParry.target.from = Alive:FindFirstChild(ball_from)
    end

    AutoParry.target.current = ball_target and Alive:FindFirstChild(ball_target)

    if AutoParry.target.current == nil then return end

    bp.rotation = bp.position

    if AutoParry.target.current.Name == LocalPlayer.Name then
        if AutoParry.target.aim and AutoParry.target.aim.PrimaryPart then
            bp.rotation = AutoParry.target.aim.PrimaryPart.Position
        end
        return
    end

    local target_pos = AutoParry.target.current.PrimaryPart.Position
    local target_vel = AutoParry.target.current.PrimaryPart.AssemblyLinearVelocity

    AutoParry.entity_properties.server_position = target_pos
    AutoParry.entity_properties.velocity        = target_vel
    AutoParry.entity_properties.distance        = LocalPlayer:DistanceFromCharacter(target_pos)
    AutoParry.entity_properties.direction       = (Player.Entity.properties.server_position - target_pos).Unit
    AutoParry.entity_properties.speed           = target_vel.Magnitude
    AutoParry.entity_properties.is_moving       = target_vel.Magnitude > 0.1
    AutoParry.entity_properties.dot             = AutoParry.entity_properties.is_moving and math.max(AutoParry.entity_properties.direction:Dot(target_vel.Unit), 0)
end)

-- ──────────────────────────── UI Setup ────────────────────────────────

--[FIX 11] Segunda declaración de 'local LocalPlayer' eliminada (era redundante)

local main    = interface.create({ name = 'Nurysium', parent = gethui() })
local blatant = main.create_tab('Blatant', 'rbxassetid://76028667326757')
local visuals = main.create_tab('Visuals', 'rbxassetid://18782727355')
local misc    = main.create_tab('Misc',    'rbxassetid://18782883071')

-- ─────────────────────────── Modules ──────────────────────────────────

do -- auto parry
    local auto_parry = blatant.create_module({ text = 'Auto Parry', flag = 'auto_parry', side = 'left' })
    auto_parry.create_toggle({ title = 'Rotation', flag = 'auto_parry_rotation' })
    auto_parry.create_slider({ value = 5, title = 'Acuity', flag = 'auto_parry_rotation_acuity' })
    auto_parry.create_dropdown({
        title = 'Curve Method', flag = 'curve_method',
        mods  = { 'Accelerated', 'Backwards', 'Linear', 'Camera', 'Random' }
    })
end

do -- win sound
    blatant.create_module({ text = 'Win Sound', flag = 'win_sound', side = 'right' })
end

do -- hit sound
    blatant.create_module({ text = 'Hit Sound', flag = 'hit_sound', side = 'right' })
end

do -- no slow
    blatant.create_module({ text = 'No Slow', flag = 'no_slow', side = 'right' })
end

do -- no render
    local no_render = visuals.create_module({ text = 'No Render', flag = 'no_render', side = 'right' })
    no_render.create_toggle({ title = 'Smart', flag = 'smart_no_render' })
end

do -- shaders
    local shaders = visuals.create_module({ text = 'Shaders', flag = 'shaders', side = 'left' })
    shaders.create_slider({ value = 50,  title = 'Intensity',      flag = 'shaders_intensity' })
    shaders.create_slider({ value = 70,  title = 'Size',           flag = 'shaders_size' })
    shaders.create_slider({ value = 100, title = 'Threshold',      flag = 'shaders_threshold' })
    shaders.create_slider({ value = 100, title = 'Diffuse Scale',  flag = 'environment_diffuse_scale' })
    shaders.create_slider({ value = 100, title = 'Specular Scale', flag = 'environment_specular_scale' })
    shaders.create_toggle({ title = 'Ray Tracing', flag = 'ray_tracing' })
end

do -- ambient
    local ambient = visuals.create_module({ text = 'Ambient', flag = 'ambient', side = 'right' })
    ambient.create_slider({ value = 50, title = 'Density', flag = 'ambient_density' })
end

do -- night mode
    visuals.create_module({ text = 'Night Mode', flag = 'night_mode', side = 'left' })
end

do -- plushie
    local plushie = visuals.create_module({ text = 'Plushie', flag = 'plushie', side = 'right' })
    plushie.create_dropdown({
        title = 'Plushie type', flag = 'plushie_type',
        mods  = { 'Pillow', 'Touhou', 'Shion', 'Miku', 'Sino', 'Soi' }
    })
end

do -- color shift
    visuals.create_module({ text = 'Color Shift', flag = 'color_shift', side = 'right' })
end

do -- skybox
    local skybox = visuals.create_module({ text = 'Skybox', flag = 'skybox', side = 'left' })
    skybox.create_toggle({ title = 'Remove Clouds', flag = 'remove_clouds' })
    skybox.create_dropdown({
        title = 'Skybox type', flag = 'skybox_type',
        mods  = { 'Anime','Rufus','Fantasy','Angelic','Clouded','Lyfestyle','Deepspace','Spongebob','Morning Mudd','Met Tha Devil' }
    })
end

do -- trail
    local trail = visuals.create_module({ text = 'Trail', flag = 'trail', side = 'right' })
    trail.create_slider({ value = 30, title = 'Scale', flag = 'trail_scale' })
end

do -- hit effect
    visuals.create_module({ text = 'Hit Effect', flag = 'hit_effect', side = 'left' })
end

do -- auto rewards
    misc.create_module({ text = 'Auto Rewards', flag = 'auto_rewards', side = 'right' })
end

do -- strafe
    local strafe = misc.create_module({ text = 'Strafe', flag = 'strafe', side = 'left' })
    strafe.create_slider({ value = 50, title = 'Speed', flag = 'strafe_speed' })
end

do -- personnel detector
    local personnel_detector = misc.create_module({ text = 'Personnel Detector', flag = 'personnel_detector', side = 'right' })
    personnel_detector.create_toggle({ title = 'Auto Leave', flag = 'personnel_detector_auto_leave' })
end

do -- gravity
    local gravity = misc.create_module({ text = 'Gravity', flag = 'gravity', side = 'left' })
    gravity.create_slider({ value = 50, title = 'Gravity', flag = 'gravity_strength' })
end

do -- camera
    local camera = misc.create_module({ text = 'Camera', flag = 'camera', side = 'right' })
    camera.create_slider({ value = 70, title = 'Field Of View', flag = 'field_of_view' })
end

do -- ability vulnerability
    local av = misc.create_module({ text = 'Ability Vulnerability', flag = 'ability_vulnerability', side = 'left' })
    av.create_dropdown({
        title = 'Mode', flag = 'ability_vulnerability_mode',
        mods  = { 'Continuity Zero', 'Quad Jump', 'Quasar' }
    })
end

do -- animations
    local animations = misc.create_module({ text = 'Animations', flag = 'animations', side = 'right' })
    animations.create_toggle({ title = 'Smart', flag = 'smart_animations' })

    local dropdown_emotes_table = {}
    local emote_instances       = {}

    for _, emote in ReplicatedStorage.Misc.Emotes:GetChildren() do
        local emote_name = emote:GetAttribute('EmoteName')
        if not emote_name then continue end
        table.insert(dropdown_emotes_table, emote_name)
        emote_instances[emote_name] = emote
    end

    animations.create_dropdown({ title = 'Animation', flag = 'animation_type', mods = dropdown_emotes_table })

    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.zero)
    end)

    local current_animation      = nil
    local current_animation_name = nil

    local looped_emotes = { "Emote108", "Emote225", "Emote300", "Emote301" }

    ConnectionsManager['animations'] = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character

        if not character then
            if current_animation then current_animation:Stop(); current_animation:Destroy() end
            current_animation = nil; current_animation_name = nil
            return
        end

        local humanoid = character:FindFirstChildOfClass('Humanoid')

        if not humanoid or humanoid.Health <= 0 then
            if current_animation then current_animation:Stop(); current_animation:Destroy() end
            current_animation = nil; current_animation_name = nil
            return
        end

        local animations_enabled = interface.flags['animations']
        local animation_type     = interface.flags['animation_type']

        if not animations_enabled then
            if current_animation then
                current_animation:Stop(); current_animation:Destroy()
                current_animation = nil; current_animation_name = nil
            end
            return
        end

        if interface.flags['smart_animations'] and Player.Entity.properties.is_moving then
            if current_animation then
                current_animation:Stop(); current_animation:Destroy()
                current_animation = nil; current_animation_name = nil
            end
            return
        end

        if not animation_type or current_animation_name == animation_type then return end

        if current_animation then
            current_animation:Stop(); current_animation:Destroy()
            current_animation = nil; current_animation_name = nil
        end

        local animation_object = emote_instances[animation_type]
        if not animation_object then return end

        local animator = humanoid:FindFirstChildOfClass('Animator')
        if not animator then return end

        local animation       = Instance.new('Animation')
        animation.AnimationId = animation_object.AnimationId

        current_animation      = animator:LoadAnimation(animation)
        current_animation_name = animation_type

        if not table.find(looped_emotes, animation_object.Name) then
            current_animation.Looped = true
        end

        local time_position = {}

        current_animation:GetMarkerReachedSignal('Pin'):Connect(function(state)
            time_position[state] = current_animation.TimePosition
        end)

        current_animation:GetMarkerReachedSignal('GOTO'):Connect(function(state)
            local tp = time_position[state]
            if tp then current_animation.TimePosition = tp end
        end)

        ReplicatedStorage.Remotes.CustomEmote:FireServer(true, animation_object.Name)
        current_animation:Play()
    end)
end

-- ─────────────────────────── Connections ──────────────────────────────

ConnectionsManager['camera_field_of_view'] = RunService.PostSimulation:Connect(function()
    if not workspace.CurrentCamera or not LocalPlayer.Character then return end

    local cam = workspace.CurrentCamera

    if not interface.flags['camera'] then
        cam.FieldOfView = 70
        return
    end

    cam.FieldOfView = interface.flags['field_of_view']

    if not AutoParry.ball.client_ball_entity or #workspace.Balls:GetChildren() == 0 then
        cam.CameraSubject = LocalPlayer.Character
    end
end)

local spamming_done = true

ConnectionsManager['ability_vulnerability'] = RunService.PostSimulation:Connect(function()
    if not interface.flags['ability_vulnerability'] then
        spamming_done = true; return
    end

    local character = LocalPlayer.Character
    if not character then return end
    if Player.Entity.properties.ping > 250 then return end
    if not spamming_done then return end

    local mode = interface.flags['ability_vulnerability_mode']
    if not mode then return end

    --[FIX 12] Nil check para character.Abilities[mode] antes de acceder a .Enabled
    local abilities = character:FindFirstChild('Abilities')
    if not abilities or not abilities:FindFirstChild(mode) then return end
    if not abilities[mode].Enabled then return end

    if mode == 'Quad Jump' then
        spamming_done = false
        for _ = 1, 3650 do ReplicatedStorage.Remotes.XtraJumped:FireServer() end
        spamming_done = true

    elseif mode == 'Continuity Zero' and AutoParry.target.current ~= LocalPlayer.Character then
        spamming_done = false
        ReplicatedStorage.Remotes.UseContinuityPortal:FireServer(
            CFrame.new(tick(), tick(), tick(), tick(), tick(), tick(), tick())
        )
        task.delay(20, function() spamming_done = true end)

    elseif mode == 'Quasar' then
        spamming_done = false
        ReplicatedStorage.Remotes.PlrQuasared:FireServer(AutoParry.target.aim)
        task.delay(0.085, function() spamming_done = true end)
    end
end)

ConnectionsManager['gravity'] = RunService.PostSimulation:Connect(function()
    if not LocalPlayer.Character then return end

    if not interface.flags['gravity'] then
        workspace.Gravity = 196.2; return
    end

    workspace.Gravity = 196.2 / (interface.flags['gravity_strength'] / 10)
end)

local function clear_skyboxes()
    for _, child in Lighting:GetChildren() do
        if child:IsA('Sky') then Debris:AddItem(child, 0) end
    end
end

Lighting.ChildAdded:Connect(function(child)
    if interface.disconnected then return end
    if not interface.flags['skybox'] then return end
    if not child:IsA('Sky') then return end

    --[FIX 13] selected_skybox era usado antes de su declaración 'local' más abajo
    -- → se declara directamente aquí con valor por defecto
    local selected_skybox = interface.flags['skybox_type'] or 'Anime'

    clear_skyboxes()

    local skybox = effects_folder.skyboxes:FindFirstChild(selected_skybox)
    if not skybox or Lighting:FindFirstChild(skybox.Name) then return end

    skybox:Clone().Parent = Lighting
end)

ConnectionsManager['skybox_connection'] = RunService.PostSimulation:Connect(function()
    local skybox_enabled  = interface.flags['skybox']
    local selected_skybox = interface.flags['skybox_type'] or 'Anime'
    local remove_clouds   = interface.flags['remove_clouds']

    if not skybox_enabled then
        clear_skyboxes()
        workspace.Terrain.Clouds.Enabled = true
        return
    end

    workspace.Terrain.Clouds.Enabled = not remove_clouds

    if not Lighting:FindFirstChild(selected_skybox) then
        clear_skyboxes()
        local skybox = effects_folder.skyboxes:FindFirstChild(selected_skybox)
        if not skybox or Lighting:FindFirstChild(skybox.Name) then return end
        skybox:Clone().Parent = Lighting
    end
end)

local staff_roles = { 'content creator', 'contributor', 'trial qa', 'tester', 'mod' }

Players.PlayerAdded:Connect(function(player)
    if LocalPlayer:IsFriendsWith(player.UserId) then
        notify.draw_notify('Friend ' .. player.Name .. ' joined!', 4)
    end

    if not interface.flags['personnel_detector'] then return end

    local player_role     = tostring(player:GetRoleInGroup(12836673)):lower()
    local player_is_staff = table.find(staff_roles, player_role)

    if player_is_staff then
        if interface.flags['personnel_detector_auto_leave'] then
            game:Shutdown(); return
        end
        notify.draw_notify('Personnel joined, ' .. player.Name .. ', role ' .. player_role .. '.', 30)
    end
end)

ConnectionsManager['strafe'] = RunService.PostSimulation:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return end
    if not interface.flags['strafe'] then return end

    local humanoid = LocalPlayer.Character.Humanoid
    if not humanoid then return end

    --[FIX 14] Magnitude nunca es negativo → la condición original '< 0' era siempre falsa
    if humanoid.MoveDirection.Magnitude <= 0 then return end

    local strength = interface.flags['strafe_speed']
    LocalPlayer.Character:TranslateBy(
        humanoid.MoveDirection * math.max(strength / 15, 2) * RunService.Heartbeat:Wait() * 10
    )
end)

ConnectionsManager['no_slow'] = RunService.PostSimulation:Connect(function()
    if not LocalPlayer.Character then return end
    if not interface.flags['no_slow'] then return end
    if not Alive:FindFirstChild(LocalPlayer.Name) then return end

    local humanoid = LocalPlayer.Character:FindFirstChild('Humanoid')
    if not humanoid then return end

    if humanoid.WalkSpeed < 36 then humanoid.WalkSpeed = 36 end
end)

task.defer(function()
    while task.wait(60) do
        if interface.flags['auto_rewards'] then
            Player.claim_rewards()
        end
    end
end)

ConnectionsManager['trail'] = RunService.PostSimulation:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return end

    local pp            = LocalPlayer.Character.PrimaryPart
    local trail_enabled = interface.flags['trail']

    if not trail_enabled then
        if pp:FindFirstChild('nurysium_trail') then
            Debris:AddItem(pp['nurysium_trail'], 0)
        end
        return
    end

    if pp:FindFirstChild('nurysium_trail') then
        local trail_obj          = pp['nurysium_trail']
        trail_obj.Position       = pp.Position
        local scale              = interface.flags['trail_scale'] / 100
        trail_obj['down_line'].Lifetime  = scale
        trail_obj['upper_line'].Lifetime = scale
        trail_obj['trail'].Lifetime      = scale
        return
    end

    local trail_template = effects_folder:FindFirstChild('Trail')
    if not trail_template then return end

    local cloned        = trail_template:Clone()
    cloned.Name         = 'nurysium_trail'
    cloned.Parent       = pp
end)

ConnectionsManager['color_shift'] = RunService.PostSimulation:Connect(function()
    if not workspace.CurrentCamera then return end

    if not interface.flags['color_shift'] then
        local cs = workspace.CurrentCamera:FindFirstChild('color_shift')
        if cs then
            cs.Saturation = 0; cs.Brightness = 0; cs.Contrast = 0
            Debris:AddItem(cs, 0)
        end
        return
    end

    if not workspace.CurrentCamera:FindFirstChild('color_shift') then
        local cloned   = color_shift_effect:Clone()
        cloned.Name    = 'color_shift'
        cloned.Parent  = workspace.CurrentCamera
    end

    local cs              = workspace.CurrentCamera['color_shift']
    cs.Saturation         = -0.7
    cs.Contrast           = 0.1
    Lighting.ExposureCompensation = -0.7
end)

local plushie_temp  = Instance.new('Folder', workspace)
plushie_temp.Name   = names_map['protected']

local function clear_all_plushies()
    for _, mesh in plushie_temp:GetChildren() do
        Debris:AddItem(mesh, 0)
    end
end

ConnectionsManager['plushie'] = RunService.RenderStepped:Connect(function()
    local plushie_enabled  = interface.flags['plushie']
    local selected_plushie = interface.flags['plushie_type']

    if not plushie_enabled then clear_all_plushies(); return end
    if not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return end

    local protected_name = names_map[selected_plushie]
    local t              = tick()
    local base_offset    = Vector3.new(-2 - math.cos(t / 2), 6.5 + math.cos(t / 2), -2 - math.sin(t / 2))

    if plushie_temp:FindFirstChild(protected_name) then
        local plushie     = plushie_temp[protected_name]
        local target_CFrame = LocalPlayer.Character.PrimaryPart.CFrame
            * CFrame.new(base_offset)
            * CFrame.Angles(0, math.rad(-90), 0)

        if selected_plushie == 'Miku' then
            target_CFrame = LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(base_offset)
        elseif selected_plushie == 'Sino' then
            target_CFrame = LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(base_offset)
                * CFrame.Angles(math.rad(90), 0, math.rad(260))
        elseif selected_plushie == 'Pillow' then
            target_CFrame = LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(base_offset)
                * CFrame.Angles(math.rad(180 - math.cos(t / 5) * 4), 0, math.rad(180 + math.cos(t / 8) * 4))
        elseif selected_plushie == 'Shion' then
            target_CFrame = LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(base_offset)
                * CFrame.Angles(math.rad(110), 0, math.rad(90))
        elseif selected_plushie == 'Soi' then
            target_CFrame = LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(base_offset)
        end

        create_animation(plushie, TweenInfo.new(1.45), { CFrame = target_CFrame })
    else
        clear_all_plushies()

        --[FIX 15] objects_folder nunca fue definido → se usa plushes_folder
        local new_plushie = plushes_folder:FindFirstChild(selected_plushie)
        if new_plushie then
            local clone   = new_plushie:Clone()
            clone.Parent  = plushie_temp
            clone.Name    = protected_name
        end
    end
end)

ConnectionsManager['night_mode'] = RunService.PostSimulation:Connect(function()
    local target_time = interface.flags['night_mode'] and 2.5 or 11.2

    --[FIX 16] Comparación exacta de flotantes (== 11.2, == 2.5) era poco fiable
    -- → se usa tolerancia de 0.01
    if math.abs(Lighting.ClockTime - target_time) < 0.01 then return end

    create_animation(Lighting, TweenInfo.new(1.6), { ClockTime = target_time })
end)

ConnectionsManager['shaders'] = RunService.PostSimulation:Connect(function()
    if not interface.flags['shaders'] then
        Lighting.Technology      = "ShadowMap"
        Lighting.Bloom.Intensity = 1
        Lighting.Bloom.Size      = 25
        Lighting.Bloom.Threshold = 1.75
        return
    end

    Lighting.EnvironmentSpecularScale = interface.flags['environment_specular_scale'] / 100
    Lighting.EnvironmentDiffuseScale  = interface.flags['environment_diffuse_scale']  / 100
    Lighting.Bloom.Intensity          = interface.flags['shaders_intensity'] / 150
    Lighting.Bloom.Size               = interface.flags['shaders_size']      / math.pi
    Lighting.Bloom.Threshold          = interface.flags['shaders_threshold'] / 135
    Lighting.Technology               = interface.flags['ray_tracing'] and "Future" or "ShadowMap"
end)

ConnectionsManager['ambient'] = RunService.PostSimulation:Connect(function()
    local ambient_enabled = interface.flags['ambient']
    local secured_name    = names_map['protected']

    if not ambient_enabled then
        local atmo = Lighting:FindFirstChild(secured_name)
        if atmo then
            create_animation(atmo, TweenInfo.new(2), { Density = 0 })
            Debris:AddItem(atmo, 2)
        end
        return
    end

    local atmo = Lighting:FindFirstChild(secured_name)

    if atmo then
        local density_strength = interface.flags['ambient_density'] / 100
        if math.abs(atmo.Density - density_strength) < 0.001 then return end
        create_animation(atmo, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { Density = density_strength })
        return
    end

    local atmosphere = effects_folder:FindFirstChildOfClass('Atmosphere')
    if not atmosphere then return end

    local cloned         = atmosphere:Clone()
    cloned.Parent        = Lighting
    cloned.Name          = secured_name
    cloned.Glare         = 0
    cloned.Density       = 0
end)

local is_respawned = false

workspace.Balls.ChildRemoved:Connect(function(child)
    is_respawned = false

    if child == AutoParry.ball.ball_entity then
        AutoParry.ball.ball_entity        = nil
        AutoParry.ball.client_ball_entity = nil
        ConnectionsManager.disconnect('on_target_change')
        AutoParry.reset()
    end
end)

workspace.Balls.ChildAdded:Connect(function()
    if is_respawned then return end
    is_respawned = true

    local bp          = AutoParry.ball.properties
    bp.respawn_time   = tick()

    AutoParry.ball.ball_entity        = AutoParry.get_ball()
    AutoParry.ball.client_ball_entity = AutoParry.get_client_ball()

    if not AutoParry.ball.ball_entity then return end

    ConnectionsManager['on_target_change'] = AutoParry.ball.ball_entity:GetAttributeChangedSignal('target'):Connect(function()
        --[FIX 17] 'target' no estaba en scope → se lee el atributo correctamente
        local current_target = AutoParry.ball.ball_entity:GetAttribute('target')

        if current_target == LocalPlayer.Name then
            bp.cooldown = false; return
        end

        bp.cooldown      = false
        bp.old_speed     = bp.speed
        bp.last_position = bp.position
        bp.parries      += 1

        task.delay(0.25, function()
            if bp.parries > 0 then bp.parries -= 1 end
        end)
    end)
end)

RunService.PreSimulation:Connect(function()
    if not AutoParry.ball.properties.auto_spam then return end
    AutoParry.perform_parry()
end)

local custom_win_audio = Instance.new('Sound', sounds_folder)

ReplicatedStorage.Remotes.WinnerText.OnClientEvent:Connect(function(winner_text: string)
    if not winner_text:find(LocalPlayer.DisplayName) then return end
    if not interface.flags['win_sound'] then return end

    if isfile('Nurysium/assets/win_round.mp3') then
        custom_win_audio.SoundId = getcustomasset('Nurysium/assets/win_round.mp3')
        custom_win_audio:Play()
    else
        notify.draw_notify('[Nurysium]: win sound is missing! add file in Nurysium/assets/win_round.mp3', 15)
    end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(slash: any, root: any)
    task.spawn(function()
        if root.Parent and root.Parent ~= LocalPlayer.Character then
            if root.Parent.Parent ~= Alive then return end
            AutoParry.ball.properties.cooldown = false
        end
    end)

    if AutoParry.ball.properties.auto_spam then
        AutoParry.perform_parry()
    end
end)

local custom_audio = Instance.new('Sound', sounds_folder)

ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
    if LocalPlayer.Character.Parent ~= Alive then return end
    if not Player.properties.grab_animation then return end

    Player.properties.grab_animation:Stop()

    local ball = AutoParry.get_client_ball()
    if not ball then return end

    if interface.flags['hit_sound'] then
        if isfile('Nurysium/assets/hit1.mp3') and isfile('Nurysium/assets/hit2.mp3') then
            custom_audio.SoundId = getcustomasset(`Nurysium/assets/hit{math.random(1, 2)}.mp3`)
            custom_audio:Play()
        else
            notify.draw_notify('[Nurysium]: hit sounds missing! add hit1.mp3 and hit2.mp3 in Nurysium/assets/', 15)
        end
    end

    local hit_effect_vfx = effects_folder:FindFirstChild('HitEffect')

    if hit_effect_vfx and interface.flags['hit_effect'] then
        local cloned   = hit_effect_vfx:Clone()
        cloned.Name    = names_map['protected']
        cloned.Parent  = ball
        cloned:Emit(10)
        Debris:AddItem(cloned, 3)
    end

    ball = nil
end)

local function look_at(primary_part, position, delta, radians)
    local pp_pos = Vector3.new(primary_part.Position.X, 0, primary_part.Position.Z)
    local tp_pos = Vector3.new(position.X, 0, position.Z)
    local lv     = primary_part.CFrame.LookVector
    local pp_lv  = Vector3.new(lv.X, 0, lv.Z).Unit

    local lerp_vector = pp_lv:Lerp((tp_pos - pp_pos).Unit, delta)

    if lerp_vector:Dot(pp_lv) < math.cos(math.rad(radians)) then
        lerp_vector = CFrame.Angles(0, math.rad(radians), 0) * pp_lv
    end

    primary_part.CFrame = CFrame.lookAt(primary_part.Position, primary_part.Position + lerp_vector)
end

ConnectionsManager['auto_parry_rotation'] = RunService.PostSimulation:Connect(function()
    if not interface.flags['auto_parry_rotation'] then return end

    local character = LocalPlayer.Character
    if not character or not character.PrimaryPart then return end

    local humanoid = character:FindFirstChildOfClass('Humanoid')
    if not humanoid or humanoid.Health <= 0 then return end

    if Dead:FindFirstChild(LocalPlayer.Name) then
        humanoid.AutoRotate = true; return
    end

    local ball = AutoParry.get_ball()
    if not ball then return end

    local acuity = interface.flags['auto_parry_rotation_acuity'] / 100
    local bp     = AutoParry.ball.properties

    if bp.speed < 10 or bp.distance < 20 + bp.speed / 2 then
        look_at(character.PrimaryPart, bp.rotation, acuity / 2, 25)
    else
        look_at(character.PrimaryPart, bp.rotation, acuity, 25)
    end
end)

ConnectionsManager['auto_parry'] = RunService.PostSimulation:Connect(function()
    if not interface.flags['auto_parry'] then AutoParry.reset(); return end

    local character = LocalPlayer.Character
    if not character then return end
    if character.Parent == Dead then AutoParry.reset(); return end
    if not AutoParry.ball.ball_entity then return end

    local bp          = AutoParry.ball.properties
    bp.is_curved      = AutoParry.is_curved()

    local player_ping    = Player.Entity.properties.ping
    local ping_threshold = math.clamp(player_ping / 10, 10, 16)
    local spam_accuracity  = bp.maximum_speed / 7    + ping_threshold
    local parry_accuracity = bp.maximum_speed / 11.5 + ping_threshold

    bp.spam_range  = ping_threshold + bp.speed / 2.3
    bp.parry_range = ping_threshold + bp.speed / math.pi

    if Player.Entity.properties.sword == 'Titan Blade' then
        bp.parry_range += 11
        bp.spam_range  += 2
    end

    local dist_to_last = LocalPlayer:DistanceFromCharacter(bp.last_position)

    local spam_params = {
        speed                  = bp.speed,
        spam_accuracy          = spam_accuracity,
        parries                = bp.parries,
        ball_speed             = bp.speed,
        last_hit               = bp.last_hit,
        ball_distance          = bp.distance,
        maximum_speed          = bp.maximum_speed,
        old_speed              = bp.old_speed,
        entity_distance        = AutoParry.entity_properties.distance,
        last_position_distance = dist_to_last,
    }

    if bp.auto_spam and AutoParry.target.current then
        spam_params.range = bp.spam_range / (3.15 - ping_threshold / 10)
        bp.auto_spam      = AutoParry.is_spam(spam_params)
    end

    if bp.auto_spam then return end

    if AutoParry.target.current and AutoParry.target.current.Name == LocalPlayer.Name then
        spam_params.range = bp.spam_range
        bp.auto_spam      = AutoParry.is_spam(spam_params)
    end

    if bp.auto_spam then return end
    if bp.is_curved then return end

    if bp.distance > bp.parry_range and bp.distance > parry_accuracity then return end
    if AutoParry.target.current and AutoParry.target.current ~= LocalPlayer.Character then return end

    AutoParry.perform_parry()

    task.spawn(function()
        repeat
            RunService.PreSimulation:Wait()
        until (tick() - bp.last_hit) > 1 - (ping_threshold / 100)
        bp.cooldown = false
    end)
end)

task.defer(function()
    RunTime.ChildAdded:Connect(function(child)
        local no_render    = interface.flags['no_render']
        local smart        = interface.flags['smart_no_render']
        local ability_vuln = interface.flags['ability_vulnerability']
        local client_fx    = LocalPlayer.PlayerScripts.EffectScripts.ClientFX

        if no_render then
            if AutoParry.ball.properties.auto_spam then
                AutoParry.perform_parry()
            end

            if smart and not ability_vuln and not AutoParry.ball.properties.auto_spam then
                client_fx.Enabled = true; return
            end

            client_fx.Enabled = false
            if child.Name == 'Tornado' then return end
            Debris:AddItem(child, 0)
            return
        end

        client_fx.Enabled = true
    end)
end)

task.delay(30, function()
    if interface.disconnected then return end
    local ping = Player.Entity.properties.ping

    if ping > 100 and ping < 200 then
        notify.draw_notify('[Warning]: Low connection speed, delays may occur.', 15)
    elseif ping >= 200 then
        notify.draw_notify('[Warning]: Critically slow connection speed, delays ensured.', 15)
    end
end)
