$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$fishes = $data
$round = 0
# this is wayyyy too slow
while ($round -lt 80) {
    $numbers = $fishes.Split(',')
    $newfishes = @()
    $newnumbers = $numbers.ForEach({
        $fish = [int]$_
        $fish--
        if ($fish -eq -1) {
            $newfishes += 8
            $fish = 6
        }
        $fish
    })
    $newnumbers += $newfishes
    $fishes =$($newnumbers -join ',')
    $round++
}

$fishes.Split(',').Count

