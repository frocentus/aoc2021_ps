$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$horizontal = 0
$vertical = 0
foreach($d in $data) {
    $parts = $d -split ' '
    $command = $parts[0]
    $value = [int]$parts[1]
    switch ($command) {
        'forward' { $horizontal += $value }
        'down' { $vertical += $value }
        'up' { $vertical -= $value }
    }
}
$horizontal * $vertical