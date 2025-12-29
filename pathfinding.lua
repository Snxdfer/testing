local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local grid_size = 5
local max_iterations = 7000
local base_speed = 20
local max_speed = 50
local height_offset = 0.1
local search_radius = 10000
local max_up = 240
local max_down = 120
local rayParams = RaycastParams.new()
rayParams.IgnoreWater = true
rayParams.FilterType = Enum.RaycastFilterType.Exclude
local Raycast = {
    Ignored = { character },
    Ignorable = {
        "Items","Plane","Rain","RainSnow","RainFall","DirtRoad",
        "Doorways","SwingDoor","Closed","Hinge","Touch"
    }
}
local function UpdateFilter()
    rayParams.FilterDescendantsInstances = Raycast.Ignored
end
local function AddIgnore(child)
    if table.find(Raycast.Ignorable, child.Name) then
        table.insert(Raycast.Ignored, child)
        UpdateFilter()
    end
end
workspace.ChildAdded:Connect(AddIgnore)
workspace.ChildRemoved:Connect(function(child)
    local i = table.find(Raycast.Ignored, child)
    if i then
        table.remove(Raycast.Ignored, i)
        UpdateFilter()
    end
end)
for _, v in workspace:GetChildren() do AddIgnore(v) end
for _, v in CollectionService:GetTagged("Tree") do table.insert(Raycast.Ignored, v) end
for _, v in CollectionService:GetTagged("NoClipAllowed") do table.insert(Raycast.Ignored, v) end
for _, v in CollectionService:GetTagged("Door") do
    for _, p in ipairs(v:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = false
            table.insert(Raycast.Ignored, p)
        end
    end
end
UpdateFilter()
local noclipConn
local function EnableNoclip()
    if noclipConn then return end
    noclipConn = RunService.Stepped:Connect(function()
        for _, p in ipairs(character:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
            end
        end
    end)
end
local function DisableNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    for _, p in ipairs(character:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = true
        end
    end
end
local function NodeKey(v)
    return math.floor(v.X / grid_size) .. "," ..
           math.floor(v.Y / grid_size) .. "," ..
           math.floor(v.Z / grid_size)
end
local function Heuristic(a, b)
    return (a - b).Magnitude
end
local function IsFree(fromPos, toPos)
    return workspace:Raycast(fromPos, toPos - fromPos, rayParams) == nil
end
local function HasCeilingAt(pos)
    return workspace:Raycast(pos, Vector3.new(0, 999, 0), rayParams) ~= nil
end
local function HasObstacleAbove()
    return workspace:Raycast(hrp.Position, Vector3.new(0, 999, 0), rayParams) ~= nil
end
local function GetClearance(pos)
    local dirs = {
        Vector3.new(1,0,0),
        Vector3.new(-1,0,0),
        Vector3.new(0,0,1),
        Vector3.new(0,0,-1)
    }
    local minDist = math.huge
    for _, d in ipairs(dirs) do
        local r = workspace:Raycast(pos, d * 6, rayParams)
        if r then
            minDist = math.min(minDist, (r.Position - pos).Magnitude)
        end
    end
    return minDist
end
local function FindExitPoint(startPos, maxRadius)
    startPos += Vector3.new(0, height_offset, 0)
    local queue = { startPos }
    local visited = { [NodeKey(startPos)] = true }
    local dirs = {
        Vector3.new(1,0,0), Vector3.new(-1,0,0),
        Vector3.new(0,0,1), Vector3.new(0,0,-1),
        Vector3.new(0,1,0), Vector3.new(0,-1,0)
    }
    local iterations = 0
    while #queue > 0 do
        iterations += 1
        if iterations > max_iterations then return end
        local current = table.remove(queue, 1)
        if not HasCeilingAt(current) then
            return current
        end
        for _, dir in ipairs(dirs) do
            local nextPos = current + dir * grid_size
            local key = NodeKey(nextPos)
            local dy = nextPos.Y - startPos.Y
            local flatDist = Vector3.new(
                nextPos.X - startPos.X,
                0,
                nextPos.Z - startPos.Z
            ).Magnitude
            if not visited[key]
                and flatDist <= maxRadius
                and dy <= max_up
                and dy >= -max_down
                and IsFree(current, nextPos)
            then
                visited[key] = true
                table.insert(queue, nextPos)
            end
        end
    end
end
local directions = {
    Vector3.new(1,0,0), Vector3.new(-1,0,0),
    Vector3.new(0,0,1), Vector3.new(0,0,-1),
    Vector3.new(0,1,0), Vector3.new(0,-1,0)
}
local function FindPath(startPos, endPos)
    local openList, openSet, cameFrom, gScore, fScore = {}, {}, {}, {}, {}
    startPos += Vector3.new(0, height_offset, 0)
    endPos += Vector3.new(0, height_offset, 0)
    local startKey = NodeKey(startPos)
    openList[1] = startPos
    openSet[startKey] = true
    gScore[startKey] = 0
    fScore[startKey] = Heuristic(startPos, endPos)
    while #openList > 0 do
        local currentIndex, current = 1, openList[1]
        local currentKey = NodeKey(current)
        for i, node in ipairs(openList) do
            local k = NodeKey(node)
            if fScore[k] < fScore[currentKey] then
                current, currentKey, currentIndex = node, k, i
            end
        end
        table.remove(openList, currentIndex)
        openSet[currentKey] = nil
        if (current - endPos).Magnitude <= grid_size then
            local path = { endPos }
            while cameFrom[currentKey] do
                current = cameFrom[currentKey]
                currentKey = NodeKey(current)
                table.insert(path, 1, current)
            end
            path[#path] = endPos
            return path
        end
        for _, dir in ipairs(directions) do
            local neighbor = current + dir * grid_size
            local neighborKey = NodeKey(neighbor)
            if IsFree(current, neighbor) then
                local tentativeG = gScore[currentKey] + grid_size
                if not gScore[neighborKey] or tentativeG < gScore[neighborKey] then
                    cameFrom[neighborKey] = current
                    gScore[neighborKey] = tentativeG
                    fScore[neighborKey] = tentativeG + Heuristic(neighbor, endPos)
                    if not openSet[neighborKey] then
                        openSet[neighborKey] = true
                        table.insert(openList, neighbor)
                    end
                end
            end
        end
    end
end
local function SmoothPath(path)
    if not path or #path <= 2 then return path end
    local newPath = { path[1] }
    local idx = 1
    while idx < #path do
        local furthest = idx + 1
        for i = idx + 1, #path do
            if IsFree(path[idx], path[i]) then
                furthest = i
            else
                break
            end
        end
        table.insert(newPath, path[furthest])
        idx = furthest
    end
    return newPath
end
local function EnableFly()
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5,1e5,1e5)
    bv.P = 1250
    bv.Parent = hrp
    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
    bg.P = 4000
    bg.Parent = hrp
    return bv
end
local function DisableFly()
    for _, v in ipairs(hrp:GetChildren()) do
        if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
            v:Destroy()
        end
    end
end
local function MovePath(path)
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    humanoid.AutoRotate = false
    local bv = EnableFly()
    EnableNoclip()
    for _, point in ipairs(path) do
        local delta = point - hrp.Position
        local dist = delta.Magnitude
        if dist < 0.05 then continue end
        local clearance = GetClearance(hrp.Position)
        local speed = base_speed
        if clearance < 2.5 then
            speed = max_speed
        elseif clearance < 4 then
            speed = base_speed * 1.5
        end
        local time = dist / speed
        bv.Velocity = delta.Unit * speed
        local tween = TweenService:Create(
            hrp,
            TweenInfo.new(time, Enum.EasingStyle.Linear),
            { CFrame = CFrame.new(point) }
        )
        tween:Play()
        tween.Completed:Wait()
        bv.Velocity = Vector3.zero
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.CFrame = CFrame.new(point)
    end
    DisableFly()
    DisableNoclip()
    humanoid:ChangeState(Enum.HumanoidStateType.Running)
    humanoid.AutoRotate = true
end
local function Run(x, y, z)
    local targets = {}
    if typeof(x) == "Vector3" then
        targets = { x }
    elseif typeof(x) == "number" and typeof(y) == "number" and typeof(z) == "number" then
        targets = { Vector3.new(x, y, z) }
    elseif typeof(x) == "table" then
        for _, v in ipairs(x) do
            if typeof(v) == "Vector3" then
                table.insert(targets, v)
            end
        end
    end
    if #targets > 0 then
        for _, target in ipairs(targets) do
            local path = FindPath(hrp.Position, target)
            if path then
                MovePath(SmoothPath(path))
            end
        end
        return
    end
    while true do
        if not HasObstacleAbove() then
            break
        end
        local exitPoint = FindExitPoint(hrp.Position, search_radius)
        if not exitPoint then
            humanoid.Health = 0
            return
        end
        local path = FindPath(hrp.Position, exitPoint)
        if path then
            MovePath(SmoothPath(path))
        end
        task.wait(1)
    end
end
