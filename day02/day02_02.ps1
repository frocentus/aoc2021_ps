$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$horizontal = 0
$vertical = 0
$aim = 0
foreach($d in $data) {
    $parts = $d -split ' '
    $command = $parts[0]
    $value = [int]$parts[1]
    switch ($command) {
        'forward' { 
            $horizontal += $value 
            $vertical += ($aim * $value)
        }
        'down' { $aim += $value }
        'up' { $aim -= $value }
    }
}
$horizontal * $vertical