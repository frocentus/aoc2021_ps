$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$fishes = @{
    0 = 0
    1 = 0
    2 = 0
    3 = 0
    4 = 0
    5 = 0
    6 = 0
    7 = 0
    8 = 0
}
($data -split ',').ForEach({
    $age = [int]::Parse($_)
    $oldcount = $fishes.$age
    $newcount = $oldcount + 1
    $fishes.$age = $newcount
})

$round = 0

while ($round -lt 256) {

    $newfishes = $fishes.0
    $restartfishes = $fishes.0
    $fishes.0 = $fishes.1
    $fishes.1 = $fishes.2
    $fishes.2 = $fishes.3
    $fishes.3 = $fishes.4
    $fishes.4 = $fishes.5
    $fishes.5 = $fishes.6
    $fishes.6 = $fishes.7 + $restartfishes
    $fishes.7 = $fishes.8
    $fishes.8 = $newfishes

    $round++
}

$fishes.0 + $fishes.1 + $fishes.2 + $fishes.3 + $fishes.4 + $fishes.5 + $fishes.6 + $fishes.7 + $fishes.8 

